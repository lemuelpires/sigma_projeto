import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ProdutosScreen extends StatefulWidget {
  const ProdutosScreen({Key? key}) : super(key: key);

  @override
  _ProdutosScreenState createState() => _ProdutosScreenState();
}

class _ProdutosScreenState extends State<ProdutosScreen> {
  final String apiUrl = 'https://localhost:7059/api/Produto';

  String imageUrl = '';
  String productName = '';
  double productPrice = 0.0;
  bool isLoading = true;
  bool hasError = false;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        print('Response body: ${response.body}');
        final List<dynamic> jsonDataList = json.decode(response.body);
        if (jsonDataList.isNotEmpty) {
          final Map<String, dynamic> jsonData = jsonDataList.first;
          print('JSON data: $jsonData');
          setState(() {
            imageUrl = jsonData['imagemProduto'] ?? '';
            productName = jsonData['nomeProduto'] ?? '';
            productPrice = (jsonData['preco'] ?? 0).toDouble();
            isLoading = false;
            hasError = false;
          });
        } else {
          setState(() {
            isLoading = false;
            hasError = true;
          });
        }
      } else {
        print('Failed to load data: ${response.statusCode}');
        throw Exception('Falha ao carregar os dados da API');
      }
    } catch (e) {
      print('Exception: $e');
      setState(() {
        isLoading = false;
        hasError = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Produtos'),
      ),
      body: Center(
        child: isLoading
            ? const CircularProgressIndicator()
            : hasError
                ? const Text('Erro ao carregar dados.')
                : Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          imageUrl.isNotEmpty
                              ? Image.network(
                                  imageUrl,
                                  width: 144.0,
                                  height: 144.0,
                                  errorBuilder: (context, error, stackTrace) {
                                    return const Text('Erro ao carregar a imagem');
                                  },
                                )
                              : const Text('Imagem não disponível'),
                          const SizedBox(height: 10.0),
                          Text(
                            productName,
                            style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 10.0),
                          Text(
                            'Preço: \$${productPrice.toStringAsFixed(2)}',
                            style: const TextStyle(fontSize: 16.0),
                          ),
                        ],
                      ),
                    ),
                  ),
      ),
    );
  }
}
