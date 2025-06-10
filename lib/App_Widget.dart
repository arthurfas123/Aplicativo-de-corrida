import 'package:aplicativo_de_corrida/Adicionar_corrida.dart';
import 'package:flutter/material.dart';
import '../controllers/ThemeController.dart';
import 'homePage.dart';
import 'loginPage.dart';

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