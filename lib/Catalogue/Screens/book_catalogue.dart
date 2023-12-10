import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:inkwanderers_mobile/catalogue/models/book.dart';
// import 'package:inkwanderers_mobile/Mengelolabook/screen/detail.dart';


class BookPage extends StatefulWidget {
    const BookPage({Key? key}) : super(key: key);

    @override
    _BookPageState createState() => _BookPageState();
}

class _BookPageState extends State<BookPage> {

@override
Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();

    Future<List<Book>> fetchProduct() async {
        // TODO: Ganti URL dan jangan lupa tambahkan trailing slash (/) di akhir URL!
        var url = Uri.parse('http://127.0.0.1:8000/get_books_json/');
        var response = await http.get(
            url,
            headers: {"Content-Type": "application/json"},
        );

        // melakukan decode response menjadi bentuk json
        var data = jsonDecode(utf8.decode(response.bodyBytes));

        // melakukan konversi data json menjadi object Product
        List<Book> listbook = [];
        for (var d in data) {
            if (d != null) {
                listbook.add(Book.fromJson(d));
            }
        }
        return listbook;
    }


    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(05, 10, 48, 1),
          title: Container(
              child: Text(
            'Catalogue',
            style: TextStyle(color: Colors.white),
          )),
        ),
        body: FutureBuilder(
            // future: response,
            future: fetchProduct(),
            builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.data == null) {
                    return const Center(child: CircularProgressIndicator());
                } else {
                    if (!snapshot.hasData) {
                    return const Column(
                        children: [
                        Text(
                            "No books available",
                            style:
                                TextStyle(color: Color(0xff59A5D8), fontSize: 20),
                        ),
                        SizedBox(height: 8),
                        ],
                    );
                    } else {
                        return ListView.builder(
                            itemCount: snapshot.data!.length,
                            itemBuilder: (_, index) => ListTile(
                                title: Container(
                                        color: const Color(0xFFF3E8EA),
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 16, vertical: 12),
                                        padding: const EdgeInsets.all(20.0),
                                        
                                        child: Column(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [

                                            Text(
                                                "${snapshot.data![index].fields.title}".toUpperCase(),
                                                style: const TextStyle(
                                                fontSize: 35.0,
                                                fontWeight: FontWeight.bold,
                                                color: Color(0xFF45425A),
                                                ),
                                            ),

                                            Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                children: [
                                                    Image.network(
                                                        snapshot.data![index].fields.thumbnail,
                                                    ),
                                                    Column(
                                                        children:[
                                                            Text("Author: ${snapshot.data![index].fields.authors}",
                                                                style: const TextStyle(
                                                                fontSize: 20.0,
                                                                color: Color(0xFF45425A),
                                                                ),
                                                            ),
                                                            // RatingBarIndicator(
                                                            //     rating: snapshot.data![index].fields.rating,
                                                            //     direction: Axis.horizontal,
                                                            //     itemCount: 5,
                                                            //     // itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                                                            //     itemBuilder: (context, _) => Icon(
                                                            //         Icons.star,
                                                            //         color: Colors.amber,
                                                            //     ),
                                                            // )
                                                        ]
                                                        ),
                                                ],
                                            ),


                                        //     ElevatedButton(
                                        //         child: Icon(
                                        //             Icons.delete,
                                        //             size: 40.0,
                                        //             color: Colors.white,
                                        //         ),
                                        //         style: ButtonStyle(
                                        //             backgroundColor:
                                        //                 MaterialStateProperty.all(Colors.pink.shade400),
                                        //         ),
                                        //         onPressed: () async {
                                        //                 final response = await request.postJson(
                                        //                 "http://127.0.0.1:8000/editbook/remove-book-flutter/",
                                        //                 jsonEncode(<String, String>{
                                        //                     'pk': snapshot.data![index].pk.toString(),
                    
                                        //                 }));
                                        //                 if (response['status'] == 'success') {
                                        //                     ScaffoldMessenger.of(context)
                                        //                         .showSnackBar(const SnackBar(
                                        //                     content: Text("Item deleted!"),
                                        //                     ));
                                        //                     Navigator.pushReplacement(
                                        //                         context,
                                        //                         MaterialPageRoute(builder: (context) => BookPage()),
                                        //                     );
                                        //                 } else {
                                        //                     ScaffoldMessenger.of(context)
                                        //                         .showSnackBar(const SnackBar(
                                        //                         content:
                                        //                             Text("We ran into a problem, please try again."),
                                        //                     ));
                                        //                 }
                                        //             }
                                        //     )
                                            ],
                                        ),
                                        ),
                                // onTap: () {
                                // Navigator.push(
                                //     context,
                                //     MaterialPageRoute(
                                //         builder: (context) => Detail(
                                //         pk: snapshot.data![index].pk.toString(),
                                //         title: snapshot.data![index].fields.title,
                                //         authors: snapshot.data![index].fields.authors,
                                //         categories: snapshot.data![index].fields.categories,
                                //         thumbnail: snapshot.data![index].fields.thumbnail,
                                //         description: snapshot.data![index].fields.description,
                                //         published_year: snapshot.data![index].fields.publishedYear.toString(),
                                //         )
                                //     )
                                //     );
                                // },
                            ),
                        );
                    }
                }
            }));
    }
}