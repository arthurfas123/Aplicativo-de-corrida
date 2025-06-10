import 'package:flutter/material.dart';
import '../../controllers/User_controller.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String userName = '';
  String senha = '';
  String mensagemErro = '';

  Widget _body() {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
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
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Nome de usuário',
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

                      if (mensagemErro.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.only(bottom: 15),
                          child: Text(
                            mensagemErro,
                            style: TextStyle(color: Colors.red),
                          ),
                        ),

                      ElevatedButton(
                        onPressed: () async {
                          setState(() {
                            mensagemErro = '';
                          });

                          if (userName.isEmpty || senha.isEmpty) {
                            setState(() {
                              mensagemErro = 'Preencha todos os campos.';
                            });
                            return;
                          }

                          if (UserController.instance.usuarioExiste(userName)) {
                            setState(() {
                              mensagemErro = 'Usuário já existe.';
                            });
                          } else {
                            await UserController.instance.cadastrarUsuario(userName, senha);

                            final user = UserController.instance.usuarios
                                .firstWhere((u) => u.nome == userName);
                            UserController.instance.setUsuarioAtual(user);

                            Navigator.of(context).pushReplacementNamed('/home');
                          }
                        },
                        child: Container(
                          width: double.infinity,
                          alignment: Alignment.center,
                          child: Text('Cadastrar'),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ]),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registrar'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pushReplacementNamed('/');  // volta para a tela inicial
          },
        ),
      ),
      body: Stack(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height,
            //child: Image.asset('assets/images/jaba.jpeg', fit: BoxFit.cover),
          ),
          _body(),
        ],
      ),
    );
  }
}
