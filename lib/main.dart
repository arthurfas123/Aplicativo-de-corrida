import 'package:aplicativo_de_corrida/presentation/widgets/app.dart';
import 'package:flutter/cupertino.dart';
import 'controllers/User_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await UserController.instance.carregarUsuarios();
  runApp(AppWidget());
}
