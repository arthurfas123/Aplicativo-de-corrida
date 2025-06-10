import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../controllers/user_controller.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _nomeController;
  late TextEditingController _emailController;
  late TextEditingController _telefoneController;
  late TextEditingController _generoController;
  DateTime? _dataNascimento;
  String? _fotoLocalPath;

  @override
  void initState() {
    super.initState();

    final user = UserController.instance.usuarioAtual!;
    _nomeController = TextEditingController(text: user.nomeCompleto);
    _emailController = TextEditingController(text: user.email);
    _telefoneController = TextEditingController(text: user.telefone ?? '');
    _generoController = TextEditingController(text: user.genero ?? '');
    _dataNascimento = user.dataNascimento;
    _fotoLocalPath = user.fotoPerfilUrl;
  }

  Future<void> _selecionarDataNascimento() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _dataNascimento ?? DateTime(2000),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() => _dataNascimento = picked);
    }
  }

  String _formatarData(DateTime data) {
    return '${data.day.toString().padLeft(2, '0')}/${data.month.toString().padLeft(2, '0')}/${data.year}';
  }

  Future<void> _escolherNovaImagem() async {
    final ImagePicker picker = ImagePicker();
    final XFile? imagemSelecionada = await picker.pickImage(source: ImageSource.gallery);

    if (imagemSelecionada != null) {
      setState(() {
        _fotoLocalPath = imagemSelecionada.path;
      });
    }
  }

  Future<void> _salvarAlteracoes() async {
    if (!_formKey.currentState!.validate()) return;

    final user = UserController.instance.usuarioAtual!;

    user.nomeCompleto = _nomeController.text;
    user.email = _emailController.text;
    user.telefone = _telefoneController.text;
    user.genero = _generoController.text;
    user.dataNascimento = _dataNascimento;
    user.fotoPerfilUrl = _fotoLocalPath;

    await UserController.instance.salvarUsuarios();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Informações salvas com sucesso!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool imagemExiste = _fotoLocalPath != null && File(_fotoLocalPath!).existsSync();

    return Scaffold(
      appBar: AppBar(
        title: Text('Meu Perfil'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(children: [
            GestureDetector(
              onTap: _escolherNovaImagem,
              child: CircleAvatar(
                radius: 60,
                backgroundImage: imagemExiste
                    ? FileImage(File(_fotoLocalPath!))
                    : AssetImage('assets/images/default_avatar.png') as ImageProvider,
              ),
            ),
            const SizedBox(height: 16),

            TextFormField(
              controller: _nomeController,
              decoration: InputDecoration(labelText: 'Nome completo'),
              validator: (value) => value == null || value.isEmpty ? 'Informe seu nome' : null,
            ),
            const SizedBox(height: 10),

            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'E-mail'),
              keyboardType: TextInputType.emailAddress,
              validator: (value) => value == null || value.isEmpty ? 'Informe seu e-mail' : null,
            ),
            const SizedBox(height: 10),

            TextFormField(
              controller: _telefoneController,
              decoration: InputDecoration(labelText: 'Telefone'),
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 10),

            TextFormField(
              controller: _generoController,
              decoration: InputDecoration(labelText: 'Gênero'),
            ),
            const SizedBox(height: 10),

            Row(
              children: [
                Icon(Icons.cake, size: 20),
                const SizedBox(width: 8),
                Expanded(
                  child: OutlinedButton(
                    onPressed: _selecionarDataNascimento,
                    child: Text(_dataNascimento != null
                        ? _formatarData(_dataNascimento!)
                        : 'Selecionar data de nascimento'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: _salvarAlteracoes,
              child: Text('Salvar alterações'),
            ),
          ]),
        ),
      ),
    );
  }
}
