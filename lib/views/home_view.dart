import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ukkhotel/controllers/login_controller.dart';
import 'package:ukkhotel/controllers/type_controller.dart';
import 'package:ukkhotel/widgets/menu_bottom.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  TextEditingController typeNameInput = TextEditingController();
  TextEditingController hargaInput = TextEditingController();
  TextEditingController descInput = TextEditingController();
  TextEditingController photoInput = TextEditingController();
  LoginController? loginController = LoginController();
  TypeController type = TypeController();
  String? nama;

  // String? type_name;
  // double? price;
  // String? desc;

  getDataLogin() async {
    var dataLogin = await loginController!.getDataLogin();
    if (dataLogin!["status"] != null) {
      var data = jsonDecode(dataLogin['dataLogin']);
      var namaUser = data["user"]["name"];
      setState(() {
        nama = namaUser;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDataLogin();
  }

  XFile? selectedImage;
  Future getImage() async {
    var image = await ImagePicker().pickImage(source: ImageSource.camera);

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(nama == null ? '' : nama!),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              Text("Tambah Type Lamar"),
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
                    var data = {
                      "type_name": typeNameInput.text,
                      "price": hargaInput.text,
                      "desc": descInput.text,
                      "photo": selectedImage,
                    };
                    var result = await type.InsertType(data);
                    print(result);
                  },
                  child: Text("Simpan"))
            ],
          ),
        ),
      ),
      bottomNavigationBar: MenuBottom(0),
    );
  }
}
