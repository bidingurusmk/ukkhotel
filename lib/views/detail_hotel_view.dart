import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ukkhotel/services.dart/base_url.dart';
import 'package:ukkhotel/services.dart/pesan.dart';

class DetailHotelView extends StatefulWidget {
  const DetailHotelView({super.key});

  @override
  State<DetailHotelView> createState() => _DetailHotelViewState();
}

class _DetailHotelViewState extends State<DetailHotelView> {
  @override
  Widget build(BuildContext context) {
    final item = ModalRoute.of(context)!.settings.arguments as Map;
    return Scaffold(
      appBar: AppBar(
        title: Text("Detail Hotel"),
        backgroundColor: Colors.orange,
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.all(10),
        child: Column(
          children: [
            FadeInImage(
              image: NetworkImage(
                  "${baseUrlService().baseUrl}/" + item["photo_path"]!),
              placeholder: AssetImage("assets/loading.gif"),
              imageErrorBuilder: (context, error, stackTrace) {
                return Image.asset('assets/error.png',
                    width: MediaQuery.of(context).size.width,
                    fit: BoxFit.fitWidth);
              },
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.fitWidth,
            ),
            Text(item["type_name"]),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    inputFormatters: <TextInputFormatter>[
                      // for below version 2 use this
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
// for version 2 and greater youcan also use this
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(label: Text("Jumlah")),
                  ),
                ),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      var data = {};
                      Pesan().simpanPesan(data);
                    },
                    child: Text(
                      "Pesan",
                      style: TextStyle(color: Colors.white),
                    ),
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.red),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
