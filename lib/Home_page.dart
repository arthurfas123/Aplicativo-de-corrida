import 'dart:ffi';
import 'package:flutter/material.dart';
import 'Custom_widget.dart';

class HomePage extends StatefulWidget{
  const HomePage({super.key});

  @override
  State<HomePage> createState() {
    return HomePageState();
  }
}

class HomePageState extends State<HomePage>{
  int cont = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contador de cliques'),
      ),

      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomSwitch(),
            Text('Clicou: $cont')
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed:(){
            setState((){
              cont++;
            });
          }),
    );
  }
}