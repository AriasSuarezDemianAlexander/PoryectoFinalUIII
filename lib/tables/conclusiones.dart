import 'package:flutter/material.dart';

class ConclusionesPage extends StatelessWidget {
  const ConclusionesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Conclusiones'),
        backgroundColor: const Color(0xffe8a96c),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const <Widget>[
            Text(
              'En este proyecto reuni todo lo que aprendi este semestre como, la conexion de rutas, hacer un appbar, tmb un tabbar y bastantes cosas, mientras diseños como los botones y colores.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
