import 'package:flutter/material.dart';
import '../../controllers/user_controller.dart';
import '../../data/models/atividade.dart';

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
  DateTime? dataSelecionada;

  Future<void> _selecionarDataCorrida() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        dataSelecionada = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Nova corrida')),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(labelText: 'Título', border: OutlineInputBorder()),
              onChanged: (text) => titulo = text,
            ),
            SizedBox(height: 8),
            TextField(
              decoration: InputDecoration(labelText: 'Distância (km)', border: OutlineInputBorder()),
              onChanged: (text) => distancia = text,
            ),
            SizedBox(height: 8),
            TextField(
              decoration: InputDecoration(labelText: 'Tempo (min:seg)', border: OutlineInputBorder()),
              onChanged: (text) => tempo = text,
            ),
            SizedBox(height: 8),
            TextField(
              decoration: InputDecoration(labelText: 'Ritmo', border: OutlineInputBorder()),
              onChanged: (text) => ritmo = text,
            ),
            SizedBox(height: 8),
            TextField(
              decoration: InputDecoration(labelText: 'Descrição', border: OutlineInputBorder()),
              onChanged: (text) => descricao = text,
            ),
            SizedBox(height: 8),
            ElevatedButton(
              onPressed: _selecionarDataCorrida,
              child: Text('Selecionar Data da Corrida'),
            ),
            SizedBox(height: 8),
            Text(
              dataSelecionada == null
                  ? 'Nenhuma data selecionada'
                  : '${dataSelecionada!.day.toString().padLeft(2, '0')}/'
                  '${dataSelecionada!.month.toString().padLeft(2, '0')}/'
                  '${dataSelecionada!.year}',
              style: TextStyle(fontSize: 16),
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
                if (dataSelecionada == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Selecione a data da corrida.')),
                  );
                  return;
                }

                final novaAtividade = Atividade(
                  titulo: titulo,
                  distancia_em_km: distancia,
                  tempo_min_seg: tempo,
                  ritmo: ritmo,
                  descricao: descricao,
                  data: dataSelecionada!,
                );

                await UserController.instance.adicionarAtividadeParaUsuario(
                  usuario.nomeUsuario,
                  novaAtividade,
                );

                Navigator.of(context).pop();
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
