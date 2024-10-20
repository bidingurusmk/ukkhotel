import 'package:flutter/material.dart';
import 'package:ukkhotel/controllers/login_controller.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  bool loading = false;
  LoginController? loginAction = LoginController();
  TextEditingController usernameInput = TextEditingController();
  TextEditingController passwordInput = TextEditingController();

  String? username;
  String? password;
  String message = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.all(10),
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: usernameInput,
              ),
              TextField(
                controller: passwordInput,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                      onPressed: () async {
                        setState(() {
                          username = usernameInput.text;
                          password = passwordInput.text;
                          loading = true;
                        });
                        Map data = {
                          'email': username,
                          'password': password,
                        };
                        var login = await loginAction!.loginAct(data);
                        if (login.status == true) {
                          Navigator.pushNamed(context, '/dashboard');
                        } else {
                          setState(() {
                            message = 'Username dan password salah';
                          });
                        }
                        setState(() {
                          loading = false;
                        });
                      },
                      child: loading == false
                          ? Text("login", style: TextStyle(color: Colors.white))
                          : CircularProgressIndicator(),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red)),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, "/pesan");
                      },
                      child: Text(
                        "Pesan Hotel",
                        style: TextStyle(color: Colors.white),
                      ),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green)),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, "/cekpesanan");
                      },
                      child: Text(
                        "Cek Pesanan",
                        style: TextStyle(color: Colors.white),
                      ),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange)),
                ],
              ),
              Text(message)
            ],
          ),
        ),
      ),
    );
  }
}
