class User{
  String nome = '';
  String senha = '';
  String foto = '';
  List<Atividade> atividades = [];

  User({required this.nome, required this.senha});

  Map<String, dynamic> toJson() => {
    'nome': nome,
    'senha': senha,
  };

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      nome: json['nome'],
      senha: json['senha'],
    );
  }
}

class Atividade{
  String titulo = '';
  String distancia_em_km = '';
  String tempo_min_seg = '00:00';
  String ritmo = '';

  Atividade({
    required this.titulo,
    required this.distancia_em_km,
    required this.tempo_min_seg,
    required this.ritmo,
  });
}