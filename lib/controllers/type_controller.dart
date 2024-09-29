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
}
