// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:inkwanderers_mobile/Account/Screens/change_password_screen.dart';
import 'package:inkwanderers_mobile/Account/Screens/profile_Screen.dart';
import 'package:inkwanderers_mobile/Account/Screens/register_screen.dart';
import 'package:inkwanderers_mobile/collection/screens/collections.dart';
import 'package:inkwanderers_mobile/collection/screens/menu.dart';
import 'package:inkwanderers_mobile/collection/screens/temp_katalog.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

class Navigation extends StatefulWidget {
  const Navigation({super.key});

  @override
  _NavigationState createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    return BottomNavigationBar(
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
        BottomNavigationBarItem(icon: Icon(Icons.bookmark), label: 'Bookmark'),
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
        } else if (i == 4) {
          showModalBottomSheet(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
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
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return ProfilePage(title: 'a',);
                            }));
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
    );
  }
}