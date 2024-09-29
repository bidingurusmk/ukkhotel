import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ukkhotel/controllers/room_controller.dart';
import 'package:ukkhotel/widgets/menu_bottom.dart';

class RommsView extends StatefulWidget {
  const RommsView({super.key});

  @override
  State<RommsView> createState() => _RommsViewState();
}

class _RommsViewState extends State<RommsView> {
  RoomController room = RoomController();
  TextEditingController roomNumberInput = TextEditingController();
  TextEditingController type_idInput = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(children: [
            Text("Tambah Lamar"),
            TextField(
              controller: roomNumberInput,
              decoration: InputDecoration(label: Text("type Name")),
            ),
            TextField(
              controller: type_idInput,
              decoration: InputDecoration(label: Text("Price")),
            ),
            ElevatedButton(
                onPressed: () async {
                  var data = {
                    "room_number": roomNumberInput.text,
                    "type_id": type_idInput.text,
                  };
                  var result = await room.InsertRoom(data);
                  print(result);
                },
                child: Text("Simpan"))
          ])),
      bottomNavigationBar: MenuBottom(1),
    );
  }
}
