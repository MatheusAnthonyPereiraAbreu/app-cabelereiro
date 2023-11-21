import 'package:flutter/material.dart';
import 'package:appcabelereiro/core/services/firebase_agendamento.dart'; 
import 'package:appcabelereiro/core/models/profissional.dart';

class CriacaoProfissionalPage extends StatefulWidget {
  @override
  _CriacaoProfissionalPageState createState() => _CriacaoProfissionalPageState();
}

class _CriacaoProfissionalPageState extends State<CriacaoProfissionalPage> {
  final _formKey = GlobalKey<FormState>();
  final FirebaseService _firebaseService = FirebaseService();
  String _nome = '';
  String _funcao = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Criação de Profissional'),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(labelText: 'Nome'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor, insira o nome';
                }
                return null;
              },
              onSaved: (value) {
                _nome = value!;
              },
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Função'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor, insira a função';
                }
                return null;
              },
              onSaved: (value) {
                _funcao = value!;
              },
            ),
            ElevatedButton(
              onPressed: _criarProfissional,
              child: Text('Criar Profissional'),
            ),
          ],
        ),
      ),
    );
  }

  void _criarProfissional() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      Profissional profissional = Profissional(nome: _nome, funcao: _funcao, diasOcupados: []);
      _firebaseService.criarProfissional(profissional);
    }
  }
}