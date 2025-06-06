import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../models/Atividade.dart';
import '../controllers/UserController.dart';


class AdicionarCorrida extends StatelessWidget {
  String tempo = '';
  String titulo = '';
  String distancia = '';
  String descricao = '';
  String ritmo = '';

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(title: Text('Nova corrida'),),
        body: Card(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                  decoration:
                  InputDecoration(
                      labelText: 'Titulo',
                      border: OutlineInputBorder()
                  ),
                  onChanged: (text){
                    titulo = text;
                  },
              ),
              Container(height: 8),

              TextField(
                  decoration:
                  InputDecoration(
                    labelText: 'Distancia',
                    border: OutlineInputBorder()
                  ),
                  onChanged: (text){
                    distancia = text;
                  },
              ),
              Container(height: 8),

              TextField(
                  decoration:
                  InputDecoration(
                      labelText: 'Tempo',
                      border: OutlineInputBorder()
                  ),
                  onChanged: (text){
                    tempo = text;
                  },
              ),
              Container(height: 8),

              TextField(
                decoration:
                InputDecoration(
                    labelText: 'Descrição',
                    border: OutlineInputBorder()
                ),
                onChanged: (text){
                  descricao = text;
                },
              ),
              Container(height: 8),

              ElevatedButton(
                onPressed: (){

                },
                child: Container(
                  height: 40,
                  width: 100,
                  child: Center(child: Text('Adicionar')),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
