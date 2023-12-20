import 'package:flutter/material.dart';
import 'package:inkwanderers_mobile/Account/Screens/register_screen.dart';
import 'package:inkwanderers_mobile/Account/Screens/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(5, 10, 48, 1),
        title: Container(
          child: Text(
            'Ganti Password',
            style: TextStyle(color: Colors.white),
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            // Pop the current route and go back to the previous screen
            Navigator.pop(context);
          },
        ),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth < 600) {
            return const SafeArea(
                child: SingleChildScrollView(
              child: Column(
                children: [
                  ChangePasswordMobileScreen()
                ],
              ),
            ));
          } else {
            return const Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(child: SingleChildScrollView(child: ChangePasswordMobileScreen()))
              ],
            );
          }
        },
      ),
    );
  }
}

class ChangePasswordMobileScreen extends StatefulWidget {
  const ChangePasswordMobileScreen({Key? key}) : super(key: key);

  @override
  _ChangePasswordMobileScreen createState() => _ChangePasswordMobileScreen();
}

class _ChangePasswordMobileScreen extends State<ChangePasswordMobileScreen> {
  bool visiblePassword = true;
  TextEditingController _old_passwordController = TextEditingController();
  TextEditingController _new_password1 = TextEditingController();
  TextEditingController _new_password2 = TextEditingController();


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
                  
                  obscureText: visiblePassword,
                  enableSuggestions: false,
                  autocorrect: false,
                  controller: _old_passwordController,
                  decoration: const InputDecoration(
                      hintText: 'Ketik password sekarang kamu di sini...',
                      labelText: 'Password',
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
                    controller: _new_password1,
                    decoration: const InputDecoration(
                        hintText: 'Ketik kata sandi baru kamu di sini...',
                        labelText: 'Kata sandi baru',
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
                  child: TextField(
                    obscureText: visiblePassword,
                    enableSuggestions: false,
                    autocorrect: false,
                    controller: _new_password2,
                    decoration: const InputDecoration(
                        hintText:
                            'Ketik konfirmasi kata sandi baru kamu di sini...',
                        labelText: 'Konfirmasi kata sandi baru',
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
                      child: const Text('Ganti Password'),
                      onPressed: () async {
                        String old_password = _old_passwordController.text;
                        String new_password1 = _new_password1.text;
                        String new_password2 = _new_password2.text;
                        // Cek kredensial
                        // TODO: Ganti URL dan jangan lupa tambahkan trailing slash (/) di akhir URL!
                        // Untuk menyambungkan Android emulator dengan Django pada localhost,
                        // gunakan URL http://10.0.2.2/
                        final response = await request.post(
                            "https://inkwanderers.my.id/account/change_password_flutter/",
                            {
                              'old_password': old_password,
                              'new_password1': new_password1,
                              'new_password2': new_password2,
                            });
                        if (response['status'] == true) {
                          Navigator.pop(context);

                          ScaffoldMessenger.of(context)
                            ..hideCurrentSnackBar()
                            ..showSnackBar(SnackBar(
                                content: Text(
                                    "Selamat, berhasil mengganti password!")));
                        } else {
                          ScaffoldMessenger.of(context)
                            ..hideCurrentSnackBar()
                            ..showSnackBar(SnackBar(
                                content: Text("Maaf, ganti password gagal!")));
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
      ],
    ));
  }
}
