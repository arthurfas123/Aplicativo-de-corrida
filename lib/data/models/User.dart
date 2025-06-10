import 'Atividade.dart';

class User {
  String nome;
  String senha;
  List<Atividade> atividades;

  User({
    required this.nome,
    required this.senha,
    this.atividades = const [],
  });

  Map<String, dynamic> toJson() => {
    'nome': nome,
    'senha': senha,
    'atividades': atividades.map((a) => a.toJson()).toList(),
  };

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      nome: json['nome'],
      senha: json['senha'],
      atividades: (json['atividades'] as List<dynamic>?)
          ?.map((a) => Atividade.fromJson(a))
          .toList() ??
          [],
    );
  }
}