import 'package:flutter/material.dart';
import 'package:ukkhotel/services.dart/pesan.dart';
import 'package:ukkhotel/widgets/alert.dart';

class CekPesanan extends StatefulWidget {
  const CekPesanan({super.key});

  @override
  State<CekPesanan> createState() => _CekPesananState();
}

class _CekPesananState extends State<CekPesanan> {
  final keyForm = GlobalKey<FormState>();
  Pesan pesan = Pesan();
  TextEditingController order_number = TextEditingController();
  TextEditingController email = TextEditingController();
  Map? roomCek;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cek Pesanan"),
        foregroundColor: Colors.white,
        backgroundColor: Colors.green,
        // automaticallyImplyLeading: false,
      ),
      body: Container(
        margin: EdgeInsets.all(10),
        child: Column(
          children: [
            Form(
                key: keyForm,
                child: Column(
                  children: [
                    TextFormField(
                      controller: order_number,
                      decoration:
                          InputDecoration(label: Text("Input Order Number")),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Harus diisi';
                        } else {
                          return null;
                        }
                      },
                    ),
                    TextFormField(
                      controller: email,
                      decoration: InputDecoration(label: Text("Input Email")),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Harus diisi';
                        } else {
                          return null;
                        }
                      },
                    ),
                  ],
                )),
            ElevatedButton(
                onPressed: () async {
                  if (keyForm.currentState!.validate()) {
                    var data = {
                      'order_number': order_number.text,
                      'email': email.text,
                    };
                    setState(() {
                      roomCek = null;
                    });
                    var result = await pesan.cekPesan(data);
                    if (result.status == true) {
                      setState(() {
                        roomCek = result.data;
                      });
                    } else {
                      AlertMessage()
                          .showAlert(context, result.message, result.status);
                    }
                  }
                },
                child: Text("Tampilkan")),
            Expanded(
              child: Container(
                  child: roomCek != null
                      ? ListView(
                          children: [
                            Center(
                                child: Text(
                              "Data Kamar",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                            )),
                            DataTable(columns: [
                              DataColumn(label: Text('Nama Kolom')),
                              DataColumn(label: Text('Data')),
                            ], rows: [
                              DataRow(cells: [
                                DataCell(Text("Order Number")),
                                DataCell(
                                    Text(roomCek!["order_number"].toString())),
                              ]),
                              DataRow(cells: [
                                DataCell(Text("Customer Name")),
                                DataCell(Text(roomCek!["customer_name"])),
                              ]),
                              DataRow(cells: [
                                DataCell(Text("Customer Email")),
                                DataCell(Text(roomCek!["customer_email"])),
                              ]),
                              DataRow(cells: [
                                DataCell(Text("Order Date")),
                                DataCell(Text(roomCek!["order_date"])),
                              ]),
                              DataRow(cells: [
                                DataCell(Text("Check IN")),
                                DataCell(Text(roomCek!["check_in"].toString())),
                              ]),
                              DataRow(cells: [
                                DataCell(Text("Check OUT")),
                                DataCell(
                                    Text(roomCek!["check_out"].toString())),
                              ]),
                              DataRow(cells: [
                                DataCell(Text("Guest Name")),
                                DataCell(Text(roomCek!["guest_name"])),
                              ]),
                              DataRow(cells: [
                                DataCell(Text("Rooms Amount")),
                                DataCell(
                                    Text(roomCek!["rooms_amount"].toString())),
                              ]),
                              DataRow(cells: [
                                DataCell(Text("Status")),
                                DataCell(Text(roomCek!["status"].toString())),
                              ]),
                              DataRow(cells: [
                                DataCell(Text("Type ID")),
                                DataCell(Text(roomCek!["type_id"].toString())),
                              ]),
                              DataRow(cells: [
                                DataCell(Text("Jumlah Hari")),
                                DataCell(
                                    Text(roomCek!["jumlah_hari"].toString())),
                              ]),
                              DataRow(cells: [
                                DataCell(Text("Grand Total")),
                                DataCell(
                                    Text(roomCek!["grand_total"].toString())),
                              ]),
                            ]),
                            for (var r in roomCek!["room_data"])
                              Card(
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            "Room Number: ",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(r["room_number"].toString()),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            "Type Name: ",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(r["type_name"]),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            "Price: ",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(r["price"].toString()),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              )
                          ],
                        )
                      : Text("")),
            ),
          ],
        ),
      ),
    );
  }
}
