import 'dart:convert';

import 'package:ukkhotel/services.dart/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController {
  LoginService? loginServ = LoginService();
  Future loginAct(request) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final login = await loginServ!.loginAct(request);
    if (login != null) {
      // print(login);
      prefs.setString("data_login", jsonEncode(login));
      prefs.setBool("is_login", true);
      return {
        "status": true,
        "data": login,
      };
    } else {
      return {"status": false, "message": "username dan password salah"};
    }
  }

  Future<Map?> getDataLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var dataLogin = prefs.getString("data_login");
    var is_login = prefs.getBool("is_login");
    var data1 = {
      "status": is_login,
      'dataLogin': dataLogin,
    };
    return data1;
  }
}
