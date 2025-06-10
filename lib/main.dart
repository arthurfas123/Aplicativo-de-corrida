import 'package:flutter/cupertino.dart';
import 'presentation/widgets/App_Widget.dart';
import 'presentation/controllers/UserController.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await UserController.instance.carregarUsuarios();
  runApp(AppWidget());
}
