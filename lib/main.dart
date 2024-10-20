import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ukkhotel/controllers/login_controller.dart';
import 'package:ukkhotel/views/cek_pesanan.dart';
import 'package:ukkhotel/views/confirmasi_keluar.dart';
import 'package:ukkhotel/views/dashboard_view.dart';
import 'package:ukkhotel/views/detail_hotel_view.dart';
import 'package:ukkhotel/views/type_view.dart';
import 'package:ukkhotel/views/kelola_pesan_view.dart';
import 'package:ukkhotel/views/login_view.dart';
import 'package:ukkhotel/views/pesan_view.dart';
import 'package:ukkhotel/views/rooms.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences.setMockInitialValues({});
  LoginController roles = LoginController();
  // SharedPreferences prefs = await SharedPreferences.getInstance();
  // var isLoggedIn =
  // (prefs.getBool('is_login') == null) ? false : prefs.getBool('is_login');
  var dataLogin = await roles.getDataLogin();
  var isLoggedIn;
  String? role = null;
  if (dataLogin!.status != false) {
    isLoggedIn = true;
    role = dataLogin.role;
  } else {
    isLoggedIn = false;
    role = null;
  }
  // print(prefs.getBool('is_login'));
  runApp(MaterialApp(
    initialRoute: isLoggedIn != false ? '/dashboard' : '/login',
    routes: {
      '/login': (_) => LoginView(),
      '/typeroom': (_) => TypeView(),
      '/rooms': (_) => RommsView(),
      '/pesan': (_) => PesanView(),
      '/detailhotel': (_) => DetailHotelView(),
      "/kelolapesan": (_) => KelolaPesanView(),
      "/": (_) => ConfirmKeluar(),
      "/dashboard": (_) => DashboardView(),
      "/cekpesanan": (_) => CekPesanan(),
    },
  ));
}
