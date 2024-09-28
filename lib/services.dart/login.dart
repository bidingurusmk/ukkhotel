import 'dart:convert';

import 'package:http/http.dart' as http;

class LoginService {
  String baseUrl = "http://localhost/hotel_ukk/public/api";
  Future loginAct(request) async {
    final url = Uri.parse(this.baseUrl + "/login");
    final getLogin =
        await http.post(url, body: request, headers: {'makerID': '1'});
    if (getLogin.statusCode == 200) {
      return jsonDecode(getLogin.body);
    } else {
      return null;
    }
  }
}
