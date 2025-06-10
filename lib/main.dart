import 'package:flutter/cupertino.dart';
import 'App_Widget.dart';
import 'controllers/UserController.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await UserController.instance.carregarUsuarios();
  runApp(AppWidget());
}
