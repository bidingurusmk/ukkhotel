import 'package:flutter/material.dart';
import 'package:ukkhotel/controllers/type_controller.dart';
import 'package:ukkhotel/models/response_data.dart';
import 'package:ukkhotel/services.dart/base_url.dart';

class PesanView extends StatefulWidget {
  const PesanView({super.key});

  @override
  State<PesanView> createState() => _PesanViewState();
}

class _PesanViewState extends State<PesanView> {
  TypeController type = TypeController();
  ResponseData? listtype;
  List items = ["ok", "sssip", "sok", "ssssip", "osssk", "sip"];
  getTypes() async {
    var getdata = await type.getType();
    if (getdata != null) {
      setState(() {
        listtype = getdata;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getTypes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Pesan Hotel"),
          backgroundColor: Colors.orange,
          foregroundColor: Colors.white,
          automaticallyImplyLeading: false,
        ),
        body: GridView.extent(
            maxCrossAxisExtent: 200.0, // maximum item width
            mainAxisSpacing: 8.0, // spacing between rows
            crossAxisSpacing: 8.0, // spacing between columns
            padding: EdgeInsets.all(8.0), // padding around the grid

            children: listtype != null
                ? listtype!.data!.map((item) {
                    return InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, "/detailhotel",
                            arguments: item);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.grey)),
                        child: Column(
                          children: [
                            Container(
                              child: Stack(
                                children: [
                                  FadeInImage(
                                    image: NetworkImage(
                                        baseUrlService().baseUrl +
                                            "/" +
                                            item["photo_path"]!),
                                    placeholder:
                                        AssetImage("assets/loading.gif"),
                                    imageErrorBuilder:
                                        (context, error, stackTrace) {
                                      return Image.asset('assets/error.png',
                                          fit: BoxFit.fitHeight);
                                    },
                                    fit: BoxFit.fitHeight,
                                  ),
                                ],
                              ),
                            ),
                            Text(
                              item["type_name"],
                              style: TextStyle(fontSize: 18.0),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList()
                : List.empty()));
  }
}
