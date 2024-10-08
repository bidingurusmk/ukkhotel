import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:ukkhotel/services.dart/base_url.dart';

class LoginService {
  String baseUrl = "${baseUrlService().baseUrl}/api";
  // String baseUrl = "http://192.168.0.8/hotel_ukk/public/api";
  Future loginAct(request) async {
    final url = Uri.parse(baseUrl + "/login");
    final getLogin = await http.post(url,
        body: request, headers: {'makerID': baseUrlService().makerID});
    // print(jsonDecode(getLogin.body));
    if (getLogin.statusCode == 200) {
      return jsonDecode(getLogin.body);
    } else {
      return null;
    }
  }
}
