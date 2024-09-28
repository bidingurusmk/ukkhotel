import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:ukkhotel/controllers/login_controller.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  LoginController? loginController = LoginController();
  String? nama;
  getDataLogin() async {
    var dataLogin = await loginController!.getDataLogin();
    if (dataLogin != null) {
      var data = jsonDecode(dataLogin);
      var namaUser = data["user"]["name"];
      setState(() {
        nama = namaUser;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDataLogin();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(nama == null ? '' : nama!),
          automaticallyImplyLeading: false,
        ),
        body: Center(
          child: Text("Selamat Datang di halaman dashboard"),
        ));
  }
}
