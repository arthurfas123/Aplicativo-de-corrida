import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import '/models/User.dart';
import '/models/Atividade.dart';

class UserController {
  static final UserController instance = UserController._();
  UserController._();

  List<User> _usuarios = [];

  Future<File> get _file async {
    final directory = await getApplicationDocumentsDirectory();
    return File('${directory.path}/usuarios.json');
  }

  Future<void> carregarUsuarios() async {
    final file = await _file;

    if (await file.exists()) {
      final content = await file.readAsString();
      final List decoded = jsonDecode(content);
      _usuarios = decoded.map((u) => User.fromJson(u)).toList();
    }
  }

  Future<void> salvarUsuarios() async {
    final file = await _file;
    final content = jsonEncode(_usuarios.map((u) => u.toJson()).toList());
    await file.writeAsString(content);
    print("Usuários salvos em: ${file.path}");
  }

  Future<void> cadastrarUsuario(String nome, String senha) async {
    _usuarios.add(User(nome: nome, senha: senha));
    await salvarUsuarios();
  }

  Future<void> adicionarAtividadeParaUsuario(String nome, Atividade atividade) async {
    final user = _usuarios.firstWhere((u) => u.nome == nome, orElse: () => throw Exception("Usuário não encontrado"));
    user.atividades.add(atividade);
    await salvarUsuarios();
  }

  Future<void> removerAtividadeParaUsuario(String nome, Atividade atividade) async {
    final user = _usuarios.firstWhere((u) => u.nome == nome, orElse: () => throw Exception("Usuário não encontrado"));
    user.atividades.remove(atividade);
    await salvarUsuarios();
  }

  bool autenticar(String nome, String senha) {
    return _usuarios.any((u) => u.nome == nome && u.senha == senha);
  }

  bool usuarioExiste(String nome) {
    return _usuarios.any((u) => u.nome == nome);
  }

  User? _usuarioAtual;

  User? get usuarioAtual => _usuarioAtual;
  void setUsuarioAtual(User user) {
    _usuarioAtual = user;
  }

  List<User> get usuarios => _usuarios;
}
