// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:inkwanderers_mobile/collection/models/book.dart';
import 'package:inkwanderers_mobile/collection/widgets/left_drawer.dart';
import 'package:inkwanderers_mobile/collection/widgets/navigation.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

class LihatBuku extends StatefulWidget {
  const LihatBuku({Key? key}) : super(key: key);

  @override
  _LihatBukuState createState() => _LihatBukuState();
}

class _LihatBukuState extends State<LihatBuku> {
  Future<List<Book>> fetchBooks(request) async {
    var response = await request.get(
      'http://127.0.0.1:8000/get_books_json/',
    );

    List<Book> listItem = [];
    for (var d in response) {
      if (d != null) {
        listItem.add(Book.fromJson(d));
      }
    }
    return listItem;
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    return Scaffold(
        appBar: AppBar(
          title: const Text('Katalog Buku'),
        ),
        bottomNavigationBar: const Navigation(),
        body: FutureBuilder(
            future: fetchBooks(request),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.data == null) {
                return const Center(child: CircularProgressIndicator());
              } else {
                if (!snapshot.hasData) {
                  return const Column(
                    children: [
                      Text(
                        "Tidak ada data produk.",
                        style:
                            TextStyle(color: Color(0xff59A5D8), fontSize: 20),
                      ),
                      SizedBox(height: 8),
                    ],
                  );
                } else {
                  return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (_, index) => Container(
                            margin: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 12),
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${snapshot.data![index].fields.title}",
                                  style: const TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Text("${snapshot.data![index].fields.authors}"),
                                const SizedBox(height: 10),
                                Text(
                                    "${snapshot.data![index].fields.categories}"),
                                const SizedBox(height: 10),
                                Row(
                                  children: [
                                    ElevatedButton(
                                      onPressed: () {},
                                      child: const Text('Add to Bookmark'),
                                    ),
                                    ElevatedButton(
                                      onPressed: () async {
                                        var response = await request.postJson(
                                            'http://127.0.0.1:8000/collection/add_collection_flutter/',
                                            jsonEncode({
                                              "pk": snapshot.data![index].pk
                                                  .toString(),
                                            }));

                                        if (response["status"] == false) {
                                          ScaffoldMessenger.of(context)
                                            ..hideCurrentSnackBar()
                                            ..showSnackBar(const SnackBar(
                                                content: Text(
                                                    "Koleksi ini telah mencapai batas maksimal.")));
                                        } else {
                                          Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  const LihatBuku(),
                                            ),
                                          );
                                        }
                                      },
                                      child: const Text('Add to Collection'),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ));
                }
              }
            }));
  }
}
