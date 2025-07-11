import 'package:aplicativo_de_corrida/controllers/run_controller.dart';
import 'package:flutter/material.dart';
import '../../controllers/theme_controller.dart';
import '../pages/home_page.dart';
import '../pages/login_page.dart';
import '../pages/register_page.dart';
import '../pages/profile_page.dart';
import '../pages/medalhas_page.dart';
import '../pages/statistic_page.dart';

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
              '/registrar': (context) => RegisterPage(),
              '/medalhas': (context) => const MedalhasPage(),
              '/home': (context) => HomePage(),
              '/adicionar_corrida': (context) => AdicionarCorrida(),
              '/perfil': (context) => ProfilePage(),
              '/statistic': (context) => StatisticPage()
            }
        );
      });
  }
}