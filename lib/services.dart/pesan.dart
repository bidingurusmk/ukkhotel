import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:ukkhotel/controllers/login_controller.dart';
import 'package:ukkhotel/models/response_data.dart';
import 'package:ukkhotel/models/response_data_map.dart';
import 'package:ukkhotel/services.dart/base_url.dart';

class Pesan {
  LoginController datalogin = LoginController();
  String baseUrl = "${baseUrlService().baseUrl}/api";
  Future simpanPesan(data) async {
    Map<String, String> headers = {"makerID": baseUrlService().makerID};
    http.Response response = await http.post(
      Uri.parse('$baseUrl/orders'),
      headers: headers,
      body: data,
    );
    print(data);

    if (response.statusCode == 200) {
      var responseData = jsonDecode(response.body);
      ResponseDataMap res = ResponseDataMap(
        status: true,
        message: 'sukses simpan pesan',
        data: responseData,
      );
      return res;
    } else {
      ResponseDataMap res = ResponseDataMap(
        status: false,
      );
      return res;
    }
  }

  Future getPesan(token) async {
    Map<String, String> headers = {
      "Authorization": 'Bearer $token',
      "makerID": baseUrlService().makerID
    };
    http.Response response = await http.get(
      Uri.parse('$baseUrl/orders'),
      headers: headers,
    );
    // print(jsonDecode(response.body));
    if (response.statusCode == 200) {
      var responseData = jsonDecode(response.body)["data"];
      ResponseData pesan = ResponseData(
          status: true,
          message: "sukses load data",
          data: responseData
              .map((r) => {
                    "order_id": r["order_id"],
                    "order_number": r["order_number"],
                    "customer_name": r["customer_name"],
                    "customer_email": r["customer_email"],
                    "order_date": r["order_date"],
                    "check_in": r["check_in"],
                    "check_out": r["check_out"],
                    "guest_name": r["guest_name"],
                    "rooms_amount": r["rooms_amount"],
                    "status": r["status"],
                    "type_id": r["type_id"],
                  })
              .toList());
      return pesan;
    } else {
      var pesan = ResponseData(
        status: false,
        message: "gagal load data",
      );
      return pesan;
    }
  }

  Future updateStatus(orderId, status, token) async {
    Map<String, String> headers = {
      "Authorization": 'Bearer $token',
      "makerID": baseUrlService().makerID
    };
    http.Response response = await http.put(
        Uri.parse('$baseUrl/orders/status/$orderId'),
        headers: headers,
        body: status);
    print(jsonDecode(response.body));
    if (response.statusCode == 200) {
      var responseData = jsonDecode(response.body);
      ResponseData pesan = ResponseData(
          status: true, message: responseData["message"], data: null);
      return pesan;
    } else {
      var pesan = ResponseData(
        status: false,
        message: "gagal update status pesan",
      );
      return pesan;
    }
  }

  Future cekPesan(data) async {
    Map<String, String> headers = {"makerID": baseUrlService().makerID};
    http.Response response = await http.post(Uri.parse('$baseUrl/checkorder'),
        headers: headers, body: data);
    // print(jsonDecode(response.body));
    if (response.statusCode == 200) {
      var responseData = jsonDecode(response.body)["orders"];
      ResponseDataMap cekPesan;
      if (responseData["data"] != null) {
        cekPesan = ResponseDataMap(
            status: true,
            message: responseData["message"],
            data: {
              "order_number": responseData["data"]["order_number"],
              "customer_name": responseData["data"]["customer_name"],
              "customer_email": responseData["data"]["customer_email"],
              "order_date": responseData["data"]["order_date"],
              "check_in": responseData["data"]["check_in"],
              "check_out": responseData["data"]["check_out"],
              "guest_name": responseData["data"]["guest_name"],
              "rooms_amount": responseData["data"]["rooms_amount"],
              "status": responseData["data"]["status"],
              "type_id": responseData["data"]["type_id"],
              "jumlah_hari": responseData["days"],
              "grand_total": responseData["grand_total"],
              "room_data": [
                for (var r in responseData["room_selected"])
                  {
                    "room_number": r["room_number"],
                    "type_name": r["type_name"],
                    "price": r["price"],
                  }
              ]
            });
      } else {
        cekPesan = ResponseDataMap(
          status: false,
          message: "Order Number salah",
        );
      }

      return cekPesan;
    } else {
      var cekPesan = ResponseDataMap(
        status: false,
        message: "gagal update status pesan",
      );
      return cekPesan;
    }
  }
}
