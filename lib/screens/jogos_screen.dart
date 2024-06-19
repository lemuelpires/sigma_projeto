import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/jogo.dart';

class JogosScreen extends StatefulWidget {
  const JogosScreen({super.key});

  @override
  _JogosScreenState createState() => _JogosScreenState();
}

class _JogosScreenState extends State<JogosScreen> {
  final String apiUrl = 'https://localhost:7059/api/Jogo';

  List<Jogo> jogos = [];
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
        final List<Jogo> loadedJogos = [];
        for (final jogo in jsonDataList) {
          loadedJogos.add(Jogo.fromJson(jogo));
        }
        setState(() {
          jogos = loadedJogos;
          isLoading = false;
          hasError = false;
        });
      } else {
        print('Failed to load data: ${response.statusCode}');
        setState(() {
          isLoading = false;
          hasError = true;
        });
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
        title: const Text('Jogos'),
      ),
      body: Center(
        child: isLoading
            ? const CircularProgressIndicator()
            : hasError
                ? const Text('Erro ao carregar dados.')
                : ListView.builder(
                    itemCount: jogos.length,
                    itemBuilder: (context, index) {
                      final jogo = jogos[index];
                      return Card(
                        child: ListTile(
                          leading: jogo.referenciaImagemJogo.isNotEmpty
                              ? Image.network(
                                  jogo.referenciaImagemJogo,
                                  width: 50,
                                  height: 50,
                                  errorBuilder: (context, error, stackTrace) {
                                    return const Icon(Icons.broken_image);
                                  },
                                )
                              : const Icon(Icons.image_not_supported),
                          title: Text(jogo.nomeJogo),
                          subtitle: Text(
                            'Categoria: ${jogo.categoriaJogo}\nProcessador: ${jogo.processadorRequerido}\nRAM: ${jogo.memoriaRAMRequerida}\nPlaca de Vídeo: ${jogo.placaVideoRequerida}\nEspaço: ${jogo.espacoDiscoRequerido}',
                            maxLines: 5,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      );
                    },
                  ),
      ),
    );
  }
}
