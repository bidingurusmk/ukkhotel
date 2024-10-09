import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:ukkhotel/models/response_data.dart';
import 'package:ukkhotel/services.dart/base_url.dart';

class RoomService {
  String baseUrl = "${baseUrlService().baseUrl}/api";

  Future InsertRoom(data, token, id) async {
    try {
      var url;
      Map<String, String> headers = {
        "Authorization": "Bearer $token",
        // "Content-type": "application/json",
        "makerID": baseUrlService().makerID
      };
      http.Response response;

      if (id == null) {
        url = '$baseUrl/room';
        response = await http.post(
          Uri.parse(url),
          headers: headers,
          body: data,
        );
      } else {
        url = '$baseUrl/room/$id';
        response = await http.put(
          Uri.parse(url),
          headers: headers,
          body: data,
        );
      }

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        print("sukses update");
        print(responseData);
        var cekResponse = responseData.length;
        if (cekResponse > 0 && responseData["status"] == "Token is Expired") {
          return {"status": false, "data": "Token is Expired"};
        } else if (cekResponse > 0 &&
            responseData["status"] == "Token is Invalid") {
          return {"status": false, "data": "Token is Invalid"};
        } else {
          return {"status": true, "data": responseData};
        }

        // return true;
      } else {
        print('gagal insert ${response.statusCode}');
        return false;
      }
    } on Exception catch (e) {
      print('gagal inserts $e');
      return false;
    }
  }

  Future getRoom(token) async {
    Map<String, String> headers = {
      "Authorization": "Bearer $token",
      // "Content-type": "application/json",
      "makerID": baseUrlService().makerID
    };
    http.Response response = await http.get(
      Uri.parse('$baseUrl/room'),
      headers: headers,
    );

    if (response.statusCode == 200) {
      var responseData = jsonDecode(response.body);
      var cekResponse = responseData.length;
      // print(responseData);
      // if (cekResponse > 0 && responseData!["status"] == "Token is Expired") {
      //   var room = ResponseData(status: false, message: "Token is Expired");
      //   return room;
      //   // return {"status": false, "message": "Token is Expired", "data": null};
      // } else if (cekResponse > 0 &&
      //     responseData["status"] == "Token is Invalid") {
      //   var room = ResponseData(status: false, message: "Token is Invalid");
      //   return room;
      // } else {
      ResponseData room = ResponseData(
          status: true,
          message: "sukses load data",
          data: responseData
              .map((r) => {
                    "room_id": r["room_id"],
                    "room_number": r["room_number"],
                    "type_id": r["type_id"],
                  })
              .toList());
      return room;
      // }
    } else {
      var room = ResponseData(status: false, message: "Gagal load data");
      return room;
    }
  }

  Future hapusRoom(token, id) async {
    Map<String, String> headers = {
      "Authorization": "Bearer $token",
      // "Content-type": "application/json",
      "makerID": baseUrlService().makerID
    };
    http.Response response = await http.delete(
      Uri.parse('$baseUrl/room/$id'),
      headers: headers,
    );

    if (response.statusCode == 200) {
      var responseData = jsonDecode(response.body);
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
          // "data": jsonDecode(response.body)["data"],
        };
        return data;
      }
    } else {
      var data = {
        'status': false,
        'message': 'Gagal hapus data',
        // "data": null,
      };
      return data;
    }
  }
}
