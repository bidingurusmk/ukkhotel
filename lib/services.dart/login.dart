import 'dart:convert';

import 'package:http/http.dart' as http;

class Login {
  String baseUrl = "http://ukkhotel.smktelkom-mlg.sch.id/api";
  Future<String?>? loginAct() async {
    final url = Uri.parse(this.baseUrl + "/login");
    final getLogin = await http.get(url);
    print(jsonDecode(getLogin.body));
    return null;
  }
}
