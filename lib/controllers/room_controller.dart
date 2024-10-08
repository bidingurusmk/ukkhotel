import 'dart:convert';

import 'package:ukkhotel/controllers/login_controller.dart';
import 'package:ukkhotel/services.dart/room.dart';

class RoomController {
  LoginController datalogin = LoginController();
  RoomService room = RoomService();
  InsertRoom(data, id) async {
    var user = await datalogin.getDataLogin();
    var token = user!.access_token;
    return await room.InsertRoom(data, token, id);
  }

  getRoom() async {
    var user = await datalogin.getDataLogin();
    if (user!.status != false) {
      var cekuser = user.access_token;
      var token = cekuser;
      var data = await room.getRoom(token);
      if (data.status == true) {
        return data;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  hapusRoom(id) async {
    var user = await datalogin.getDataLogin();
    if (user!.status != false) {
      var cekuser = user.access_token;
      var token = cekuser;
      var data = await room.hapusRoom(token, id);
      return data;
    } else {
      return null;
    }
  }
}
