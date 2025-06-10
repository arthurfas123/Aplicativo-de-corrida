import '../../controllers/theme_controller.dart';
import 'package:flutter/material.dart';
import '../../controllers/user_controller.dart';

class HomePage extends StatefulWidget{
  const HomePage({super.key});

  @override
  State<HomePage> createState() {
    return HomePageState();
  }
}

class HomePageState extends State<HomePage>{
  @override
  Widget build(BuildContext context) {
    final usuario = UserController.instance.usuarioAtual;
    if (usuario == null) {
      return Scaffold(
        appBar: AppBar(title: Text('Erro')),
        body: Center(child: Text('Erro: usuário não encontrado')),
      );
    }

    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              currentAccountPicture: ClipRRect(
                borderRadius: BorderRadius.circular(40),
                child: null,
              ),
              accountName: Text(usuario.nomeUsuario),
              accountEmail: null,
            ),

            ListTile(
              leading: Icon(Icons.home),
              title: Text('Logout'),
              subtitle: Text('Finalizar sessão'),
              onTap: (){
                Navigator.of(context).pushReplacementNamed('/');
              },
            ),

            ListTile(
              leading: Icon(Icons.shield_moon),
              title: Text('Modo noturno'),
              subtitle: Text('Mudar para modo noturno'),
              onTap: (){
                setState(() {
                  AppController.instance.changeTheme();
                });
              },
            ),
          ],
        ),
      ),

      appBar: AppBar(
        title: Text('Corridas'),
      ),

      body: usuario.atividades.isEmpty
          ? Center(child: Text('Nenhuma corrida cadastrada.'))
          : ListView.builder(
        itemCount: usuario.atividades.length,
        itemBuilder: (context, index) {
          final atividade = usuario.atividades[index];
          return Card(
            margin: EdgeInsets.all(8),
            child: ListTile(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(child: Text(atividade.titulo)),
                  PopupMenuButton<String>(
                    onSelected: (value) {
                      if (value == 'remover') {
                        setState(() {
                          UserController.instance.removerAtividadeParaUsuario(usuario.nomeUsuario, atividade);
                          setState(() {
                          });
                        });
                      }
                    },
                    itemBuilder: (context) => [
                      PopupMenuItem(
                        value: 'remover',
                        child: Text('Remover'),
                      ),
                    ],
                  ),
                ],
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Distância: ${atividade.distancia_em_km} km'),
                  Text('Tempo: ${atividade.tempo_min_seg}'),
                  Text('Ritmo: ${atividade.ritmo}'),
                  if (atividade.descricao.isNotEmpty)
                    Text('Descrição: ${atividade.descricao}'),
                ],
              ),
            ),
          );
        },
      ),

      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () async
        {
          await Navigator.of(context).pushNamed('/adicionar_corrida');
          setState(() {});
        }
      )
    );
  }
}