import 'dart:convert';

import 'package:http/http.dart' as http;

class LoginService {
  String baseUrl = "http://ukkhotel.smktelkom-mlg.sch.id/api";
  Future loginAct(request) async {
    final url = Uri.parse(this.baseUrl + "/login");
    try {
      final getLogin =
          await http.post(url, body: request, headers: {'makerID': '2'});
      if (getLogin.statusCode == 200) {
        return jsonDecode(getLogin.body);
      } else {
        return null;
      }
    } on Exception catch (e) {
      print("error koneksi");
      return e;
    }
  }
}
