import 'package:flutter/material.dart';

import 'controllers/UserController.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String userName = '';
  String senha = '';

  Widget _body()
  {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children:[
              SizedBox(
                height: 200,
                width: 200,
                child: Image.asset('assets/images/logo.png'),
              ),
              SizedBox(height: 10),

              Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      TextField(
                        onChanged: (text) {
                          userName = text;
                        },
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Nome de usuario',
                        ),
                      ),
                      SizedBox(height: 10),

                      TextField(
                        onChanged: (text) {
                          senha = text;
                        },
                        obscureText: true,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Senha',
                        ),
                      ),
                      SizedBox(height: 15),

                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                                onPressed: () async {
                                  final ok = UserController.instance.autenticar(userName, senha);
                                  if (ok) {
                                    final user = UserController.instance.usuarios
                                        .firstWhere((u) => u.nome == userName);
                                    UserController.instance.setUsuarioAtual(user);

                                    Navigator.of(context).pushReplacementNamed('/home');
                                  }
                                  else
                                  {
                                      print('Login invalido');
                                  }
                                },
                                child: Container(
                                    width: double.infinity,
                                    child: Text('Entrar', textAlign: TextAlign.center,))
                            ),
                          ),
                          SizedBox(width: 10,),

                          Expanded(
                            child: ElevatedButton(
                                onPressed: () async {
                                  if (userName.isEmpty || senha.isEmpty) {
                                      print('preencha todos os campos');
                                    return;
                                  }

                                  if (UserController.instance.usuarioExiste(userName)) {
                                      print('ja existe');
                                  } else {
                                    await UserController.instance.cadastrarUsuario(userName, senha);

                                    final user = UserController.instance.usuarios
                                        .firstWhere((u) => u.nome == userName);
                                    UserController.instance.setUsuarioAtual(user);
                                    print('tentando cadastar');
                                    print('passando para home');
                                    Navigator.of(context).pushReplacementNamed('/home');
                                  }
                                },
                                child: Container(
                                    width: double.infinity,
                                    child: Text('Cadastrar', textAlign: TextAlign.center))
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              )
            ]
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
        child: Stack(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height,
              child: Image.asset('assets/images/jaba.jpeg', fit: BoxFit.cover),
            ),
            _body()
          ],
        )
    );
  }
}
