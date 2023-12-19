import 'package:flutter/material.dart';
import 'package:inkwanderers_mobile/Catalogue/models/book.dart';
import 'package:inkwanderers_mobile/Catalogue/widgets/book_card.dart';
import 'package:inkwanderers_mobile/Widgets/navigation.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

class CataloguePage extends StatefulWidget {
  const CataloguePage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _CataloguePageState createState() => _CataloguePageState();
}

class _CataloguePageState extends State<CataloguePage> {
  Future<List<Book>> fetchProduct(request) async {
    var response = await request
        .get("https://inkwanderers.my.id/get_books_json/");

    List<Book> listCollection = [];
    for (var d in response) {
      if (d != null) {
        listCollection.add(Book.fromJson(d));
      }
    }
    return listCollection;
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      bottomNavigationBar: const Navigation(position: 0,),
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
                      'Catalogue',
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
              child: FutureBuilder<List<Book>>(
                future: fetchProduct(request),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (!snapshot.hasData ||
                      snapshot.data!.isEmpty ||
                      snapshot.hasError) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: 100),
                        const Text(
                          'No books available :(',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.05),
                        SizedBox(
                          width: screenWidth * 0.6,
                        ),
                      ],
                    );
                  } else {
                    return GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        childAspectRatio: 1 / 2,
                      ),
                      primary: false,
                      shrinkWrap: true,
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return BookCard(snapshot.data![index]);
                      },
                    );
                  }
                },
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
