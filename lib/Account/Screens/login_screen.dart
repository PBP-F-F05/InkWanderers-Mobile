import 'package:flutter/material.dart';
import 'package:inkwanderers_mobile/Account/Screens/register_screen.dart';
import 'package:inkwanderers_mobile/account/screens/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

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
                  LoginMobileScreen()
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
                      'Ayo mulai belanja',
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Expanded(child: LoginMobileScreen())
              ],
            );
          }
        },
      ),
    );
  }
}

class LoginMobileScreen extends StatefulWidget {
  const LoginMobileScreen({Key? key}) : super(key: key);

  @override
  _LoginMobileScreen createState() => _LoginMobileScreen();
}

class _LoginMobileScreen extends State<LoginMobileScreen> {
  bool visiblePassword = true;
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

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
                      child: const Text('Masuk'),
                      onPressed: () async {
                        String username = _usernameController.text;
                        String password = _passwordController.text;

                        // Cek kredensial
                        // TODO: Ganti URL dan jangan lupa tambahkan trailing slash (/) di akhir URL!
                        // Untuk menyambungkan Android emulator dengan Django pada localhost,
                        // gunakan URL http://10.0.2.2/
                        final response = await request
                            .login("http://localhost:8000/auth/login/", {
                          'username': username,
                          'password': password,
                        });

                        if (request.loggedIn) {
                          String message = response['message'];
                          String uname = response['username'];
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    ProfilePage(title: "Test")),
                          );
                          ScaffoldMessenger.of(context)
                            ..hideCurrentSnackBar()
                            ..showSnackBar(SnackBar(
                                content:
                                    Text("$message Selamat datang, $uname.")));
                        } else {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const Text('Login Gagal'),
                              content: Text(response['message']),
                              actions: [
                                TextButton(
                                  child: const Text('OK'),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                ),
                              ],
                            ),
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
        const SizedBox(height: 20),
        Center(
            child: TextButton(
          child: const Text(
            "Belum punya akun",
            style: TextStyle(color: Color.fromRGBO(255, 80, 03, 1)),
          ),
          onPressed: () {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
              return const RegisterScreen();
            }));
          },
        )),
        const SizedBox(height: 150),
      ],
    ));
  }
}
