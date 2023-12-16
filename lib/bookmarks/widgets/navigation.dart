// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:inkwanderers_mobile/collection/screens/collections.dart';
import 'package:inkwanderers_mobile/collection/screens/menu.dart';
import 'package:inkwanderers_mobile/collection/screens/temp_katalog.dart';

class Navigation extends StatefulWidget {
  const Navigation({super.key});

  @override
  _NavigationState createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {


  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      notchMargin: 4.0,
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          IconButton(
            icon: const Icon(Icons.home),
            onPressed: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MyHomePage(),
                  ));
            },
            color: const Color.fromARGB(255, 233, 161, 17),
          ),
          IconButton(
            icon: const Icon(Icons.add_shopping_cart),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LihatBuku(),
                  ));
            },
            color: const Color.fromARGB(255, 233, 161, 17),
          ),
          IconButton(
            icon: const Icon(Icons.book),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CollectionsPage(),
                  ));
            },
            color: const Color.fromARGB(255, 233, 161, 17),
          ),
          IconButton(
            icon: const Icon(Icons.bookmark),
            onPressed: () {
              // Navigator.pushReplacement(
              //     context,
              //     MaterialPageRoute(
              //       builder: (context) => MyHomePage(),
              //     ));
            },
            color: const Color.fromARGB(255, 233, 161, 17),
          ),
          
        ],
      ),
    );
  }
}