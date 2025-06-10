class Atividade {
  String titulo;
  String distancia_em_km;
  String tempo_min_seg;
  String ritmo;
  String descricao;

  Atividade({
    required this.titulo,
    required this.distancia_em_km,
    required this.tempo_min_seg,
    required this.ritmo,
    this.descricao = '',
  });

  Map<String, dynamic> toJson() => {
    'titulo': titulo,
    'distancia_em_km': distancia_em_km,
    'tempo_min_seg': tempo_min_seg,
    'ritmo': ritmo,
    'descricao': descricao,
  };

  factory Atividade.fromJson(Map<String, dynamic> json) {
    return Atividade(
      titulo: json['titulo'],
      distancia_em_km: json['distancia_em_km'],
      tempo_min_seg: json['tempo_min_seg'],
      ritmo: json['ritmo'],
      descricao: json['descricao'],
    );
  }
}
