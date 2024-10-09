import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:ukkhotel/controllers/login_controller.dart';
import 'package:ukkhotel/services.dart/base_url.dart';

class Pesan {
  LoginController datalogin = LoginController();
  String baseUrl = "${baseUrlService().baseUrl}/api";
  Future simpanPesan(data) async {
    var user = await datalogin.getDataLogin();
    var token = user!.access_token;
    Map<String, String> headers = {
      "Authorization": "Bearer $token",
      // "Content-type": "application/json",
      "makerID": baseUrlService().makerID
    };
    http.Response response = await http.post(
      Uri.parse('$baseUrl/room'),
      headers: headers,
      body: data,
    );

    if (response.statusCode == 200) {
      var responseData = jsonDecode(response.body);
      var cekResponse = responseData.length;
      if (cekResponse > 0 && responseData["status"] == "Token is Expired") {
        return {"status": false, "data": "Token is Expired"};
      } else if (cekResponse > 0 &&
          responseData["status"] == "Token is Invalid") {
        return {"status": false, "data": "Token is Invalid"};
      } else {
        return {"status": true, "data": responseData};
      }
    } else {
      print('gagal insert ${response.statusCode}');
      return false;
    }
  }
}
