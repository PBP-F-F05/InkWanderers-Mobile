// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:inkwanderers_mobile/Account/Screens/change_password_screen.dart';
import 'package:inkwanderers_mobile/Account/Screens/history_book_screen.dart';
import 'package:inkwanderers_mobile/Account/Screens/profile_Screen.dart';
import 'package:inkwanderers_mobile/Account/Screens/rank_book_screen.dart';
import 'package:inkwanderers_mobile/Account/Screens/register_screen.dart';
import 'package:inkwanderers_mobile/collection/screens/collections.dart';
import 'package:inkwanderers_mobile/collection/screens/collections_admin.dart';
import 'package:inkwanderers_mobile/catalogue/screens/book_catalogue.dart';
import 'package:inkwanderers_mobile/catalogue/screens/admin_catalogue.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'dart:convert';
import 'package:inkwanderers_mobile/Widgets/navigation.dart';
import 'dart:convert';
import 'package:inkwanderers_mobile/collection/screens/menu.dart';
import 'package:inkwanderers_mobile/collection/screens/temp_katalog.dart';
import 'package:inkwanderers_mobile/reviews/screens/my_reviews.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:inkwanderers_mobile/bookmarks/screens/bookmark_page.dart';

class Navigation extends StatefulWidget {
  final int position;
  const Navigation({super.key, required this.position});

  @override
  _NavigationState createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  Future<void> handleNavigation(int index, CookieRequest request) async {
    var response = await request.get("http://127.0.0.1:8000/get-role/");
        if (index == 0) {
          if (response['status'] == 'admin') {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const CollectionsPageAdmin()),
            );
          } 

          else {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const CollectionsPage()),
            );
          }
        } 

        else if (index == 1) {
          if (response['status'] == 'admin') {

          }

          else {
            Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const MyReviewsPage()),
            );
          }
        }
        
        else if (index == 2) {
          if (response['status'] == 'admin') {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const CataloguePageAdmin()),
            );
          } 
          
          else {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const CataloguePage()),
            );
          }
        } 

        else if (index == 3) {
          if (response['status'] == 'admin') {

          }

          else {
          Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const BookmarksPage()),
            );
          }
        }

        else if (index == 4) {
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
                              return ProfilePage(
                                title: 'a',
                              );
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
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return const HistoryBookPage();
                            }));
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
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return const RankBookPage();
                            }));
                          },
                          child: const Row(
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
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        const RegisterScreen()),
                                (Route<dynamic> route) => false);

                            request.logout(
                                "http://127.0.0.1:8000/account/logout_flutter/");
                          },
                          child: const Row(
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
      }

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
      onTap: (i) => handleNavigation(i, request),
    );
  }
}

    

