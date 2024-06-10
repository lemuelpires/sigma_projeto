class Jogo {
  final int idJogo;
  final String nomeJogo;
  final String categoriaJogo;
  final String processadorRequerido;
  final String memoriaRAMRequerida;
  final String placaVideoRequerida;
  final String espacoDiscoRequerido;
  final String referenciaImagemJogo;

  Jogo({
    required this.idJogo,
    required this.nomeJogo,
    required this.categoriaJogo,
    required this.processadorRequerido,
    required this.memoriaRAMRequerida,
    required this.placaVideoRequerida,
    required this.espacoDiscoRequerido,
    required this.referenciaImagemJogo,
  });

  factory Jogo.fromJson(Map<String, dynamic> json) {
    return Jogo(
      idJogo: json['idJogo'] ?? 0,
      nomeJogo: json['nomeJogo'] ?? '',
      categoriaJogo: json['categoriaJogo'] ?? '',
      processadorRequerido: json['processadorRequerido'] ?? '',
      memoriaRAMRequerida: json['memoriaRAMRequerida'] ?? '',
      placaVideoRequerida: json['placaVideoRequerida'] ?? '',
      espacoDiscoRequerido: json['espacoDiscoRequerido'] ?? '',
      referenciaImagemJogo: json['referenciaImagemJogo'] ?? '',
    );
  }
}
