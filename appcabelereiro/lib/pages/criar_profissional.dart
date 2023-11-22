import 'package:flutter/material.dart';
import 'package:appcabelereiro/core/services/firebase_agendamento.dart'; 
import 'package:appcabelereiro/core/models/profissional.dart';
import 'package:appcabelereiro/components/appbar.dart';

class CriacaoProfissionalPage extends StatefulWidget {
  @override
  _CriacaoProfissionalPageState createState() => _CriacaoProfissionalPageState();
}

class _CriacaoProfissionalPageState extends State<CriacaoProfissionalPage> {
  final _formKey = GlobalKey<FormState>();
  final FirebaseService _firebaseService = FirebaseService();
  final List<String> servicos = ['Corte de cabelo', 'Barba', 'Limpeza', 'Progressiva', 'Pintura', 'Completo'];
  String _nome = '';
  String _funcao = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
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
                DropdownButtonFormField(
                  decoration: InputDecoration(labelText: 'Função'),
                  items: servicos.map((servico) {
                    return DropdownMenuItem(
                      value: servico,
                      child: Text(servico),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _funcao = value as String;
                    });
                  },
                  validator: (value) {
                    if (value == null) {
                      return 'Por favor, selecione uma função';
                    }
                    return null;
                  },
                ),
                ElevatedButton(
                  onPressed: _criarProfissional,
                  style: ElevatedButton.styleFrom(
                    primary: Colors.black,
                    onPrimary: Colors.white,
                  ),
                  child: Text('Criar Profissional'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _criarProfissional() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      Profissional profissional = Profissional(nome: _nome, funcao: _funcao, diasOcupados: []);
      _firebaseService.criarProfissional(profissional);
       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Profissional criado com sucesso!')));
    }
  }
}