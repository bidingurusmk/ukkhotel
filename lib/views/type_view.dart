import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ukkhotel/controllers/login_controller.dart';
import 'package:ukkhotel/controllers/type_controller.dart';
import 'package:ukkhotel/models/response_data.dart';
import 'package:ukkhotel/services.dart/base_url.dart';
import 'package:ukkhotel/widgets/alert.dart';
import 'package:ukkhotel/widgets/menu_bottom.dart';

class TypeView extends StatefulWidget {
  const TypeView({super.key});

  @override
  State<TypeView> createState() => _TypeViewState();
}

class _TypeViewState extends State<TypeView> {
  TextEditingController typeNameInput = TextEditingController();
  TextEditingController hargaInput = TextEditingController();
  TextEditingController descInput = TextEditingController();
  TextEditingController photoInput = TextEditingController();
  LoginController? loginController = LoginController();
  TypeController type = TypeController();
  String? nama;
  ResponseData? listtype;
  List listbutton = ["Update", "Hapus"];
  String? judulPage = 'Tambah';
  int? id;

  // String? type_name;
  // double? price;
  // String? desc;

  getDataLogin() async {
    var dataLogin = await loginController!.getDataLogin();
    if (dataLogin!.status != false) {
      var namaUser = dataLogin.name;
      setState(() {
        nama = namaUser;
      });
    } else {
      Navigator.pushReplacementNamed(context, '/login');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDataLogin();
    getTypes();
  }

  @override
  void setState(VoidCallback fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  XFile? selectedImage;
  Future getImage() async {
    var image = await ImagePicker().pickImage(source: ImageSource.gallery);

    setState(() {
      selectedImage = image;
    });
    //return image;
  }

  //resize the image
  // Future<void> _getImage(BuildContext context) async {
  //   if (selectedImage != null) {
  //     var imageFile = selectedImage;
  //     var image = imageLib.decodeImage(imageFile!.readAsBytesSync());
  //     fileName = basename(imageFile.path);
  //     image = imageLib.copyResize(image,
  //         width: (MediaQuery.of(context).size.width * 0.8).toInt(),
  //         height: (MediaQuery.of(context).size.height * 0.7).toInt());
  //     _image = image;
  //   }
  // }
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
    // print(listtype);
    return Scaffold(
      appBar: AppBar(
        title: Text(nama == null ? '' : nama!),
        automaticallyImplyLeading: false,
        actions: [
          CircleAvatar(
              child: IconButton(
                  onPressed: () {
                    setState(() {
                      id = null;
                    });
                    typeNameInput.text = '';
                    hargaInput.text = '';
                    descInput.text = '';
                    judulPage = 'Tambah';
                  },
                  icon: Icon(Icons.add)))
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              Text("$judulPage Type Lamar"),
              TextField(
                controller: typeNameInput,
                decoration: InputDecoration(label: Text("type Name")),
              ),
              TextField(
                controller: hargaInput,
                decoration: InputDecoration(label: Text("Price")),
              ),
              TextField(
                controller: descInput,
                decoration: InputDecoration(label: Text("Describe")),
              ),
              TextButton(
                  onPressed: () {
                    getImage();
                  },
                  child: Text("Select Picture")),
              selectedImage != null
                  ? Container(
                      child: Image.file(File(selectedImage!.path)),
                      width: MediaQuery.of(context).size.width,
                    )
                  : Center(child: Text("Please Get the Image")),
              ElevatedButton(
                  onPressed: () async {
                    if (selectedImage == null) {
                      AlertMessage()
                          .showAlert(context, "Photo harus ada", false);
                      exit(0);
                    }
                    Map<String, String> data = {
                      "type_name": typeNameInput.text,
                      "price": hargaInput.text,
                      "desc": descInput.text,
                      // "photo": selectedImage,
                    };
                    var imagess = selectedImage;
                    var result = await type.InsertType(data, imagess, id);
                    // print(result);
                    if (result['status'] == true) {
                      AlertMessage()
                          .showAlert(context, "berhasil input data", true);
                      getTypes();
                    } else {
                      AlertMessage()
                          .showAlert(context, "Gagal input data", false);
                    }
                  },
                  child: Text("Simpan")),
              SizedBox(
                height: 350,
                child: ListView(
                  children: [
                    if (listtype != null)
                      for (var items in listtype!.data!)
                        Card(
                            child: ListTile(
                          title: Text(items!["type_name"]!),
                          leading: FadeInImage(
                            image: NetworkImage(baseUrlService().baseUrl +
                                "/" +
                                items["photo_path"]!),
                            placeholder: AssetImage("assets/loading.gif"),
                            imageErrorBuilder: (context, error, stackTrace) {
                              return Image.asset('assets/error.png',
                                  fit: BoxFit.fitWidth);
                            },
                            fit: BoxFit.fitWidth,
                          ),
                          trailing: PopupMenuButton(
                              itemBuilder: (BuildContext context) {
                            return listbutton.map((item) {
                              return PopupMenuItem<String>(
                                value: item,
                                child: Text(item),
                                onTap: () async {
                                  if (item == "Update") {
                                    setState(() {
                                      id = items["type_id"];
                                      judulPage = 'Update';
                                    });
                                    typeNameInput.text = items["type_name"]!;
                                    hargaInput.text = items["price"].toString();
                                    descInput.text = items["desc"]!;
                                  } else if (item == "Hapus") {
                                    var resultHapus =
                                        await type.hapusType(items["type_id"]);
                                    if (resultHapus['status'] == true) {
                                      AlertMessage().showAlert(
                                          context, "berhasil hapus data", true);
                                      getTypes();
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
            ],
          ),
        ),
      ),
      bottomNavigationBar: MenuBottom(0),
    );
  }
}
