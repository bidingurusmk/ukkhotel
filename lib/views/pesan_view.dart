import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ukkhotel/controllers/type_controller.dart';
import 'package:ukkhotel/models/response_data.dart';
import 'package:ukkhotel/services.dart/base_url.dart';

class PesanView extends StatefulWidget {
  const PesanView({super.key});

  @override
  State<PesanView> createState() => _PesanViewState();
}

class _PesanViewState extends State<PesanView> {
  TextEditingController checkin = TextEditingController();
  TypeController type = TypeController();
  ResponseData? listtype;
  List items = ["ok", "sssip", "sok", "ssssip", "osssk", "sip"];
  String check_in = DateFormat('yyyy-MM-dd').format(DateTime.now()).toString();
  String check_out = DateFormat('yyyy-MM-dd').format(DateTime.now()).toString();

  getType_aavailable() async {
    var data_checkin = {'check_in': check_in, 'check_out': check_out};
    var getdata = await type.getType_available(data_checkin);
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
    getType_aavailable();
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
        body: Column(
          children: [
            TextField(
              controller: checkin,
              decoration: InputDecoration(label: Text("Tanggal Checkin")),
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
                  setState(() {
                    check_in = checkin.text == ''
                        ? DateFormat('yyyy-MM-dd')
                            .format(DateTime.now())
                            .toString()
                        : DateFormat('yyyy-MM-dd')
                            .format(
                                DateTime.parse(checkin.text.split(" - ")[0]))
                            .toString();
                    check_out = checkin.text == ''
                        ? DateFormat('yyyy-MM-dd')
                            .format(DateTime.now())
                            .toString()
                        : DateFormat('yyyy-MM-dd')
                            .format(
                                DateTime.parse(checkin.text.split(" - ")[1]))
                            .toString();
                  });
                  getType_aavailable();
                });
              },
            ),
            Expanded(
              child: GridView.extent(
                  maxCrossAxisExtent: 200.0, // maximum item width
                  mainAxisSpacing: 8.0, // spacing between rows
                  crossAxisSpacing: 8.0, // spacing between columns
                  padding: EdgeInsets.all(8.0), // padding around the grid

                  children: listtype != null
                      ? listtype!.data!.map((item) {
                          return InkWell(
                            onTap: () {
                              Navigator.pushNamed(context, "/detailhotel",
                                  arguments: {
                                    'data': item,
                                    'tglCheckin': checkin.text
                                  });
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
                                          image:
                                              NetworkImage(item["photo_path"]!),
                                          placeholder:
                                              AssetImage("assets/loading.gif"),
                                          imageErrorBuilder:
                                              (context, error, stackTrace) {
                                            return Image.asset(
                                                'assets/error.png',
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
                      : List.empty()),
            ),
          ],
        ));
  }
}
