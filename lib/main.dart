import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ukkhotel/views/home_view.dart';
import 'package:ukkhotel/views/login_view.dart';
import 'package:ukkhotel/views/rooms.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences.setMockInitialValues({});
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var isLoggedIn =
      (prefs.getBool('is_login') == null) ? false : prefs.getBool('is_login');
  print(prefs.getBool('is_login'));
  runApp(MaterialApp(
    initialRoute: isLoggedIn != false ? '/' : '/login',
    routes: {
      '/': (_) => HomeView(),
      '/login': (_) => LoginView(),
      '/rooms': (_) => RommsView(),
    },
  ));
}
