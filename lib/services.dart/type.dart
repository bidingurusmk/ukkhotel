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
    var res = await request.send();
    if (res.statusCode == 200) {
      final responseData = await res.stream.toBytes();
      final responseString = String.fromCharCodes(responseData);
      final jasonMap = jsonDecode(responseString);
      print(jasonMap);
      return jasonMap;
    } else {
      var response = await http.Response.fromStream(res);

      return {"ok": "gagal", "res": response.body};
    }
  }
}
