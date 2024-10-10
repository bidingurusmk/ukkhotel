import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ukkhotel/services.dart/base_url.dart';
import 'package:ukkhotel/services.dart/pesan.dart';
import 'package:intl/intl.dart';

class DetailHotelView extends StatefulWidget {
  const DetailHotelView({super.key});

  @override
  State<DetailHotelView> createState() => _DetailHotelViewState();
}

class _DetailHotelViewState extends State<DetailHotelView> {
  TextEditingController checkin = TextEditingController();
  TextEditingController customer_name = TextEditingController();
  TextEditingController email_customer = TextEditingController();
  TextEditingController guest_name = TextEditingController();
  TextEditingController rooms_amount = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final item = ModalRoute.of(context)!.settings.arguments as Map;
    return Scaffold(
      appBar: AppBar(
        title: Text("Detail Hotel"),
        backgroundColor: Colors.orange,
      ),
      body: SingleChildScrollView(
        child: Container(
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
              SizedBox(
                height: 50,
              ),
              TextField(
                controller: customer_name,
                decoration: InputDecoration(label: Text("Nama Pelanggan")),
              ),
              TextField(
                controller: email_customer,
                decoration: InputDecoration(label: Text("Email Pelanggan")),
              ),
              TextField(
                controller: guest_name,
                decoration: InputDecoration(label: Text("Nama Tamu")),
              ),
              TextField(
                controller: checkin,
                // controller: _textEditingController,
                onTap: () async {
                  await showDateRangePicker(
                    context: context,
                    // firstDate: DateTime.now().subtract(Duration(days: 60)),
                    firstDate: DateTime.now(),
                    lastDate: DateTime.now().add(Duration(days: 60)),
                    initialEntryMode: DatePickerEntryMode.calendar,
                    currentDate: DateTime.now(),
                    initialDateRange: DateTimeRange(
                        start: checkin.text == ''
                            ? DateTime.now()
                            : DateTime.parse(checkin.text.split(" - ")[0]),
                        end: checkin.text == ''
                            ? DateTime.now()
                            : DateTime.parse(checkin.text.split(" - ")[1])),
                  ).then((selectedDate) {
                    checkin.text = selectedDate.toString();
                  });
                },
              ),
              TextField(
                controller: rooms_amount,
                inputFormatters: <TextInputFormatter>[
                  // for below version 2 use this
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                  // for version 2 and greater youcan also use this
                  FilteringTextInputFormatter.digitsOnly
                ],
                keyboardType: TextInputType.number,
                decoration: InputDecoration(label: Text("Jumlah")),
              ),
              ElevatedButton(
                onPressed: () async {
                  var checkinDate =
                      DateTime.parse(checkin.text.split(" - ")[0]);
                  var checkoutDate =
                      DateTime.parse(checkin.text.split(" - ")[1]);
                  Map data = {
                    "customer_name": customer_name.text,
                    "email_name": email_customer.text,
                    "check_in": DateFormat('yyyy-MM-dd').format(checkinDate),
                    "check_out": DateFormat('yyyy-MM-dd').format(checkoutDate),
                    'romms_amout': rooms_amount.text,
                    "type_id": item["type_id"].toString(),
                  };
                  var result = await Pesan().simpanPesan(data);
                  print(result);
                },
                child: Text(
                  "Pesan",
                  style: TextStyle(color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              )
            ],
          ),
        ),
      ),
    );
  }
}
