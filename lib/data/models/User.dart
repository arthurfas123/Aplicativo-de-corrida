import 'atividade.dart';

class User {
  String nomeUsuario;
  String senha;
  String nomeCompleto;
  String email;
  String? telefone;
  DateTime? dataNascimento;
  String? genero; // ex: 'Masculino', 'Feminino', 'Outro'
  String? fotoPerfilUrl; // pode ser um link ou caminho local
  List<Atividade> atividades;

  User({
    required this.nomeUsuario,
    required this.senha,
    required this.nomeCompleto,
    required this.email,
    this.telefone,
    this.dataNascimento,
    this.genero,
    this.fotoPerfilUrl,
    this.atividades = const [],
  });

  Map<String, dynamic> toJson() => {
    'nomeUsuario': nomeUsuario,
    'senha': senha,
    'nomeCompleto': nomeCompleto,
    'email': email,
    'telefone': telefone,
    'dataNascimento': dataNascimento?.toIso8601String(),
    'genero': genero,
    'fotoPerfilUrl': fotoPerfilUrl,
    'atividades': atividades.map((a) => a.toJson()).toList(),
  };

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      nomeUsuario: json['nomeUsuario'],
      senha: json['senha'],
      nomeCompleto: json['nomeCompleto'],
      email: json['email'],
      telefone: json['telefone'],
      dataNascimento: json['dataNascimento'] != null
          ? DateTime.parse(json['dataNascimento'])
          : null,
      genero: json['genero'],
      fotoPerfilUrl: json['fotoPerfilUrl'],
      atividades: (json['atividades'] as List<dynamic>?)
              ?.map((a) => Atividade.fromJson(a))
              .toList() ??
          [],
    );
  }
}
