import 'package:flutter/material.dart';
import 'package:appcabelereiro/core/models/profissional.dart';
import 'package:appcabelereiro/core/services/firebase_agendamento.dart'; 
import 'package:appcabelereiro/pages/agendamento.dart';
import 'package:appcabelereiro/components/appbar.dart';


class ProfissionalPage extends StatefulWidget {
  final String? servico;

  ProfissionalPage({Key? key, this.servico}) : super(key: key);

  @override
  _ProfissionalPageState createState() => _ProfissionalPageState();
}

class _ProfissionalPageState extends State<ProfissionalPage> {
late Future<List<Profissional>> profissionais;
final FirebaseService _firebaseService = FirebaseService();
String? _profissionalSelecionado;

@override
void initState() {
  super.initState();
  profissionais = _firebaseService.getProfissionais(widget.servico);
}

@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: CustomAppBar(),
    body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Icon(_getIconForService(widget.servico!), size: 200),
              Text(
                widget.servico!,
                style: Theme.of(context).textTheme.headline4,
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: FutureBuilder<List<Profissional>>(
              future: profissionais,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return DropdownButton<String>(
                    value: _profissionalSelecionado,
                    hint: Text('Selecionar profissional'),
                    items: snapshot.data!.map((Profissional profissional) {
                      return DropdownMenuItem<String>(
                        value: profissional.nome,
                        child: Text(profissional.nome),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        _profissionalSelecionado = newValue;
                      });
                    },
                  );
                } else if (snapshot.hasError) {
                  return Text("${snapshot.error}");
                }
                return CircularProgressIndicator();
              },
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          onPressed: () {
                     if (_profissionalSelecionado != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AgendamentoPage(
            profissional: _profissionalSelecionado!,
            servico: widget.servico!,
          ),
        ),
      );
    } else {
      print('Nenhum profissional selecionado');
    }
  },
  child: Text('Avançar'),
          style: ElevatedButton.styleFrom(
                    primary: Colors.black,
                    onPrimary: Colors.white,
                  ),
        ),
        ),
      ],
    ),
  );
}

IconData _getIconForService(String? servico) {
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
