import 'dart:convert';

import 'package:ukkhotel/services.dart/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController {
  LoginService? loginServ = LoginService();
  Future loginAct(request) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final login = await loginServ!.loginAct(request);
    if (login != null) {
      print(login);
      prefs.setString("data_login", jsonEncode(login));
      return login;
    } else {
      return {"status": false, "message": "username dan password salah"};
    }
  }

  Future<String?> getDataLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var dataLogin = prefs.getString("data_login");
    return dataLogin;
  }
}
