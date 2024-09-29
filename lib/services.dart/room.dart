import 'package:http/http.dart' as http;

class RoomService {
  String baseUrl = "https://ukkhotel.smktelkom-mlg.sch.id/api";

  Future InsertRoom(data, token) async {
    Map<String, String> headers = {
      "Authorization": "Bearer $token",
      // "Content-type": "application/json",
      "makerID": "1"
    };
    http.Response response = await http.post(
      Uri.parse('$baseUrl/room'),
      headers: headers,
      body: data,
    );
    if (response.statusCode == 200) {
      print("sukses insert");
      return true;
    } else {
      print('gagal insert');
      return false;
    }
  }
}
