import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class User {
  final int idUsuario;
  final String email;
  final String nome;
  final String genero;
  final String dataNascimento;
  final String telefone;
  final String cpf;

  User({
    required this.idUsuario,
    required this.email,
    required this.nome,
    required this.genero,
    required this.dataNascimento,
    required this.telefone,
    required this.cpf,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      idUsuario: json['idUsuario'],
      email: json['email'],
      nome: json['nome'],
      genero: json['genero'],
      dataNascimento: json['dataNascimento'],
      telefone: json['telefone'],
      cpf: json['cpf'],
    );
  }
}

class UsuariosScreen extends StatefulWidget {
  const UsuariosScreen({super.key});

  @override
  _UsuariosScreenState createState() => _UsuariosScreenState();
}

class _UsuariosScreenState extends State<UsuariosScreen> {
  final String apiUrl = 'https://localhost:7059/api/Usuario';

  List<User> users = [];
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
        final List<User> loadedUsers = [];
        for (final user in jsonDataList) {
          loadedUsers.add(User.fromJson(user));
        }
        setState(() {
          users = loadedUsers;
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
        title: const Text('Usuários'),
      ),
      body: Center(
        child: isLoading
            ? const CircularProgressIndicator()
            : hasError
                ? const Text('Error loading data.')
                : ListView.builder(
                    itemCount: users.length,
                    itemBuilder: (context, index) {
                      final user = users[index];
                      return Card(
                        child: ListTile(
                          leading: CircleAvatar(
                            child: Text(user.idUsuario.toString()),
                          ),
                          title: Text(user.nome),
                          subtitle: Text(user.email),
                          onTap: () {
                            // Implementar ação ao tocar no usuário
                          },
                        ),
                      );
                    },
                  ),
      ),
    );
  }
}
