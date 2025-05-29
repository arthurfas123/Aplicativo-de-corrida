import 'package:flutter/material.dart';
import 'App_controller.dart';

class CustomSwitch extends StatelessWidget {
  const CustomSwitch({super.key});

  @override
  Widget build(BuildContext context) {
    return Switch(
        value: AppController.instance.isDarkTheme,
        onChanged: (value){
          AppController.instance.changeTheme();
        }
    );
  }
}