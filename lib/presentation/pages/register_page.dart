import 'package:flutter/material.dart';
import '../../controllers/user_controller.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String userName = '';
  String senha = '';
  String nomeCompleto = '';
  String email = '';
  String telefone = '';
  DateTime? dataNascimento;
  String genero = '';
  String fotoPerfilUrl = '';
  String mensagemErro = '';

  final List<String> generos = ['Masculino', 'Feminino', 'Outro'];

  Future<void> _selecionarDataNascimento() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(2000),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        dataNascimento = picked;
      });
    }
  }

  String _formatarData(DateTime data) {
    return '${data.day.toString().padLeft(2, '0')}/${data.month.toString().padLeft(2, '0')}/${data.year}';
  }

  Widget _body() {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/images/logo.png', height: 150),
                const SizedBox(height: 10),

                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(children: [
                      TextField(
                        onChanged: (text) => userName = text,
                        decoration: InputDecoration(
                          labelText: 'Nome de usuário',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      SizedBox(height: 10),
                      TextField(
                        onChanged: (text) => senha = text,
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: 'Senha',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      SizedBox(height: 10),
                      TextField(
                        onChanged: (text) => nomeCompleto = text,
                        decoration: InputDecoration(
                          labelText: 'Nome completo',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      SizedBox(height: 10),
                      TextField(
                        onChanged: (text) => email = text,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          labelText: 'E-mail',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      SizedBox(height: 10),
                      TextField(
                        onChanged: (text) => telefone = text,
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                          labelText: 'Telefone (opcional)',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      SizedBox(height: 10),

                      Row(
                        children: [
                          Expanded(
                            child: OutlinedButton(
                              onPressed: _selecionarDataNascimento,
                              child: Text(
                                dataNascimento != null
                                    ? _formatarData(dataNascimento!)
                                    : 'Selecionar data de nascimento',
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      DropdownButtonFormField<String>(
                        value: genero.isNotEmpty ? genero : null,
                        items: generos.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            genero = value ?? '';
                          });
                        },
                        decoration: InputDecoration(
                          labelText: 'Gênero',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      SizedBox(height: 10),
                      TextField(
                        onChanged: (text) => fotoPerfilUrl = text,
                        decoration: InputDecoration(
                          labelText: 'URL da foto de perfil (opcional)',
                          border: OutlineInputBorder(),
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
                          setState(() => mensagemErro = '');

                          if ([userName, senha, nomeCompleto, email].any((e) => e.isEmpty) || dataNascimento == null || genero.isEmpty) {
                            setState(() => mensagemErro = 'Preencha todos os campos obrigatórios.');
                            return;
                          }

                          if (UserController.instance.usuarioExiste(userName)) {
                            setState(() => mensagemErro = 'Usuário já existe.');
                            return;
                          }

                          try {
                            await UserController.instance.cadastrarUsuario(
                              nomeUsuario: userName,
                              senha: senha,
                              nomeCompleto: nomeCompleto,
                              email: email,
                              telefone: telefone.isNotEmpty ? telefone : null,
                              dataNascimento: dataNascimento,
                              genero: genero,
                              fotoPerfilUrl: fotoPerfilUrl.isNotEmpty ? fotoPerfilUrl : null,
                            );

                            final user = UserController.instance.usuarios
                                .firstWhere((u) => u.nomeUsuario == userName);
                            UserController.instance.setUsuarioAtual(user);

                            Navigator.of(context).pushReplacementNamed('/home');
                          } catch (e) {
                            setState(() => mensagemErro = e.toString());
                          }
                        },
                        child: Container(
                          width: double.infinity,
                          alignment: Alignment.center,
                          child: Text('Cadastrar'),
                        ),
                      ),
                    ]),
                  ),
                ),
              ]),
        ),
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
          onPressed: () => Navigator.of(context).pushReplacementNamed('/'),
        ),
      ),
      body: _body(),
    );
  }
}
