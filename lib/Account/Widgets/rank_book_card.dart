// ignore_for_file: sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:inkwanderers_mobile/Account/Models/book_models.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

class RankBookToBookCard extends StatelessWidget {
  final RankBookToBook rankBookToBook;

  const RankBookToBookCard(this.rankBookToBook, {super.key});

  void _showBookDetails(BuildContext context, request) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    String description = rankBookToBook.book.description;

    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Text(rankBookToBook.book.title,
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Flexible(
                    flex: 1,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.network(rankBookToBook.book.thumbnail),
                        const SizedBox(height: 5),
                        Text(
                          'Authors: ${rankBookToBook.book.authors}',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontSize: 10, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          'Published Year: ${rankBookToBook.book.publishedYear}',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontSize: 10, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  // const SizedBox(width: 5),
                  Flexible(
                    flex: 1,
                    child: Column(
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
          height: screenHeight * 0.5,
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
                      rankBookToBook.book.thumbnail,
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
                        rankBookToBook.book.title,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                      const SizedBox(height: 5),
                      Text(
                        rankBookToBook.book.authors,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 14.0,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                     const SizedBox(height: 5),
                     Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.book),
                        SizedBox(width: 1,),
                        Text(
                          rankBookToBook.booksCount.toString(),
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 11.0,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ],
                     )
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
