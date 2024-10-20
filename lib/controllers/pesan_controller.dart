import 'package:ukkhotel/controllers/login_controller.dart';
import 'package:ukkhotel/services.dart/pesan.dart';
import 'package:flutter/material.dart';

class PesanController {
  Pesan pesan = Pesan();
  LoginController datalogin = LoginController();
  getPesan() async {
    var user = await datalogin.getDataLogin();
    if (user!.status != false) {
      var token = user.access_token;
      var data = await pesan.getPesan(token);
      if (data.status == true) {
        return data;
      } else {
        return null;
      }
    }
  }

  updateStatus(id, status) async {
    var user = await datalogin.getDataLogin();
    if (user!.status != false) {
      var token = user.access_token;
      var update = await pesan.updateStatus(id, status, token);
      return update;
    } else {
      return null;
    }
  }
}
