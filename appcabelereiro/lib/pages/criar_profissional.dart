import 'dart:io';

import 'package:flutter/material.dart';
import 'package:appcabelereiro/core/services/firebase_agendamento.dart'; 
import 'package:appcabelereiro/core/models/profissional.dart';
import 'package:image_picker/image_picker.dart';

class CriacaoProfissionalPage extends StatefulWidget {
  @override
  _CriacaoProfissionalPageState createState() => _CriacaoProfissionalPageState();
}

class _CriacaoProfissionalPageState extends State<CriacaoProfissionalPage> {
  final _formKey = GlobalKey<FormState>();
  final FirebaseService _firebaseService = FirebaseService();
  String _nome = '';
  String _funcao = '';
  File? _imageFile;

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
              onPressed: _selecionarImagem,
              child: Text('Selecionar Imagem'),
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

  void _selecionarImagem() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _imageFile = File(pickedFile.path);
      } else {
        print('Nenhuma imagem selecionada.');
      }
    });
  }

  void _criarProfissional() {
    if (_formKey.currentState!.validate() && _imageFile != null) {
      _formKey.currentState!.save();
      Profissional profissional = Profissional(nome: _nome, funcao: _funcao, diasOcupados: [], imageUrl: '');
      _firebaseService.criarProfissional(profissional, _imageFile!);
    }
  }
}
