import 'package:flutter/material.dart';

class ToastWidget {
  static toastAlert(BuildContext context, status, message) {
    var status1 = status == 'success'
        ? Colors.green
        : (status == 'warning' ? Colors.orange : Colors.red);
    SnackBar snackbar = SnackBar(
      content: Text("ok"),
      backgroundColor: status1,
      dismissDirection: DismissDirection.up,
      behavior: SnackBarBehavior.floating,
      margin: EdgeInsets.all(15),
    );
    return ScaffoldMessenger.of(context).showSnackBar(snackbar);
  }
}
