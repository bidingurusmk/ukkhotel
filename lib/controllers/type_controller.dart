import 'dart:convert';

import 'package:ukkhotel/controllers/login_controller.dart';
import 'package:ukkhotel/services.dart/type.dart';

class TypeController {
  TypeService type = TypeService();
  LoginController datalogin = LoginController();
  InsertType(data, images, id) async {
    var user = await datalogin.getDataLogin();
    var token = user!.access_token;
    return await type.InsertType(data, images, token, id);
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
    if (user!.status != false) {
      var cekuser = user.access_token;
      var token = cekuser;
      var data = await type.getType(token);
      if (data.status == true) {
        // print(data.data[0].type_name);
        return data;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  hapusType(id) async {
    var user = await datalogin.getDataLogin();
    if (user!.status != false) {
      var cekuser = user.access_token;
      var token = cekuser;
      var data = await type.hapusType(token, id);
      return data;
    } else {
      return null;
    }
  }
}
