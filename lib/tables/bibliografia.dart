import 'package:flutter/material.dart';

class BibliografiaPage extends StatelessWidget {
  const BibliografiaPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Bibliografía'),
        backgroundColor: const Color(0xffe8a96c),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const <Widget>[
            Text(
              'Aquí se encuentran los enlaces a las fuentes utilizadas en este proyecto:',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                height: 1.5,
              ),
            ),
            SizedBox(height: 20),
            // Enlaces visibles
            Text(
                'https://github.com/geekyshow1/flutter_fbfirestore_crud/tree/master'),
            Text('https://youtu.be/bnZUyHNaxfU'),
            Text('https://github.com/codigoalphacol/Flutter-Login-Firebase'),
            Text('https://youtu.be/sHqrawmQq2w'),
            Text(
                'https://github.com/TarekAlabd/Authentication-With-Amazing-UI-Flutter'),
            Text('https://api.flutter.dev/flutter/material/AppBar-class.html'),
            Text('https://api.flutter.dev/flutter/material/TabBar-class.html'),
            Text('https://docs.flutter.dev/cookbook/design/drawer'),
            Text('https://pub.dev/packages/flutter_login'),
          ],
        ),
      ),
    );
  }
}
