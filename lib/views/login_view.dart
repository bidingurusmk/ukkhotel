import 'package:flutter/material.dart';
import 'package:ukkhotel/controllers/login_controller.dart';
import 'package:ukkhotel/services.dart/login.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  bool loading = false;
  LoginController? loginAction;
  LoginService? loginService;
  TextEditingController usernameInput = TextEditingController();
  TextEditingController passwordInput = TextEditingController();
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
                  loading = true;
                });
                Map data = {
                  'email': usernameInput.text,
                  'password': passwordInput.text,
                };
                final result = await loginService!.loginAct(data);
                setState(() {
                  loading = false;
                });
                // print(result);
              },
              child: loading == false
                  ? Text("login")
                  : CircularProgressIndicator(),
            )
          ],
        ),
      ),
    );
  }
}
