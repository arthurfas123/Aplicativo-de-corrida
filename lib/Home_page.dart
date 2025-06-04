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
      drawer: Drawer(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              currentAccountPicture: ClipRRect(
                borderRadius: BorderRadius.circular(40),
                child: Image.network('https://ichef.bbci.co.uk/ace/ws/660/amz/worldservice/live/assets/images/2015/09/26/150926165742__85730600_monkey2.jpg.webp'),
              ),
              accountName: Text('Arthur felipe'),
              accountEmail: Text('Arthurfas123@gmail.com')
            ),

            ListTile(
              leading: Icon(Icons.home),
              title: Text('Inicio'),
              subtitle: Text('Tela de inicio'),
              onTap: (){
                print('home');
              },
            ),

            ListTile(
              leading: Icon(Icons.home),
              title: Text('Logout'),
              subtitle: Text('Finalizar sessão'),
              onTap: (){
                Navigator.of(context).pushReplacementNamed('/');
              },
            )
          ],
        ),
      ),
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