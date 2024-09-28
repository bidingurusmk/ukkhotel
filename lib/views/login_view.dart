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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            TextField(
              controller: usernameInput,
            ),
            TextField(
              controller: passwordInput,
            ),
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
                await loginAction!.loginAct(data);
                setState(() {
                  loading = false;
                });
                Navigator.pushReplacementNamed(context, '/');
              },
              child: loading == false
                  ? Text("login")
                  : CircularProgressIndicator(),
            ),
          ],
        ),
      ),
    );
  }
}
