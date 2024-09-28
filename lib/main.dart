import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ukkhotel/views/home_view.dart';
import 'package:ukkhotel/views/login_view.dart';

void main() {
  SharedPreferences.setMockInitialValues({});
  runApp(MaterialApp(
    initialRoute: '/login',
    routes: {
      '/': (_) => HomeView(),
      '/login': (_) => LoginView(),
    },
  ));
}
