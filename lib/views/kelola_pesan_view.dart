import 'package:flutter/material.dart';
import 'package:ukkhotel/controllers/login_controller.dart';
import 'package:ukkhotel/controllers/pesan_controller.dart';
import 'package:ukkhotel/widgets/alert.dart';
import 'package:ukkhotel/widgets/menu_bottom.dart';

class KelolaPesanView extends StatefulWidget {
  const KelolaPesanView({super.key});

  @override
  State<KelolaPesanView> createState() => _KelolaPesanViewState();
}

class _KelolaPesanViewState extends State<KelolaPesanView> {
  LoginController? loginController = LoginController();
  PesanController pesan = PesanController();
  String? nama;
  List? dataPesan;
  List statusPesan = ["Check In", "Check Out"];
  getPesan() async {
    var Pesan = await pesan.getPesan();
    setState(() {
      if (Pesan != null) {
        dataPesan = Pesan.data;
      } else {
        dataPesan = null;
      }
    });
  }

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
    getPesan();
  }

  @override
  void setState(VoidCallback fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(nama == null ? '' : nama!),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: dataPesan != null
            ? Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 90 / 100,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [_createDataTable()],
                ),
              )
            : Center(child: CircularProgressIndicator()),
      ),
      bottomNavigationBar: MenuBottom(1),
    );
  }

  DataTable _createDataTable() {
    return DataTable(columns: _createColumns(), rows: _createRows());
  }

  List<DataColumn> _createColumns() {
    return [
      DataColumn(label: Text('order ID')),
      DataColumn(label: Text('Order Number')),
      DataColumn(label: Text('Customer Name')),
      DataColumn(label: Text('Customer Email')),
      DataColumn(label: Text('Order Date')),
      DataColumn(label: Text('CheckIN')),
      DataColumn(label: Text('CheckOUT')),
      DataColumn(label: Text('Guest Name')),
      DataColumn(label: Text('Rooms Amount')),
      DataColumn(label: Text('Status')),
      DataColumn(label: Text('TypeID')),
      DataColumn(label: Text("Aksi"))
    ];
  }

  List<DataRow> _createRows() {
    return dataPesan != null
        ? dataPesan!
            .map((psn) => DataRow(cells: [
                  DataCell(Text('#' + psn['order_id'].toString())),
                  DataCell(Text(psn['order_number'].toString())),
                  DataCell(Text(psn['customer_name'])),
                  DataCell(Text(psn['customer_email'])),
                  DataCell(Text(psn['order_date'])),
                  DataCell(Text(psn['check_in'])),
                  DataCell(Text(psn['check_out'])),
                  DataCell(Text(psn['guest_name'])),
                  DataCell(Text(psn['rooms_amount'].toString())),
                  DataCell(Text(psn['status'])),
                  DataCell(Text(psn['type_id'].toString())),
                  DataCell(PopupMenuButton(itemBuilder: (BuildContext context) {
                    return statusPesan.map((r) {
                      return PopupMenuItem(
                        value: r,
                        child: Text(r),
                        onTap: () async {
                          var data = {
                            'status': r,
                          };
                          var update =
                              await pesan.updateStatus(psn['order_id'], data);
                          // print(update.status);
                          if (update.status == true) {
                            AlertMessage()
                                .showAlert(context, update.message, true);
                            getPesan();
                          }
                        },
                      );
                    }).toList();
                  })),
                ]))
            .toList()
        : List.empty();
  }
}
