import 'package:flutter/material.dart';
import '../../controllers/user_controller.dart';

class MedalhasPage extends StatelessWidget {
  const MedalhasPage({super.key});

  @override
  Widget build(BuildContext context) {
    final usuario = UserController.instance.usuarioAtual!;
    final atividades = usuario.atividades;

    double maiorDistancia = 0;
    Duration tempoMaisRapido = Duration(days: 365); // valor alto por padrão

    final List<Map<String, dynamic>> medalhas = [
      {
        'titulo': 'Primeira Corrida',
        'descricao': 'Parabéns por registrar sua primeira corrida!',
        'conquistada': atividades.isNotEmpty,
        'icone': Icons.directions_run,
      },
      {
        'titulo': '5km Conquistados',
        'descricao': 'Você correu pelo menos 5 km em uma única atividade.',
        'conquistada': maiorDistancia >= 5,
        'icone': Icons.directions_walk,
      },
      {
        'titulo': '10km Conquistados',
        'descricao': 'Você correu pelo menos 10 km em uma única atividade.',
        'conquistada': maiorDistancia >= 10,
        'icone': Icons.directions_bike,
      },
      {
        'titulo': 'Corrida Relâmpago',
        'descricao': 'Você completou uma corrida com tempo abaixo de 15 minutos.',
        'conquistada': tempoMaisRapido.inMinutes < 15,
        'icone': Icons.flash_on,
      },
    ];

    return Scaffold(
      appBar: AppBar(title: Text('Minhas Medalhas')),
      body: ListView.builder(
        itemCount: medalhas.length,
        itemBuilder: (context, index) {
          final medalha = medalhas[index];
          return Card(
            color: medalha['conquistada'] ? Colors.amber[100] : Colors.grey[300],
            margin: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: ListTile(
              leading: Icon(
                medalha['icone'],
                color: medalha['conquistada'] ? Colors.orange : Colors.grey,
                size: 40,
              ),
              title: Text(medalha['titulo']),
              subtitle: Text(medalha['descricao']),
              trailing: medalha['conquistada']
                  ? Icon(Icons.emoji_events, color: Colors.orange)
                  : Icon(Icons.lock_outline),
            ),
          );
        },
      ),
    );
  }
}
