import 'package:http/http.dart' as http;
import 'dart:convert';

class Product {
  final String imageUrl;
  final String name;
  final double price;

  Product({
    required this.imageUrl,
    required this.name,
    required this.price,
  });
}

class ApiService {
  final String baseUrl;

  ApiService(this.baseUrl);

  Future<Product> fetchProduct() async {
    final response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      return Product(
        imageUrl: jsonData['imagemProduto'],
        name: jsonData['nomeProduto'],
        price: double.parse(jsonData['preco'].toString()),
      );
    } else {
      throw Exception('Falha ao carregar os dados da API');
    }
  }
}
