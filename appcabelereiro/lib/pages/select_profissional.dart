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

  @override
  void initState() {
    super.initState();
    profissionais = _firebaseService.getProfissionais(widget.servico);
  }

  @override
  Widget build(BuildContext context) {
    Theme(
  data: Theme.of(context).copyWith(
    primaryColor: Colors.deepPurple,
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
      ),
    ),
  ),
  child: TextFormField(
    decoration: InputDecoration(
      labelText: 'Nome',
    ),
  ),
);

    return Scaffold(
      appBar: CustomAppBar(),
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
