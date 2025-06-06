import 'package:flutter/material.dart';
import '../controllers/UserController.dart';
import '../models/Atividade.dart';

class AdicionarCorrida extends StatefulWidget {
  @override
  _AdicionarCorridaState createState() => _AdicionarCorridaState();
}

class _AdicionarCorridaState extends State<AdicionarCorrida> {
  String titulo = '';
  String distancia = '';
  String tempo = '';
  String descricao = '';
  String ritmo = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Nova corrida')),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                  labelText: 'Título', border: OutlineInputBorder()),
              onChanged: (text) {
                titulo = text;
              },
            ),
            SizedBox(height: 8),

            TextField(
              decoration: InputDecoration(
                  labelText: 'Distância (km)', border: OutlineInputBorder()),
              onChanged: (text) {
                distancia = text;
              },
            ),
            SizedBox(height: 8),

            TextField(
              decoration: InputDecoration(
                  labelText: 'Tempo (min:seg)', border: OutlineInputBorder()),
              onChanged: (text) {
                tempo = text;
              },
            ),
            SizedBox(height: 8),

            TextField(
              decoration: InputDecoration(
                  labelText: 'Ritmo', border: OutlineInputBorder()),
              onChanged: (text) {
                ritmo = text;
              },
            ),
            SizedBox(height: 8),

            TextField(
              decoration: InputDecoration(
                  labelText: 'Descrição', border: OutlineInputBorder()),
              onChanged: (text) {
                descricao = text;
              },
            ),
            SizedBox(height: 16),

            ElevatedButton(
              onPressed: () async {
                final usuario = UserController.instance.usuarioAtual;

                if (usuario == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Usuário não logado.')),
                  );
                  return;
                }

                final novaAtividade = Atividade(
                  titulo: titulo,
                  distancia_em_km: distancia,
                  tempo_min_seg: tempo,
                  ritmo: ritmo,
                  descricao: descricao,
                );

                await UserController.instance.adicionarAtividadeParaUsuario(
                  usuario.nome,
                  novaAtividade,
                );

                Navigator.of(context).pop(); // Volta para a HomePage
              },
              child: Container(
                height: 40,
                width: 100,
                alignment: Alignment.center,
                child: Text('Adicionar'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
