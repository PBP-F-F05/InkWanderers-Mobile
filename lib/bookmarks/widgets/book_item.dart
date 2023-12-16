// ignore_for_file: sized_box_for_whitespace, avoid_unnecessary_containers, use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:inkwanderers_mobile/bookmarks/screens/bookmark_page.dart';
import 'package:inkwanderers_mobile/collection/models/book.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

class BookItem extends StatelessWidget {
  final Book book;

  const BookItem(this.book, {super.key});

  void _showBookDetails(BuildContext context, request) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    String description = book.fields.description;
    String title = book.fields.title;
    if (title.length > 40) {
      title = "${title.substring(0, 40)}...";
    }

    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: screenHeight * 0.6,
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Text(title,
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: screenWidth * 0.4,
                    height: screenHeight * 0.4,
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
                width: screenWidth * 0.4,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Row(
                      children: [
                        Icon(Icons.star),
                        Text("5"),
                      ],
                    ),
                    SizedBox(
                      child: ElevatedButton(
                          onPressed: () async {
                            await request.postJson(
                                'http://127.0.0.1:8000/bookmarks/remove_bookmark_flutter/',
                                jsonEncode({
                                  "pk": book.pk.toString(),
                                }));
                            Navigator.pop(context);
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const BookmarksPage(),
                              ),
                            );
                          },
                          child: const Text("Remove Bookmark")),
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
          width: screenWidth * 0.8,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    top: 8.0, left: 8.0, right: 8.0, bottom: 8.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: Image.network(
                    book.fields.thumbnail,
                  ),
                ),
              ),
              Container(
                height: screenHeight * 0.4,
                width: screenWidth * 0.6,
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 233, 161, 17),
                ),
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
                      ),
                      const SizedBox(height: 5),
                      Text(
                        book.fields.authors,
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 14.0),
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
