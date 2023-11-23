import 'package:flutter/material.dart';
import 'package:appcabelereiro/pages/auth_or_home_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Agendamento de Serviços',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: AuthOrAppPage(),
    );
  }
}
