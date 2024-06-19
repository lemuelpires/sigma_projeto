class Product {
  final int idProduto;
  final String nomeProduto;
  final String descricaoProduto;
  final double preco;
  final int quantidadeEstoque;
  final String categoria;
  final String marca;
  final String imagemProduto;
  final String fichaTecnica;
  final DateTime data;

  Product({
    required this.idProduto,
    required this.nomeProduto,
    required this.descricaoProduto,
    required this.preco,
    required this.quantidadeEstoque,
    required this.categoria,
    required this.marca,
    required this.imagemProduto,
    required this.fichaTecnica,
    required this.data,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      idProduto: json['idProduto'] as int,
      nomeProduto: json['nomeProduto'] as String,
      descricaoProduto: json['descricaoProduto'] as String,
      preco: (json['preco'] as num).toDouble(),
      quantidadeEstoque: json['quantidadeEstoque'] as int,
      categoria: json['categoria'] as String,
      marca: json['marca'] as String,
      imagemProduto: json['imagemProduto'] as String,
      fichaTecnica: json['fichaTecnica'] as String,
      data: DateTime.parse(json['data'] as String),
    );
  }
}
