import 'package:flutter/material.dart';
import 'package:inkwanderers_mobile/Account/Screens/change_password_screen.dart';
import 'package:inkwanderers_mobile/Account/Screens/login_screen.dart';
import 'package:inkwanderers_mobile/Account/Screens/register_screen.dart';
import 'package:inkwanderers_mobile/collection/screens/collections.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:inkwanderers_mobile/main.dart';
import 'package:inkwanderers_mobile/Account/Screens/profile_screen.dart';
import 'package:inkwanderers_mobile/Account/Models/account_models.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key, required this.title});

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
  Future<Profile> fetchProfile(CookieRequest request) async {
    // TODO: Ganti URL dan jangan lupa tambahkan trailing slash (/) di akhir URL!
    // print("Line 33");
    final response = await request
        .get("https://inkwanderers.my.id/account/get-profile-json/");
    Profile profile = Profile.fromJson(response);
    return profile;
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(05, 10, 48, 1),
          title: Container(
              child: Text(
            'Profile',
            style: TextStyle(color: Colors.white),
          )),
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
                  final data = snapshot.data as Profile;
                  return SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Center(
                            child: Container(
                          height: 150,
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(100.0),
                              child: Image.network(data.profilePictureUrl)),
                        )),
                        SizedBox(
                          height: 10,
                        ),
                        Center(
                          child: Text(data.user.username),
                        )
                      ],
                    ),
                  );
                }
              }
            }),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: 4,
          selectedItemColor: Color.fromRGBO(255, 80, 03, 1),
          unselectedItemColor: Color.fromRGBO(05, 10, 48, 1),
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.my_library_books),
              label: 'Collection',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.reviews_outlined),
              label: 'My Review',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.bookmark), label: 'Bookmark'),
            BottomNavigationBarItem(
                icon: Icon(Icons.account_circle), label: 'Profile'),
          ],
          onTap: (i) {
            if (i == 0) {
               Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const CollectionsPage(),
                                  ));
            }
            else if (i == 4) {
              showModalBottomSheet(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                backgroundColor: Color.fromRGBO(05, 10, 48, 1),
                context: context,
                builder: (BuildContext context) {
                  return Container(
                    height: 200,
                    // color: const Color.fromARGB(255, 42, 40, 33),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        // mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Expanded(
                            // width: double.infinity,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: Color.fromRGBO(
                                    05, 10, 48, 1), // Set the background color
                                onPrimary: Colors.white, // Set the text color
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      10.0), // Set the border radius
                                ),
                              ),
                              onPressed: () {
                                // Button click logic
                              },
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Halaman Profile'),
                                  Icon(Icons.chevron_right),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            // width: double.infinity,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: Color.fromRGBO(
                                    05, 10, 48, 1), // Set the background color
                                onPrimary: Colors.white, // Set the text color
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      0.0), // Set the border radius
                                ),
                              ),
                              onPressed: () {
                                // Button click logic
                              },
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Riwayat Buku'),
                                  Icon(Icons.chevron_right),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            // width: double.infinity,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: Color.fromRGBO(
                                    05, 10, 48, 1), // Set the background color
                                onPrimary: Colors.white, // Set the text color
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      0.0), // Set the border radius
                                ),
                              ),
                              onPressed: () {
                                // Button click logic
                              },
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Ranking Buku pernah Dipinjam'),
                                  Icon(Icons.chevron_right),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            // width: double.infinity,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: Color.fromRGBO(
                                    05, 10, 48, 1), // Set the background color
                                onPrimary: Colors.white, // Set the text color
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      0.0), // Set the border radius
                                ),
                              ),
                              onPressed: () {
                                Navigator.pushReplacement(context,
                                    MaterialPageRoute(builder: (context) {
                                  return ChangePasswordScreen();
                                }));
                              },
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Ganti Kata Sandi'),
                                  Icon(Icons.chevron_right),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            // width: double.infinity,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: Color.fromRGBO(
                                    05, 10, 48, 1), // Set the background color
                                onPrimary: Colors.white, // Set the text color
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      0.0), // Set the border radius
                                ),
                              ),
                              onPressed: () async {
                                Navigator.pushReplacement(context,
                                    MaterialPageRoute(builder: (context) {
                                  return RegisterScreen();
                                }));

                                request.logout(
                                    "https://inkwanderers.my.id/account/logout_flutter/");
                              },
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Logout'),
                                  Icon(Icons.logout),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }
          },
        )
        );
  }
}
