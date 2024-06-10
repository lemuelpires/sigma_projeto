import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/produtos_screen.dart';
import 'screens/usuarios_screen.dart';
import 'screens/anuncios_screen.dart';
import 'screens/jogos_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Exemplo de API em um Card',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomeScreen(),
      routes: {
        '/produtos': (context) => const ProdutosScreen(),
        '/usuarios': (context) => const UsuariosScreen(),
        '/anuncios': (context) => const AnunciosScreen(),
        '/jogos': (context) => const JogosScreen(),
      },
    );
  }
}

