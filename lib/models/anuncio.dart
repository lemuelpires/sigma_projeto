// models/anuncio.dart

class Anuncio {
  final int idAnuncio;
  final int idProduto;
  final String titulo;
  final String descricao;
  final double preco;
  final String referenciaImagem;

  Anuncio({
    required this.idAnuncio,
    required this.idProduto,
    required this.titulo,
    required this.descricao,
    required this.preco,
    required this.referenciaImagem,
  });

  factory Anuncio.fromJson(Map<String, dynamic> json) {
    return Anuncio(
      idAnuncio: json['idAnuncio'],
      idProduto: json['idProduto'],
      titulo: json['titulo'],
      descricao: json['descricao'],
      preco: json['preco'].toDouble(),
      referenciaImagem: json['referenciaImagem'],
    );
  }
}
