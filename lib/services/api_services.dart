import 'package:http/http.dart' as http;
import 'package:sigma_projeto/models/product.dart';
import 'dart:convert';

class ApiService {
  final String baseUrl;

  ApiService(this.baseUrl);

  Future<List<Product>> fetchProducts() async {
    try {
      final response = await http.get(Uri.parse(baseUrl));
      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(response.body);
        return jsonData.map((item) => Product.fromJson(item)).toList();
      } else {
        throw Exception('Falha ao carregar os dados da API');
      }
    } catch (e) {
      print('Exception: $e');
      rethrow;
    }
  }
}
