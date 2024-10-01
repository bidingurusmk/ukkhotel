import 'dart:convert';

import 'package:ukkhotel/controllers/login_controller.dart';
import 'package:ukkhotel/services.dart/type.dart';

class TypeController {
  TypeService type = TypeService();
  LoginController datalogin = LoginController();
  InsertType(data) async {
    var user = await datalogin.getDataLogin();
    var token = jsonDecode(user!["dataLogin"])["access_token"];
    return await type.InsertType(data, token);
  }

  // getType() async {
  //   var user = await datalogin.getDataLogin();
  //   if (user != null) {
  //     var token = jsonDecode(user!["dataLogin"])["access_token"];
  //     return await type.getType(token);
  //   } else {
  //     return null;
  //   }
  // }

  getType() async {
    var user = await datalogin.getDataLogin();
    if (user!["dataLogin"] != null) {
      var cekuser = jsonDecode(user!["dataLogin"])["access_token"];
      var token = cekuser;
      var data = await type.getType(token);
      if (data["status"] == true) {
        return data["data"];
      } else {
        return null;
      }
    } else {
      return null;
    }
  }
}
