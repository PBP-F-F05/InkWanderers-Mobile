import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:inkwanderers_mobile/Catalogue/models/book.dart';
import 'package:inkwanderers_mobile/Catalogue/Screens/book_catalogue.dart';
import 'package:inkwanderers_mobile/reviews/models/review.dart';
import 'package:inkwanderers_mobile/reviews/screens/my_reviews.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:inkwanderers_mobile/main.dart';
class EditReviewFormPage extends StatefulWidget {
    final Review review;
    const EditReviewFormPage({Key? key, required this.review}) : super(key: key);

    @override
    State<EditReviewFormPage> createState() => _EditReviewFormPageState();
}

class _EditReviewFormPageState extends State<EditReviewFormPage> {
  final _formKey = GlobalKey<FormState>();

  late int selectedRating = widget.review.rating.toInt();
  List<int> ratingOptions = [1, 2, 3, 4, 5];
  // String _name = "";
  String _review = "";
    @override
    Widget build(BuildContext context) {
      final request = context.watch<CookieRequest>();
        return Scaffold(
          appBar: AppBar(
            title: Center(
              child: Text(
                'Tambah Rating untuk ${widget.review.book.title}',
              ),
            ),
            backgroundColor: Colors.indigo,
            foregroundColor: Colors.white,
          ),
          // drawer: const LeftDrawer(),
          body: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: const Text("Rating", style: TextStyle(fontSize: 20),),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: DropdownButton<int>(
                      value: selectedRating,
                      onChanged: (int? value) {
                        setState(() {
                          selectedRating = value ?? 1;
                        });
                      },
                      items: ratingOptions.map<DropdownMenuItem<int>>((int value) {
                        return DropdownMenuItem<int>(
                          value: value,
                          child: Text('$value'),
                        );
                      }).toList(),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      decoration: InputDecoration(
                        hintText: "Tuliskan review mu!",
                        labelText: "Review",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                      ),
                      onChanged: (String? value) {
                        setState(() {
                          _review = value!;
                        });
                      },
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return "Review tidak boleh kosong!";
                        }
                        return null;
                      },
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.indigo),
                        ),
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                              // Kirim ke Django dan tunggu respons
                              // TODO: Ganti URL dan jangan lupa tambahkan trailing slash (/) di akhir URL!
                              final response = await request.postJson(
                              "https://inkwanderers.my.id/reviews/edit-review-flutter/${widget.review.id}",
                              jsonEncode(<String, String>{
                                  // 'name': _name,

                                  'rating': selectedRating.toString(),
                                  'review': _review,
                                  // TODO: Sesuaikan field data sesuai dengan aplikasimu
                              }));
                              if (response['status'] == 'success') {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(const SnackBar(
                                  content: Text("Review berhasil disimpan!"),
                                  ));
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(builder: (context) => MyReviewsPage()),
                                  );
                              } else {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(const SnackBar(
                                      content:
                                          Text("Terdapat kesalahan, silakan coba lagi."),
                                  ));
                              }
                          }
                      },
                        child: const Text(
                          "Save",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ]
              ),
            ),
          ),
        );
    }
}