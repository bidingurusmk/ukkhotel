import 'dart:convert';

import 'package:http/http.dart' as http;

class LoginService {
  String baseUrl = "https://ukkhotel.smktelkom-mlg.sch.id/api";
  Future loginAct(request) async {
    final url = Uri.parse(baseUrl + "/login");
    final getLogin =
        await http.post(url, body: request, headers: {'makerID': '2'});
    print(jsonDecode(getLogin.body));
    if (getLogin.statusCode == 200) {
      return jsonDecode(getLogin.body);
    } else {
      return null;
    }
  }
}
