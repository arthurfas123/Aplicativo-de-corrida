import 'package:flutter/cupertino.dart';
import 'App_Widget.dart';
import 'controllers/UserController.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (UserController.instance.usuarios.isEmpty) {
    await UserController.instance.cadastrarUsuario('teste', '123');
    print('Usuário teste criado');
  }
  await UserController.instance.carregarUsuarios();
  runApp(AppWidget());
}
