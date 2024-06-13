import 'package:flutter/material.dart';
import 'package:arias0315/main.dart';

class PerfilPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(
                  "https://raw.githubusercontent.com/AriasSuarezDemianAlexander/imggg/main/Cliente2.jpg",
                ),
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: Text(
                'Demian Alexander Arias',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff8D6E63),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Center(
              child: Text(
                'usuario@carpinteria.com',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black54,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Divider(color: Colors.black54),
            ListTile(
              leading: Icon(Icons.edit, color: Color(0xff8D6E63)),
              title: Text('Editar Perfil'),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.list, color: Color(0xff8D6E63)),
              title: Text('Ver Pedidos'),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.logout, color: Color(0xff8D6E63)),
              title: Text('Cerrar Sesión'),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => PaginaSesion()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
