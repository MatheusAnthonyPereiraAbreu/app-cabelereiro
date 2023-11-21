/*import 'package:flutter/material.dart';
import 'package:pomodoro/pages/selecao_profissional.dart';

class SelecionarServico extends StatelessWidget {
  final List<String> servicos = ['Corte de cabelo', 'Barba', 'Manicure', 'Pedicure'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Selecione um Serviço'),
      ),
      body: ListView.builder(
        itemCount: servicos.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(servicos[index]),
            onTap: () {
              // Navegue para a próxima tela e passe o serviço selecionado
              Navigator.push(context, MaterialPageRoute(builder: (context) => SelecionarProfissional(servico: servicos[index])));
            },
          );
        },
      ),
    );
  }
}
*/

import 'package:flutter/material.dart';
import 'package:appcabelereiro/pages/select_profissional.dart';

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
      appBar: AppBar(
        title: Text('Selecione um Serviço'),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            DropdownButtonFormField(
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
            ElevatedButton(
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
