import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:inkwanderers_mobile/Account/Screens/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:inkwanderers_mobile/Account/Screens/login_screen.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth < 600) {
            return const SafeArea(
                child: SingleChildScrollView(
              child: Column(
                children: [
                  Center(
                    child: Text(
                      "InkWanderers",
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                  ),
                  RegisterMobileScreen()
                ],
              ),
            ));
          } else {
            return const Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: Center(
                    child: Text(
                      'InkWanderers',
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Expanded(child: 
                
                SingleChildScrollView(child: RegisterMobileScreen()))
              ],
            );
          }
        },
      ),
    );
  }
}

class RegisterMobileScreen extends StatefulWidget {
  const RegisterMobileScreen({Key? key}) : super(key: key);

  @override
  _RegisterMobileScreen createState() => _RegisterMobileScreen();
}

class _RegisterMobileScreen extends State<RegisterMobileScreen> {
  bool visiblePassword = true;
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  static const List<String> items = <String>['Admin', 'User'];
  String dropdownvalue = 'Admin';
  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();

    return Center(
        child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: 20),
        Container(
          padding: const EdgeInsets.all(20),
          margin: const EdgeInsets.all(20),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(5),
                child: TextField(
                  controller: _usernameController,
                  decoration: const InputDecoration(
                      hintText: 'Ketik username kamu di sini...',
                      labelText: 'Username',
                      hintStyle: TextStyle(
                        color: Colors.grey,
                      ),
                      labelStyle: TextStyle(
                        color: Colors.grey,
                      )),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                  padding: const EdgeInsets.all(5),
                  child: TextField(
                    obscureText: visiblePassword,
                    enableSuggestions: false,
                    autocorrect: false,
                    controller: _passwordController,
                    decoration: const InputDecoration(
                        hintText: 'Ketik kata sandi kamu di sini...',
                        labelText: 'Kata sandi',
                        hintStyle: TextStyle(
                          color: Colors.grey,
                        ),
                        labelStyle: TextStyle(
                          color: Colors.grey,
                        )),
                  )),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(5),
                child: DropdownButton(
                  // Initial Value
                  value: dropdownvalue,

                  // Down Arrow Icon
                  icon: const Icon(Icons.keyboard_arrow_down),

                  // Array list of items
                  items: items.map((String items) {
                    return DropdownMenuItem(
                      value: items,
                      child: Text(items),
                    );
                  }).toList(),
                  // After selecting the desired option,it will
                  // change button value to selected value
                  onChanged: (String? newValue) {
                    setState(() {
                      dropdownvalue = newValue!;
                    });
                  },
                ),
              ),
              Row(children: [
                Checkbox(
                  value: !visiblePassword,
                  onChanged: (bool? value) {
                    setState(() {
                      visiblePassword = !(value!);
                    });
                  },
                ),
                const Text("Lihat password"),
              ]),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Color.fromRGBO(255, 80, 03, 1)),
                      child: const Text('Daftar'),
                      onPressed: () async {
                        String username = _usernameController.text;
                        String password = _passwordController.text;
                        String role = dropdownvalue;

                        if (role == 'Admin') {
                          role = '1';
                        } else {
                          role = '2';
                        }
                        // Cek kredensial
                        // TODO: Ganti URL dan jangan lupa tambahkan trailing slash (/) di akhir URL!
                        // Untuk menyambungkan Android emulator dengan Django pada localhost,
                        // gunakan URL http://10.0.2.2/
                        final Uri url = Uri.parse(
                            "https://inkwanderers.my.id/auth/register/");

                        final response = await http.post(
                          url,
                          body: {
                            'username': username,
                            'password': password,
                            'role': role,
                          },
                        );

                        if (response.statusCode == 201) {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginScreen()),
                          );
                          ScaffoldMessenger.of(context)
                            ..hideCurrentSnackBar()
                            ..showSnackBar(SnackBar(
                                content: Text("Berhasil mendaftar $username")));
                        } else if (response.statusCode == 500) {
                          ScaffoldMessenger.of(context)
                            ..hideCurrentSnackBar()
                            ..showSnackBar(SnackBar(
                                content: Text(
                                    "Maaf, username $username telah terdaftar")));
                        } else {
                          ScaffoldMessenger.of(context)
                            ..hideCurrentSnackBar()
                            ..showSnackBar(SnackBar(
                                content: Text("Maaf, pendaftaran gagal!")));
                        }
                      },
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
        const SizedBox(height: 20),
        Center(
            child: TextButton(
          child: const Text(
            "Sudah punya akun",
            style: TextStyle(color: Color.fromRGBO(255, 80, 03, 1)),
          ),
          onPressed: () {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
              return const LoginScreen();
            }));
          },
        )),
        const SizedBox(height: 150),
      ],
    ));
  }
}
