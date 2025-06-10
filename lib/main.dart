import 'package:flutter/cupertino.dart';
import 'presentation/widgets/app.dart';
import 'controllers/user_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await UserController.instance.carregarUsuarios();
  runApp(AppWidget());
}
