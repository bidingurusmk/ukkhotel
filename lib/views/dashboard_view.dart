import 'package:flutter/material.dart';
import 'package:ukkhotel/controllers/login_controller.dart';
import 'package:ukkhotel/widgets/menu_bottom.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({super.key});

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  LoginController? loginController = LoginController();
  String? nama;
  String? role;
  getDataLogin() async {
    var dataLogin = await loginController!.getDataLogin();
    if (dataLogin!.status != false) {
      var namaUser = dataLogin.name;
      setState(() {
        nama = namaUser;
        role = dataLogin.role;
      });
    } else {
      Navigator.pushReplacementNamed(context, '/login');
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
        title: Text("$nama"),
        automaticallyImplyLeading: false,
      ),
      body: Center(
          child: Text(
        "selamat datang di akun $role",
        style: TextStyle(fontSize: 20),
      )),
      bottomNavigationBar: MenuBottom(0),
    );
  }

  // LoginController? loginController = LoginController();
  // Stream getDataLogin() async* {
  //   var dataLogin = await loginController!.getDataLogin();
  //   if (dataLogin!.status != false) {
  //     var namaUser = dataLogin.name;
  //     var data = {
  //       'nama': namaUser,
  //       'role': dataLogin.role,
  //     };
  //     yield data;
  //   } else {
  //     Navigator.pushReplacementNamed(context, '/login');
  //   }
  // }

  // @override
  // Widget build(BuildContext context) {
  //   return StreamBuilder(
  //       stream: getDataLogin(),
  //       builder: (BuildContext context, snapshot) {
  //         if (snapshot.connectionState == ConnectionState.waiting) {
  //           return Scaffold(
  //             appBar: AppBar(
  //               title: Text("Loading ..."),
  //               automaticallyImplyLeading: false,
  //             ),
  //             body: Center(
  //               child: CircularProgressIndicator(),
  //             ),
  //             bottomNavigationBar: MenuBottom(0),
  //           );
  //         } else if (snapshot.hasError) {
  //           return Scaffold(
  //             appBar: AppBar(
  //               title: Text("error"),
  //               automaticallyImplyLeading: false,
  //             ),
  //             body: Center(
  //                 child: Text(
  //               "Error data load",
  //               style: TextStyle(fontSize: 20),
  //             )),
  //             bottomNavigationBar: MenuBottom(0),
  //           );
  //         } else if (!snapshot.hasData) {
  //           return Scaffold(
  //             appBar: AppBar(
  //               title: Text(' '),
  //               automaticallyImplyLeading: false,
  //             ),
  //             body: Center(
  //                 child: Text(
  //               "selamat datang di Aplikasi Hotel",
  //               style: TextStyle(fontSize: 20),
  //             )),
  //             bottomNavigationBar: MenuBottom(0),
  //           );
  //         } else {
  //           return Scaffold(
  //             appBar: AppBar(
  //               title: Text("${snapshot.data["nama"]}"),
  //               automaticallyImplyLeading: false,
  //             ),
  //             body: Center(
  //                 child: Text(
  //               "selamat datang di akun ${snapshot.data["role"]}",
  //               style: TextStyle(fontSize: 20),
  //             )),
  //             bottomNavigationBar: MenuBottom(0),
  //           );
  //         }
  //       });
  // }
}
