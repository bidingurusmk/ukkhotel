import 'package:flutter/material.dart';
import 'package:ukkhotel/services.dart/login.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
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
                final result = await Login().loginAct();
              },
              child: Text("login"),
            )
          ],
        ),
      ),
    );
  }
}
