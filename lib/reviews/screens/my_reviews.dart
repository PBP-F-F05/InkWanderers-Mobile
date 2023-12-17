import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:inkwanderers_mobile/Widgets/navigation.dart';
import 'dart:convert';
import 'package:inkwanderers_mobile/collection/models/book.dart' as BookModel;
import 'package:inkwanderers_mobile/reviews/models/review.dart';
import 'package:inkwanderers_mobile/reviews/screens/book_review.dart';
import 'package:inkwanderers_mobile/reviews/screens/editreview_form.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
// import 'package:inkwanderers_mobile/reviews/models/book_temp.dart';

class MyReviewsPage extends StatefulWidget {
  const MyReviewsPage({Key? key}) : super(key: key);

  @override
  State<MyReviewsPage> createState() => _MyReviewsPageState();
}

class _MyReviewsPageState extends State<MyReviewsPage> {
  Future<List<Review>> fetchProduct(CookieRequest request) async {
    // TODO: Ganti URL dan jangan lupa tambahkan trailing slash (/) di akhir URL!
    // var url = Uri.parse(
    //     'http://127.0.0.1:8000/reviews/get-review/');
    var response =
        await request.get("http://127.0.0.1:8000/reviews/get-review/");

    // melakukan decode response menjadi bentuk json
    // melakukan konversi data json menjadi object Product

    List<Review> list_product = [];
    // print("${response}");
    for (var d in response) {
      if (d != null) {
        Review r = Review.fromJson(d);
        // print("work?");
        list_product.add(r);
      }
    }
    return list_product;
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
        bottomNavigationBar: const Navigation(position: 1),

        // drawer: const LeftDrawer(),
        body: SingleChildScrollView(
          child: Column(
            
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  Image.network(
                    'https://live.staticflickr.com/7309/9341506761_29518a0c15_b.jpg',
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: screenHeight * 0.2,
                  ),
                  const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'My Reviews',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 60,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  )
                ],
              ),
              const SizedBox(height: 20),
        
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: FutureBuilder(
                  future: fetchProduct(request),
                  builder: (context, AsyncSnapshot snapshot) {
                    if (snapshot.data == null) {
                      return const Center(child: CircularProgressIndicator());
                    } else {
                      if (!snapshot.hasData) {
                        return const Column(
                          children: [
                            Text(
                              "Tidak ada data review.",
                              style: TextStyle(
                                  color: Color(0xff59A5D8), fontSize: 20),
                            ),
                            SizedBox(height: 8),
                          ],
                        );
                      } else {
                        final data = snapshot.data as List<Review>;
                        return ListView.builder(
                          shrinkWrap: true,
                            itemCount: snapshot.data!.length,
                            itemBuilder: (_, index) => InkWell(
                                onTap: () async {
                                  var response = await request.get(
                                      'http://127.0.0.1:8000/reviews/get-book/${data[index].book.id}');
                                  BookModel.Book bookJson =
                                      BookModel.Book.fromJson(response[0]);
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          BookReviewPage(book: bookJson),
                                    ),
                                  );
                                },
                                child: Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 12),
                                  padding: const EdgeInsets.all(20.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        data[index].book.title,
                                        style: const TextStyle(
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      Text("Author: ${data[index].book.authors}"),
                                      const SizedBox(height: 10),
                                      Text("My Rating: ${data[index].rating}"),
                                      const SizedBox(height: 10),
                                      Text(data[index].review),
                                      ElevatedButton(
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  EditReviewFormPage(
                                                      review: data[index]),
                                            ),
                                          );
                                        },
                                        child: const Text('Edit review'),
                                      ),
                                    ],
                                  ),
                                )));
                      }
                    }
                  }),
            ),
          ]),
        ));
  }
}
