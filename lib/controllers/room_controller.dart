import 'dart:convert';

import 'package:ukkhotel/controllers/login_controller.dart';
import 'package:ukkhotel/services.dart/room.dart';

class RoomController {
  LoginController datalogin = LoginController();
  RoomService room = RoomService();
  InsertRoom(data) async {
    var user = await datalogin.getDataLogin();
    var token = jsonDecode(user!["dataLogin"])["access_token"];
    return await room.InsertRoom(data, token);
  }
}
