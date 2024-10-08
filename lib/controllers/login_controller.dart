import 'dart:convert';

import 'package:ukkhotel/models/user_login.dart';
import 'package:ukkhotel/services.dart/login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user_login.dart';

class LoginController {
  LoginService? loginServ = LoginService();
  Future loginAct(request) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final login = await loginServ!.loginAct(request);
    if (login != null) {
      // var data_user = jsonEncode(login);
      // print(login);
      prefs.setString("access_token", login["access_token"]);
      prefs.setString("name", login["user"]["name"]);
      prefs.setInt("id_user", login["user"]["id"]);
      prefs.setBool("is_login", true);
      return {
        "status": true,
        "data": login,
      };
    } else {
      return {"status": false, "message": "username dan password salah"};
    }
  }

  Future<UserLogin?> getDataLogin() async {
    UserLogin user;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var is_login = prefs.getBool("is_login") == null ? false : true;
    // var data1;
    if (is_login) {
      user = UserLogin(
          access_token: prefs.getString("access_token"),
          id_user: prefs.getInt("id_user"),
          name: prefs.getString("name"),
          status: true);
      // data1 = {
      //   "status": true,
      //   "access_token": prefs.getString("access_token"),
      //   "name": prefs.getString("name"),
      //   "id_user": prefs.getInt("id_user"),
      // };
    } else {
      user = UserLogin(status: false);
      // data1 = {
      //   "status": false,
      //   "access_token": null,
      //   "name": null,
      //   "id_user": null,
      // };
    }
    return user;
  }
}
