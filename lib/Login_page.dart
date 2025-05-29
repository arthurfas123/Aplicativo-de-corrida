import 'dart:ffi';

import 'package:flutter/material.dart';

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
              Container(
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
                                onPressed: () {
                                  if(userName == 'arthur' && senha == '123')
                                  {
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
                                onPressed: () {
                                  if(userName == 'arthur' && senha == '123')
                                  {
                                    Navigator.of(context).pushReplacementNamed('/home');
                                  }
                                  else
                                  {
                                    print('Login invalido');
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
              child: Image.asset('assets/images/plano_de_fundo_login.png', fit: BoxFit.cover),
            ),
            _body()
          ],
        )
    );
  }
}
