import 'package:flutter/material.dart';
import 'package:sigma_projeto/services/api_services.dart';
import 'package:sigma_projeto/models/product.dart';

class ProdutosScreen extends StatefulWidget {
  const ProdutosScreen({super.key});

  @override
  _ProdutosScreenState createState() => _ProdutosScreenState();
}

class _ProdutosScreenState extends State<ProdutosScreen> {
  final String apiUrl = 'https://localhost:7059/api/Produto'; // URL da sua API
  late ApiService apiService; // Instância da classe ApiService
  late Future<List<Product>> productsFuture; // Future que armazenará os produtos

  @override
  void initState() {
    super.initState();
    apiService = ApiService(apiUrl); // Inicializa o ApiService com a URL da API
    productsFuture = apiService.fetchProducts(); // Inicia a chamada para buscar os produtos
  }

  void showProductDetails(Product product) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(product.nomeProduto),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              product.imagemProduto.isNotEmpty
                  ? Image.network(
                      product.imagemProduto,
                      width: 144.0,
                      height: 144.0,
                      errorBuilder: (context, error, stackTrace) {
                        return const Text('Erro ao carregar a imagem');
                      },
                    )
                  : const Text('Imagem não disponível'),
              const SizedBox(height: 10.0),
              Text('Descrição: ${product.descricaoProduto}'),
              const SizedBox(height: 10.0),
              Text('Preço: \$${product.preco.toStringAsFixed(2)}'),
              const SizedBox(height: 10.0),
              Text('Estoque: ${product.quantidadeEstoque}'),
              const SizedBox(height: 10.0),
              Text('Categoria: ${product.categoria}'),
              const SizedBox(height: 10.0),
              Text('Marca: ${product.marca}'),
              const SizedBox(height: 10.0),
              Text('Ficha Técnica: ${product.fichaTecnica}'),
              const SizedBox(height: 10.0),
              Text('Data: ${product.data.toLocal().toString().split(' ')[0]}'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Fechar'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Produtos'),
      ),
      body: Center(
        child: FutureBuilder<List<Product>>(
          future: productsFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Erro ao carregar dados: ${snapshot.error}');
            } else if (snapshot.hasData) {
              final products = snapshot.data!;

              return ListView.builder(
                itemCount: products.length,
                itemBuilder: (context, index) {
                  final product = products[index];

                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero, // Define as bordas como retangulares
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          product.imagemProduto.isNotEmpty
                              ? Image.network(
                                  product.imagemProduto,
                                  width: 144.0,
                                  height: 144.0,
                                  errorBuilder: (context, error, stackTrace) {
                                    return const Text('Erro ao carregar a imagem');
                                  },
                                )
                              : const Text('Imagem não disponível'),
                          const SizedBox(height: 10.0),
                          Text(
                            product.nomeProduto,
                            style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 10.0),
                          Text(
                            'Preço: \$${product.preco.toStringAsFixed(2)}',
                            style: const TextStyle(fontSize: 16.0),
                          ),
                          const SizedBox(height: 10.0),
                          Text(
                            'Estoque: ${product.quantidadeEstoque}',
                            style: const TextStyle(fontSize: 16.0),
                          ),
                          const SizedBox(height: 10.0),
                          ElevatedButton(
                            onPressed: () {
                              showProductDetails(product);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                            ),
                            child: const Text('Detalhes'),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            } else {
              return const Text('Nenhum dado disponível');
            }
          },
        ),
      ),
    );
  }
}
