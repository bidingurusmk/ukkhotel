import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ukkhotel/models/response_data.dart';
import 'dart:io';

import 'package:ukkhotel/services.dart/base_url.dart';

class TypeService {
  String baseUrl = "${baseUrlService().baseUrl}/api";
  // String baseUrl = "http://192.168.0.8/hotel_ukk/public/api";

  Future InsertType(data, images, token, id) async {
    var request;
    if (id == null) {
      request = http.MultipartRequest(
        'POST',
        Uri.parse("${baseUrl}/type"),
      );
    } else {
      request = http.MultipartRequest(
        'POST',
        Uri.parse("${baseUrl}/type/" + id.toString()),
      );
    }

    Map<String, String> headers = {
      "Authorization": "Bearer $token",
      "Content-type": "multipart/form-data",
      "makerID": baseUrlService().makerID,
      // "Access-Control-Allow-Origin": "*",
      // "Access-Control-Allow-Methods": "POST, GET, OPTIONS, PUT, DELETE, HEAD",
    };
    // Map<String, String> dataString =
    //     data.map((key, value) => MapEntry(key, value?.toString()));
    File image = File(images.path);
    request.files.add(http.MultipartFile(
        'photo', image.readAsBytes().asStream(), image.lengthSync(),
        filename: image.path.split('/').last));
    request.headers.addAll(headers);
    request.fields['type_name'] = data["type_name"];
    request.fields['price'] = data["price"];
    request.fields['desc'] = data["desc"];

    // request.fields.addAll({
    //   "type_name": data["type_name"],
    //   "price": data["price"],
    //   "desc": data["desc"],
    // });
    try {
      var res = await request.send();
      var response = await http.Response.fromStream(res);
      // print(response.body);

      // print(responseData);
      if (res.statusCode == 200) {
        final responseData = jsonDecode(response.body);
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
        return {"status": false, "data": null};
      }
    } on Exception catch (e) {
      return {"status": false, "data": e.toString()};
    }
  }

  Future getType() async {
    Map<String, String> headers = {
      // "Authorization": "Bearer $token",
      // "Content-type": "application/json",
      "makerID": baseUrlService().makerID
    };
    http.Response response = await http.get(
      Uri.parse('$baseUrl/type'),
      headers: headers,
    );
    // print(jsonDecode(response.body));

    if (response.statusCode == 200) {
      // var responseData = jsonDecode(response.body);
      // var cekResponse = responseData.length;
      // if (cekResponse > 0 && responseData["status"] == "Token is Expired") {
      //   var typeroom = ResponseData(status: false, message: "Token is Expired");
      //   return typeroom;
      // } else if (cekResponse > 0 &&
      //     responseData["status"] == "Token is Invalid") {
      //   var typeroom = ResponseData(status: false, message: "Token is Invalid");
      //   return typeroom;
      // } else {
      var data = jsonDecode(response.body)["data"];
      // print(data[0]["type_name"]);
      ResponseData typeroom = ResponseData(
          status: true,
          message: "sukses load data",
          data: data
              .map((r) => {
                    "type_id": r["type_id"],
                    "type_name": r["type_name"],
                    "desc": r["desc"],
                    "price": r["price"],
                    "photo_path": r["photo_path"],
                  })
              .toList());
      return typeroom;
      // }
    } else {
      var typeroom = ResponseData(
        status: false,
        message: "gagal load data",
      );
      // var data = {
      //   'status': false,
      //   'message': 'Gagal load data',
      //   "data": null,
      // };
      return typeroom;
    }
  }

  Future getType_available(data) async {
    Map<String, String> headers = {
      // "Authorization": "Bearer $token",
      // "Content-type": "application/json",
      "makerID": baseUrlService().makerID
    };
    http.Response response = await http.post(
      Uri.parse('$baseUrl/datefilter'),
      headers: headers,
      body: data,
    );
    print(jsonDecode(response.body));

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)["data"];
      // print(data[0]["type_name"]);
      ResponseData typeroom = ResponseData(
          status: true,
          message: "sukses load data",
          data: data
              .map((r) => {
                    "type_id": r["type_id"],
                    "type_name": r["type_name"],
                    "desc": r["desc"],
                    "price": r["price"],
                    "photo_path":
                        '${baseUrlService().baseUrl}/images/' + r["photo_name"],
                  })
              .toList());
      return typeroom;
      // }
    } else {
      var typeroom = ResponseData(
        status: false,
        message: "gagal load data",
      );
      // var data = {
      //   'status': false,
      //   'message': 'Gagal load data',
      //   "data": null,
      // };
      return typeroom;
    }
  }

  Future hapusType(token, id) async {
    Map<String, String> headers = {
      "Authorization": "Bearer $token",
      // "Content-type": "application/json",
      "makerID": baseUrlService().makerID
    };
    http.Response response = await http.delete(
      Uri.parse('$baseUrl/type/$id'),
      headers: headers,
    );

    if (response.statusCode == 200) {
      var responseData = jsonDecode(response.body.toString());
      var cekResponse = responseData.length;
      if (cekResponse > 0 && responseData["status"] == "Token is Expired") {
        return {"status": false, "message": "Token is Expired", "data": null};
      } else if (cekResponse > 0 &&
          responseData["status"] == "Token is Invalid") {
        return {"status": false, "message": "Token is Invalid", "data": null};
      } else {
        var data = {
          'status': true,
          'message': 'Sukses hpaus data',
          "data": null,
        };
        return data;
      }
    } else {
      var data = {
        'status': false,
        'message': 'Gagal hapus data',
        "data": null,
      };
      return data;
    }
  }
}
