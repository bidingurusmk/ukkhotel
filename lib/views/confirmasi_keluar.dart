import 'dart:io';

import 'package:flutter/material.dart';

class ConfirmKeluar extends StatelessWidget {
  const ConfirmKeluar({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red, foregroundColor: Colors.white),
              onPressed: () {
                exit(0);
              },
              child: Text("Keluar")),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green, foregroundColor: Colors.white),
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/dashboard');
              },
              child: Text("Masuk kembali"))
        ],
      ),
    ));
  }
}
