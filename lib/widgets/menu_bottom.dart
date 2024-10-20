import 'package:flutter/material.dart';
import 'package:ukkhotel/controllers/login_controller.dart';

class MenuBottom extends StatefulWidget {
  int activePage;
  MenuBottom(this.activePage);

  @override
  State<MenuBottom> createState() => _MenuBottomState();
}

class _MenuBottomState extends State<MenuBottom> {
  LoginController? loginController = LoginController();
  String? role;
  getDataLogin() async {
    var dataLogin = await loginController!.getDataLogin();
    if (dataLogin!.status != false) {
      setState(() {
        role = dataLogin.role;
      });
    } else {
      Navigator.pushReplacementNamed(context, '/login');
    }
  }

  @override
  void setState(VoidCallback fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDataLogin();
  }

  void getLink(index) {
    if (role == "admin") {
      if (index == 0) {
        Navigator.pushReplacementNamed(context, '/dashboard').then((value) {
          setState(() {});
        });
      } else if (index == 1) {
        Navigator.pushReplacementNamed(context, '/typeroom').then((value) {
          setState(() {});
        });
      } else if (index == 2) {
        Navigator.pushReplacementNamed(context, '/rooms').then((value) {
          setState(() {});
        });
      }
    } else if (role == "receptionist") {
      if (index == 0) {
        Navigator.pushReplacementNamed(context, '/dashboard').then((value) {
          setState(() {});
        });
      } else if (index == 1) {
        Navigator.pushReplacementNamed(context, '/kelolapesan').then((value) {
          setState(() {});
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return role == "admin"
        ? BottomNavigationBar(
            selectedItemColor: Colors.black,
            unselectedItemColor: Colors.grey,
            currentIndex: widget.activePage,
            onTap: (index) => {getLink(index)},
            items: [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Type',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Room',
                ),
              ])
        : role == "receptionist"
            ? BottomNavigationBar(
                selectedItemColor: Colors.black,
                unselectedItemColor: Colors.grey,
                currentIndex: widget.activePage,
                onTap: (index) => {getLink(index)},
                items: [
                    BottomNavigationBarItem(
                      icon: Icon(Icons.home),
                      label: 'Home',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.home),
                      label: 'Pesan',
                    ),
                  ])
            : Text("");
  }
}
