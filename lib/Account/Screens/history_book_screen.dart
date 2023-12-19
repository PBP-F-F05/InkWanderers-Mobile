import 'package:flutter/material.dart';
import 'package:inkwanderers_mobile/Account/Models/book_models.dart';
import 'package:inkwanderers_mobile/Account/Widgets/history_book_card.dart';
import 'package:inkwanderers_mobile/Catalogue/screens/book_catalogue.dart';
import 'package:inkwanderers_mobile/Widgets/navigation.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

class HistoryBookPage extends StatefulWidget {
  const HistoryBookPage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _HistoryBookPageState createState() => _HistoryBookPageState();
}

class _HistoryBookPageState extends State<HistoryBookPage> {
  Future<List<HistoryBookToBook>> fetchProduct(request) async {
    var response = await request
        .get("https://inkwanderers.my.id/account/get-history-book-json-flutter/");
    List<HistoryBookToBook> listCollection = [];
    for (var d in response) {
      if (d != null) {
        HistoryBookToBook historyBookToBook = HistoryBookToBook.fromJson(d);
        listCollection.add(historyBookToBook);
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
      bottomNavigationBar: const Navigation(position: 4,),
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
                      'Riwayat Buku',
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
              child: FutureBuilder<List<HistoryBookToBook>>(
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
                          'Borrow more books...',
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
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const CataloguePage(),
                                  ));
                            },
                            child: const Text(
                              'Browse Books',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
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
                        return HistoryBookToBookCard(snapshot.data![index]);
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
