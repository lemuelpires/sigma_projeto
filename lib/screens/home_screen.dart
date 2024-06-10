import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Icon(Icons.home),
            SizedBox(width: 8),
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 8),
                ),
              ),
            ),
            SizedBox(width: 8),
            Builder(
              builder: (context) {
                return IconButton(
                  icon: Icon(Icons.menu),
                  onPressed: () {
                    Scaffold.of(context).openEndDrawer();
                  },
                );
              },
            ),
          ],
        ),
      ),
      endDrawer: Drawer(
        child: ListView(
          children: <Widget>[
            DrawerHeader(
              child: Text('Menu'),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
            ListTile(
              leading: Icon(Icons.shopping_cart),
              title: Text('Produtos'),
              onTap: () {
                Navigator.pushNamed(context, '/produtos');
              },
            ),
            ListTile(
              leading: Icon(Icons.announcement),
              title: Text('Anuncios'),
              onTap: () {
                Navigator.pushNamed(context, '/anuncios');
              },
            ),
            ListTile(
              leading: Icon(Icons.people),
              title: Text('Usuários'),
              onTap: () {
                Navigator.pushNamed(context, '/usuarios');
              },
            ),
            ListTile(
              leading: Icon(Icons.gamepad),
              title: Text('Jogos'),
              onTap: () {
                Navigator.pushNamed(context, '/jogos');
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: Text('Conteúdo da Página Inicial'),
      ),
    );
  }
}

