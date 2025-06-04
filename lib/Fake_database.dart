class User{
  String nome = '';
  String senha = '';
  String foto = '';
  List<Atividade> atividades = [];
}

class Atividade{
  String titulo = '';
  int distancia_em_km = 0;
  String tempo_min_seg = '00:00';
  String ritmo = '';

  Atividade({
    required this.titulo,
    required this.distancia_em_km,
    required this.tempo_min_seg,
    required this.ritmo,
  });
}