
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:appcabelereiro/pages/select_service.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
      home: ServicoPage(),
    );
  }
}
