/*import 'package:flutter/material.dart';
import 'package:pomodoro/core/services/auth/auth_firebase_service.dart';
//import 'package:flutter/material.dart';
import 'package:pomodoro/core/models/user.dart';

class AdicionarProfissional extends StatefulWidget {
  @override
  _AdicionarProfissionalState createState() => _AdicionarProfissionalState();
  
}

class _AdicionarProfissionalState extends State<AdicionarProfissional> {
  final FirebaseService firebaseService = FirebaseService();
  final _formKey = GlobalKey<FormState>();
  final nomeController = TextEditingController();
  final funcaoController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Adicionar Profissional'),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: nomeController,
                decoration: InputDecoration(labelText: 'Nome'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o nome';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: funcaoController,
                decoration: InputDecoration(labelText: 'Função'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira a função';
                  }
                  return null;
                },
              ),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    Profissional profissional = Profissional(nome: nomeController.text, funcao: funcaoController.text);
                    firebaseService.adicionarProfissional(profissional);
                    Navigator.pop(context);
                  }
                },
                child: Text('Adicionar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
*/

import 'package:flutter/material.dart';
import 'package:appcabelereiro/core/services/firebase.dart'; 
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