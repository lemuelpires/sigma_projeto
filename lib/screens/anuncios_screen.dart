// anuncios_screen.dart

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/anuncio.dart';

class AnunciosScreen extends StatefulWidget {
  const AnunciosScreen({Key? key}) : super(key: key);

  @override
  _AnunciosScreenState createState() => _AnunciosScreenState();
}

class _AnunciosScreenState extends State<AnunciosScreen> {
  final String apiUrl = 'https://localhost:7059/api/Anuncio';

  List<Anuncio> anuncios = [];
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
        final List<Anuncio> loadedAnuncios = [];
        for (final anuncio in jsonDataList) {
          loadedAnuncios.add(Anuncio.fromJson(anuncio));
        }
        setState(() {
          anuncios = loadedAnuncios;
          isLoading = false;
          hasError = false;
        });
      } else {
        print('Failed to load data: ${response.statusCode}');
        throw Exception('Failed to load data from API');
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
        title: const Text('Anúncios'),
      ),
      body: Center(
        child: isLoading
            ? const CircularProgressIndicator()
            : hasError
                ? const Text('Erro ao carregar dados.')
                : ListView.builder(
                    itemCount: anuncios.length,
                    itemBuilder: (context, index) {
                      final anuncio = anuncios[index];
                      return Card(
                        child: ListTile(
                          leading: anuncio.referenciaImagem.isNotEmpty
                              ? Image.network(
                                  anuncio.referenciaImagem,
                                  width: 50,
                                  height: 50,
                                  errorBuilder: (context, error, stackTrace) {
                                    return const Icon(Icons.broken_image);
                                  },
                                )
                              : const Icon(Icons.image_not_supported),
                          title: Text(anuncio.titulo),
                          subtitle: Text(
                            'Preço: R\$${anuncio.preco.toStringAsFixed(2)}\n${anuncio.descricao}',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          onTap: () {
                            // Implementar ação ao tocar no anúncio
                          },
                        ),
                      );
                    },
                  ),
      ),
    );
  }
}
