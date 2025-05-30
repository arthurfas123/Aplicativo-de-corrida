import 'package:flutter/material.dart';
import 'App_controller.dart';
import 'Home_page.dart';
import 'Login_page.dart';

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
                '/home': (context) => HomePage()
              }
          );
        });
  }
}