import 'package:aplicativo_de_corrida/presentation/widgets/add_run.dart';
import 'package:flutter/material.dart';
import '../../controllers/theme_controller.dart';
import '../pages/home_page.dart';
import '../pages/login_page.dart';

class AppWidget extends StatelessWidget{
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: AppController.instance,
      builder: (context, child){
        return MaterialApp(
            theme: ThemeData(
                primarySwatch: Colors.red,
                useMaterial3: false,
                brightness: AppController.instance.isDarkTheme
                    ? Brightness.dark
                    : Brightness.light
            ),
            routes: {
              '/': (context) => LoginPage(),
              '/home': (context) => HomePage(),
              '/adicionar_corrida': (context) => AdicionarCorrida()
            }
        );
      });
  }
}