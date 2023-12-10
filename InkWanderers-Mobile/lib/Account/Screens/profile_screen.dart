import 'dart:js_util';

import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:inkwanderers_mobile/main.dart';
import 'package:inkwanderers_mobile/Account/Screens/profile_screen.dart';
import 'package:inkwanderers_mobile/Account/Models/account_models.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;

class ProfilePage extends StatefulWidget {
  const   ProfilePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  Future<List<Profile>> fetchProfile(CookieRequest request) async {
    // TODO: Ganti URL dan jangan lupa tambahkan trailing slash (/) di akhir URL!
  print("Line 33");
  final response = await request.get("http://127.0.0.1:8000/account/get-profile-json/");
  print("Line 35");
  print(response);
  // var url = Uri.parse('http://localhost:8000/account/get-profile-json/');
  // var response = await http.get(
  //   url,
  //   headers: {"Content-Type": "application/json"},
  // ).catchError((e){print(e);});
  // print(url);
  // print(response.body);
  var data;
  print("Line 39");
  // Directly decode response.body
  try{
    
  print(Profile.fromJson(response).user.username);  
}
  catch(e){
    print(e);
  }
  
  print("Line 42");

    // melakukan konversi data json menjadi object Product
    List<Profile> list_profile = [];
    for (var d in data) {
      if (d != null) {
        list_profile.add(Profile.fromJson(d));
      }
    }
    print("Line 53");
    return list_profile;
  }

  @override
  Widget build(BuildContext context) {
  final request = context.watch<CookieRequest>();

    return Scaffold(
        appBar: AppBar(
          title: const Text('Product'),
        ),
        // drawer: const LeftDrawer(),
        body: FutureBuilder(
            future: fetchProfile(request),
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
                      itemBuilder: (_, index) => InkWell(
                            onTap: () {
                              // Navigator.push(context,
                              //     MaterialPageRoute(builder: (context) {
                              //   // return DetailScreen(
                              //   //     // loggedInUser: widget.loggedInUser,
                              //   //     selectedItem: snapshot.data![index]);
                              // }));
                            },
                            child: Card(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 12),
                              // padding: const EdgeInsets.all(20.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "anjing",
                                    style: const TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  // Text("anjing3"),
                                  const SizedBox(height: 10),
                                  // Text(
                                  //     "${snapshot.data![index].fields.description}")
                                ],
                              ),
                            ),
                          ));
                }
              }
            }));
  }
}
