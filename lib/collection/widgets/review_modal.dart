// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:inkwanderers_mobile/collection/models/book.dart';
import 'package:inkwanderers_mobile/collection/screens/collections.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

class ReviewModalPage extends StatefulWidget {
  final Book book;
  const ReviewModalPage(this.book, {super.key});

  @override
  State<ReviewModalPage> createState() => _ReviewModalPageState();
}

class _ReviewModalPageState extends State<ReviewModalPage> {
  final _formKey = GlobalKey<FormState>();
  List<int> ratingOptions = [1, 2, 3, 4, 5];
  int rating = 0;
  String review = "";

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    rating = ratingOptions.first;
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Dialog(
      insetPadding: EdgeInsets.symmetric(horizontal: screenWidth * 0.1),
      child: Container(
        width: screenWidth * 0.8,
        height: screenHeight * 0.6,
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    widget.book.fields.title,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    DropdownButtonFormField<int>(
                      decoration: const InputDecoration(
                        labelText: 'Rating',
                      ),
                      value: rating,
                      items:
                          ratingOptions.map<DropdownMenuItem<int>>((int value) {
                        return DropdownMenuItem<int>(
                          value: value,
                          child: Text(value.toString()),
                        );
                      }).toList(),
                      onChanged: (int? newValue) {
                        setState(() {
                          rating = newValue!;
                        });
                      },
                      validator: (value) =>
                          value == 0 ? 'Please select a rating' : null,
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        hintText: "Write your review here",
                        labelText: "Review",
                        alignLabelWithHint: true,
                      ),
                      onChanged: (value) => setState(() {
                        review = value;
                      }),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Review cannot be empty!";
                        }
                        return null;
                      },
                      maxLines: 8,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    width: screenWidth * 0.30,
                    child: ElevatedButton(
                      child: const Text('Cancel'),
                      onPressed: () async {
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                  SizedBox(
                    width: screenWidth * 0.30,
                    child: ElevatedButton(
                      child: const Text('Submit Review'),
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          await request.postJson(
                            'http://127.0.0.1:8000/collection/remove_collection_flutter/',
                            jsonEncode({
                              "pk": widget.book.pk
                                  .toString(),
                            }));
                          Navigator.of(context).pop();
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const CollectionsPage()),
                          );
                        }
                      },
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
