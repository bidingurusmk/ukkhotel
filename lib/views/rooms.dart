import 'package:flutter/material.dart';
import 'package:ukkhotel/controllers/login_controller.dart';
import 'package:ukkhotel/controllers/room_controller.dart';
import 'package:ukkhotel/controllers/type_controller.dart';
import 'package:ukkhotel/models/response_data.dart';
import 'package:ukkhotel/widgets/alert.dart';
import 'package:ukkhotel/widgets/menu_bottom.dart';

class RommsView extends StatefulWidget {
  const RommsView({super.key});

  @override
  State<RommsView> createState() => _RommsViewState();
}

class _RommsViewState extends State<RommsView> {
  RoomController room = RoomController();
  TypeController type = TypeController();
  TextEditingController roomNumberInput = TextEditingController();
  int? type_id;

  LoginController? loginController = LoginController();
  String? nama;
  ResponseData? listroom;
  ResponseData? listtype;
  List listbutton = ["Update", "Hapus"];
  String? judulPage = 'Tambah';
  int? id;

  getRoom() async {
    var getdata = await room.getRoom();
    // print(getdata.data);
    if (getdata != null) {
      setState(() {
        listroom = getdata;
      });
    }
    // print(listroom!.data);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDataLogin();
    getRoom();
    getTypes();
  }

  @override
  void setState(VoidCallback fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  getDataLogin() async {
    var dataLogin = await loginController!.getDataLogin();
    if (dataLogin!.status != false) {
      var namaUser = dataLogin.name;

      setState(() {
        nama = namaUser;
      });
    }
  }

  getTypes() async {
    var getdata = await type.getType();

    if (getdata != null) {
      setState(() {
        listtype = getdata;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: nama == null ? Text("") : Text(nama!),
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  id = null;
                  type_id = null;
                });
                roomNumberInput.text = '';

                judulPage = 'Tambah';
              },
              icon: Icon(Icons.add))
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(children: [
              // Text("${judulPage} Kamar"),
              TextField(
                controller: roomNumberInput,
                decoration: InputDecoration(label: Text("Room Number")),
              ),
              // TextField(
              //   controller: type_idInput,
              //   decoration: InputDecoration(label: Text("Price")),
              // ),
              if (listtype != null)
                DropdownButton(
                  value: type_id,
                  items: listtype!.data!.map((value) {
                    print(value["type_id"]);
                    return DropdownMenuItem(
                      value: value["type_id"],
                      child: Text(value["type_name"]),
                    );
                  }).toList(),
                  onChanged: (selected) {
                    // print(selected);
                    setState(() {
                      type_id = int.parse(selected.toString());
                    });
                  },
                  hint: Text("Select a Room Type"),
                )
              else
                Text("data Type kamar kosong"),
              ElevatedButton(
                  onPressed: () async {
                    var data = {
                      "room_number": roomNumberInput.text,
                      "type_id": type_id.toString(),
                    };
                    var result = await room.InsertRoom(data, id);
                    if (result["status"] == true) {
                      getRoom();
                    }
                    print(result);
                  },
                  child: Text("Simpan")),
              SizedBox(
                height: 350,
                child: ListView(
                  children: [
                    if (listroom != null)
                      for (var items in listroom!.data!)
                        Card(
                            child: ListTile(
                          title: Text(items["room_number"].toString()),
                          leading: Text(items["type_id"].toString()),
                          trailing: PopupMenuButton(
                              itemBuilder: (BuildContext context) {
                            return listbutton.map((item) {
                              return PopupMenuItem<String>(
                                value: item,
                                child: Text(item),
                                onTap: () async {
                                  if (item == "Update") {
                                    setState(() {
                                      id = items["room_id"];
                                      judulPage = 'Update';
                                      type_id = items["type_id"];
                                    });
                                    roomNumberInput.text =
                                        items["room_number"].toString();
                                  } else if (item == "Hapus") {
                                    var resultHapus =
                                        await room.hapusRoom(items["room_id"]);
                                    if (resultHapus['status'] == true) {
                                      AlertMessage().showAlert(
                                          context, "berhasil hapus data", true);
                                      getRoom();
                                    }
                                  }
                                  // modal.showFullModal(context, Text("hello"));
                                },
                              );
                            }).toList();
                          }),
                        ))
                  ],
                ),
              )
            ])),
      ),
      bottomNavigationBar: MenuBottom(1),
    );
  }
}
