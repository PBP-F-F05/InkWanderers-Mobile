// ignore_for_file: sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:inkwanderers_mobile/Catalogue/models/book.dart';
import 'package:inkwanderers_mobile/Catalogue/screens/book_catalogue.dart';
import 'package:inkwanderers_mobile/reviews/screens/addreview_form.dart';
import 'package:inkwanderers_mobile/reviews/screens/book_review.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import "dart:convert";

class BookCard extends StatelessWidget {
  final Book book;

  const BookCard(this.book, {super.key});

  void _showBookDetails(BuildContext context, request) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    String description = book.fields.description;

    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: screenHeight * 0.6,
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Text(book.fields.title,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: screenWidth * 0.4,
                    height: screenHeight * 0.41,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 233, 161, 17),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.network(book.fields.thumbnail),
                        const SizedBox(height: 5),
                        Text(
                          'Authors: ${book.fields.authors}',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontSize: 10, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          'Published Year: ${book.fields.publishedYear}',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontSize: 10, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 5),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Description:',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontSize: 10, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 5),
                      SizedBox(
                        width: screenWidth * 0.5,
                        height: screenHeight * 0.35,
                        child: SingleChildScrollView(
                          child: Text(
                            description,
                            textAlign: TextAlign.left,
                            style: const TextStyle(
                                fontSize: 10, fontWeight: FontWeight.normal),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 10),
              SizedBox(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                        children: [
                          Icon(Icons.star, size: 16),
                          Text("${(book.fields.reviewPoints.toDouble()/book.fields.reviewCount.toDouble()).toStringAsFixed(1)}", 
                            style: TextStyle(fontSize: 11)
                          ),
                          ElevatedButton(
                            onPressed: () async {
                              var response =
                                await request.postJson(
                                    'http://127.0.0.1:8000/collection/add_collection_flutter/',
                                    jsonEncode({
                                      "pk": book.pk.toString(),
                                    }));
                              if (response["status"] == false) {
                                ScaffoldMessenger.of(
                                    context)
                                  ..hideCurrentSnackBar()
                                  ..showSnackBar(
                                      const SnackBar(
                                          content: Text(
                                              "Koleksi ini telah mencapai batas maksimal.")));
                              } 
                              
                              else {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const CataloguePage(),
                                  ),
                                );
                              }
                            },
                            child: const Text("Add to Collection", style: TextStyle(fontSize: 11)
                            )),

                        ElevatedButton(
                          onPressed: () async {
                            var response =
                              await request.postJson(
                                  'http://127.0.0.1:8000/bookmarks/bookmark_book_flutter/',
                                  jsonEncode({
                                    "pk": book.pk.toString(),
                                  }));

                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (context) => const CataloguePage()),
                            );
                          },
                          child: const Text("Bookmark",style: TextStyle(fontSize: 11)
                          )),

                        ElevatedButton(
                          onPressed: () async {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => BookReviewPage(book:book)),
                            );
                          },
                          child: const Text("Reviews", style: TextStyle(fontSize: 11)
                          )),
                        ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 10.0,
      child: InkWell(
        onTap: () async {
          _showBookDetails(context, request);
        },
        child: Container(
          height: screenHeight * 0.3,
          width: screenWidth * 0.4,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                flex: 6,
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 8.0, left: 8.0, right: 8.0, bottom: 8.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Image.network(
                      book.fields.thumbnail,
                      fit: BoxFit.cover,
                      height: screenHeight * 0.3,
                      width: double.infinity,
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 4,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        book.fields.title,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                      const SizedBox(height: 3),
                      Text(
                        book.fields.authors,
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 14.0),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                      const SizedBox(height: 3),
                      Text(
                        book.fields.categories,
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 12.0),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
