import 'dart:convert';
import 'package:http_parser/http_parser.dart';
import 'package:http/http.dart' as http;
import 'dart:io';

class TypeService {
  String baseUrl = "https://ukkhotel.smktelkom-mlg.sch.id/api";

  Future InsertType(data, token) async {
    var request = http.MultipartRequest(
      'POST',
      Uri.parse("${baseUrl}/type"),
    );
    Map<String, String> headers = {
      "Authorization": "Bearer $token",
      "Content-type": "multipart/form-data",
      "makerID": "1"
    };
    File image = File(data["photo"].path);
    request.files.add(http.MultipartFile(
        'photo', image.readAsBytes().asStream(), image.lengthSync(),
        filename: image.path.split('/').last));
    request.headers.addAll(headers);
    request.fields.addAll({
      "type_name": data["type_name"],
      "price": data["price"],
      "desc": data["desc"],
      // "photo": 'ok'
    });
    try {
      var res = await request.send();
      var response = await http.Response.fromStream(res);
      print(response.body);
      final responseData = jsonDecode(response.body);
      // print(responseData);
      if (res.statusCode == 200) {
        return responseData;
      } else {
        // if (response.statusCode >= 400) {
        return responseData;
        // }
      }
    } on Exception catch (e) {
      print('error:' + e.toString());
    }
  }

  Future getType(token) async {
    Map<String, String> headers = {
      "Authorization": "Bearer $token",
      // "Content-type": "application/json",
      "makerID": "1"
    };
    http.Response response = await http.get(
      Uri.parse('$baseUrl/type'),
      headers: headers,
    );
    if (response.statusCode == 200) {
      var data = {
        'status': true,
        'message': 'Sukses load data',
        "data": jsonDecode(response.body)["data"],
      };
      return data;
    } else {
      var data = {
        'status': false,
        'message': 'Gagal load data',
        "data": null,
      };
      return data;
    }
  }
}
