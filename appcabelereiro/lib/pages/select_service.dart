import 'package:flutter/material.dart';
import 'package:appcabelereiro/pages/select_profissional.dart';
import 'package:appcabelereiro/components/appbar.dart';

class ServicoPage extends StatefulWidget {
  @override
  _ServicoPageState createState() => _ServicoPageState();
}
class _ServicoPageState extends State<ServicoPage> {
  final List<String> servicos = ['Corte de cabelo', 'Barba', 'Limpeza', 'Progressiva', 'Pintura', 'Completo'];
  String? _servicoSelecionado;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Escolha seu serviço',
                style: Theme.of(context).textTheme.headline6!.copyWith(color: Colors.black),
                textAlign: TextAlign.center,
              ),
            ),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: servicos.map((servico) {
                return SizedBox(
                  width: 150,
                  height: 150,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: _servicoSelecionado == servico ? Colors.grey : Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        _servicoSelecionado = servico;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(_getIconForService(servico), size: 30, color: Colors.white),
                        Text(servico, style: TextStyle(color: Colors.white)),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
            if (_servicoSelecionado != null)
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.black,
                    onPrimary: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProfissionalPage(servico: _servicoSelecionado),
                      ),
                    );
                  },
                  child: Text('Avançar'),
                ),
              ),
          ],
        ),
      ),
    );
  }

  IconData _getIconForService(String servico) {
    switch (servico) {
      case 'Corte de cabelo':
        return Icons.content_cut;
      case 'Barba':
        return Icons.face;
      case 'Limpeza':
        return Icons.cleaning_services;
      case 'Progressiva':
        return Icons.style;
      case 'Pintura':
        return Icons.color_lens;
      case 'Completo':
        return Icons.check_circle_outline;
      default:
        return Icons.help_outline;
    }
  }
}

