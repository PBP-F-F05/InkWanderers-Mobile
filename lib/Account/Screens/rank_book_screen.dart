import 'package:flutter/material.dart';
import 'package:inkwanderers_mobile/Account/Models/book_models.dart';
import 'package:inkwanderers_mobile/Account/Widgets/rank_book_card.dart';
// import 'package:inkwanderers_mobile/collection/models/book.dart';
import 'package:inkwanderers_mobile/collection/screens/temp_katalog.dart';
// import 'package:inkwanderers_mobile/collection/widgets/book_card.dart';
import 'package:inkwanderers_mobile/Widgets/navigation.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:inkwanderers_mobile/Account/Models/book_models.dart';

class RankBookPage extends StatefulWidget {
  const RankBookPage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _RankBookPageState createState() => _RankBookPageState();
}

class _RankBookPageState extends State<RankBookPage> {
  TextEditingController _searchController = TextEditingController();
  Future<List<RankBookToBook>>? _futureProducts;

  Future<List<RankBookToBook>> fetchProduct(CookieRequest request, String search) async {
    var response = await request
        .get("https://inkwanderers.my.id/account/get-rank-book-json-flutter/");
    List<RankBookToBook> listCollection = [];
    for (var d in response) {
      if (d != null) {
        listCollection.add(RankBookToBook.fromJson(d));
      }
    }
    return listCollection;
  }

  // void handleInputChange(CookieRequest request, String input) {
  //   setState(() {
  //     _futureProducts = fetchProduct(request, input);
  //   });
  // }

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
              child: FutureBuilder<List<RankBookToBook>>(
                future:fetchProduct(request,"a"),
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
                        TextField(
                          // onChanged: handleInputChange(request, "a"),
                          controller: _searchController,
                          decoration: const InputDecoration(
                              hintText: 'Cari di sini ...',
                              labelText: 'Pencarian',
                              hintStyle: TextStyle(
                                color: Colors.grey,
                              ),
                              labelStyle: TextStyle(
                                color: Colors.grey,
                              )),
                        ),
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
                                    builder: (context) => const LihatBuku(),
                                  ));
                            },
                            child: const Text(
                              'Lihat Buku',
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
                        return RankBookToBookCard(snapshot.data![index]);
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
