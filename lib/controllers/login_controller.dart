import 'package:ukkhotel/services.dart/login.dart';

class LoginController {
  LoginService? loginServ;
  Future loginAct(request) async {
    final login = await loginServ!.loginAct(request);
    if (login != null) {
      print(login);
      return login;
    } else {
      return null;
    }
  }
}
