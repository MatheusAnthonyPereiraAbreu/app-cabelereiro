/*import 'package:flutter/material.dart';
import 'package:pomodoro/core/models/user.dart';
import 'selecao_dia.dart';
import 'package:pomodoro/core/services/auth/auth_firebase_service.dart';

class SelecionarProfissional extends StatelessWidget {
  final String servico;
  final FirebaseService firebaseService = FirebaseService();

  SelecionarProfissional({required this.servico});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Selecione um Profissional'),
      ),
      body: FutureBuilder<List<Profissional>>(
        future: firebaseService.getProfissionais(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Erro ao carregar profissionais: ${snapshot.error}');
          }

          if (snapshot.connectionState == ConnectionState.done) {
            List<Profissional> profissionais = snapshot.data!;
            profissionais = profissionais.where((profissional) => profissional.funcao == servico).toList();

            return ListView.builder(
              itemCount: profissionais.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(profissionais[index].nome),
                  onTap: () {
                    // Navegue para a próxima tela e passe o profissional selecionado
                    Navigator.push(context, MaterialPageRoute(builder: (context) => AgendarHorario(profissional: profissionais[index])));
                  },
                );
              },
            );
          }

          return CircularProgressIndicator();
        },
      ),
    );
  }
}
*/

import 'package:flutter/material.dart';
import 'package:appcabelereiro/core/models/profissional.dart';
import 'package:appcabelereiro/core/services/firebase_agendamento.dart'; 
import 'package:appcabelereiro/pages/agendamento.dart';

class ProfissionalPage extends StatefulWidget {
  final String? servico;

  ProfissionalPage({Key? key, this.servico}) : super(key: key);

  @override
  _ProfissionalPageState createState() => _ProfissionalPageState();
}

class _ProfissionalPageState extends State<ProfissionalPage> {
  late Future<List<Profissional>> profissionais;
  final FirebaseService _firebaseService = FirebaseService();

  @override
  void initState() {
    super.initState();
    profissionais = _firebaseService.getProfissionais(widget.servico);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Escolha um Profissional'),
      ),
      body: FutureBuilder<List<Profissional>>(
        future: profissionais,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(snapshot.data![index].nome),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AgendamentoPage(profissional: snapshot.data![index].nome, servico: snapshot.data![index].funcao),
                      ),
                    );
                  },
                );
              },
            );
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }
          return CircularProgressIndicator();
        },
      ),
    );
  }
}
