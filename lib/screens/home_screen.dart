import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  final String apiUrl = 'https://localhost:7059/api/Produto';

  String imageUrl = '';
  String productName = '';
  double productPrice = 0.0;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
  final response = await http.get(Uri.parse(apiUrl));
  if (response.statusCode == 200) {
    final List<dynamic> jsonDataList = json.decode(response.body);
    final Map<String, dynamic> jsonData = jsonDataList.isNotEmpty ? jsonDataList.first : {};
    setState(() {
      imageUrl = jsonData['referenciaImagem'] ?? '';
      productName = jsonData['titulo'] ?? '';
      productPrice = (jsonData['preco'] ?? 0).toDouble();
    });
  } else {
    throw Exception('Falha ao carregar os dados da API');
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Produtos'),
      ),
      body: Center(
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Image.network(imageUrl),
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