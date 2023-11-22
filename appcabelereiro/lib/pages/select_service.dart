import 'package:flutter/material.dart';
import 'package:appcabelereiro/pages/select_profissional.dart';
import 'package:appcabelereiro/components/appbar.dart';

class ServicoPage extends StatefulWidget {
  @override
  _ServicoPageState createState() => _ServicoPageState();
}

class _ServicoPageState extends State<ServicoPage> {
  final _formKey = GlobalKey<FormState>();
  final List<String> servicos = ['Corte de cabelo', 'Barba', 'Limpeza', 'Progressiva', 'Pintura'];
  String? _servicoSelecionado;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            Theme(
              data: Theme.of(context).copyWith(
                primaryColor: Colors.black,
                inputDecorationTheme: InputDecorationTheme(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
              child: DropdownButtonFormField(
                value: _servicoSelecionado,
                items: servicos.map((servico) {
                  return DropdownMenuItem(
                    value: servico,
                    child: Text(servico),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _servicoSelecionado = value as String?;
                  });
                },
                validator: (value) {
                  if (value == null) {
                    return 'Por favor, selecione um serviço';
                  }
                  return null;
                },
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.black, // Cor de fundo do botão
                onPrimary: Colors.white, // Cor do texto
              ),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProfissionalPage(servico: _servicoSelecionado),
                    ),
                  );
                }
              },
              child: Text('Enviar'),
            ),
          ],
        ),
      ),
    );
  }
}
