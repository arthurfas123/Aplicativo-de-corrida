import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import '../data/models/user.dart';
import '../data/models/atividade.dart';

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

  Future<void> cadastrarUsuario({
    required String nomeUsuario,
    required String senha,
    required String nomeCompleto,
    required String email,
    String? telefone,
    DateTime? dataNascimento,
    String? genero,
    String? fotoPerfilUrl,
  }) async {
    if (usuarioExiste(nomeUsuario)) {
      throw Exception('Usuário já existe');
    }

    final novoUsuario = User(
      nomeUsuario: nomeUsuario,
      senha: senha,
      nomeCompleto: nomeCompleto,
      email: email,
      telefone: telefone,
      dataNascimento: dataNascimento,
      genero: genero,
      fotoPerfilUrl: fotoPerfilUrl,
    );

    _usuarios.add(novoUsuario);
    await salvarUsuarios();
  }

  Future<void> adicionarAtividadeParaUsuario(String nomeUsuario, Atividade atividade) async {
    final user = _usuarios.firstWhere(
      (u) => u.nomeUsuario == nomeUsuario,
      orElse: () => throw Exception("Usuário não encontrado"),
    );
    user.atividades.add(atividade);
    await salvarUsuarios();
  }

  Future<void> removerAtividadeParaUsuario(String nomeUsuario, Atividade atividade) async {
    final user = _usuarios.firstWhere(
      (u) => u.nomeUsuario == nomeUsuario,
      orElse: () => throw Exception("Usuário não encontrado"),
    );
    user.atividades.remove(atividade);
    await salvarUsuarios();
  }

  bool autenticar(String nomeUsuario, String senha) {
    return _usuarios.any((u) => u.nomeUsuario == nomeUsuario && u.senha == senha);
  }

  bool usuarioExiste(String nomeUsuario) {
    return _usuarios.any((u) => u.nomeUsuario == nomeUsuario);
  }

  User? _usuarioAtual;

  User? get usuarioAtual => _usuarioAtual;

  void setUsuarioAtual(User user) {
    _usuarioAtual = user;
  }

  List<User> get usuarios => _usuarios;
}
