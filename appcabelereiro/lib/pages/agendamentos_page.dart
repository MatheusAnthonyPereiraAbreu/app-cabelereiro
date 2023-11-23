// agendamentos_page.dart
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:appcabelereiro/core/models/agendamento_class.dart'; // Importe a classe Agendamento

class AgendamentosPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Agendamentos'),
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/fundo_um.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            color: Colors.black.withOpacity(0.6),
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('agendamentos')
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  return Center(
                      child: Text('Erro ao carregar os agendamentos'));
                }

                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return Center(child: Text('Nenhum agendamento encontrado'));
                }

                final agendamentos = snapshot.data!.docs
                    .map((doc) =>
                        Agendamento.fromMap(doc.data() as Map<String, dynamic>))
                    .toList();
                final List<String> profissionais = agendamentos
                    .map((agendamento) => agendamento.cabelereiro)
                    .toSet()
                    .toList();

                return ListView(
                  children: profissionais.map((profissional) {
                    final agendamentosDoProfissional = agendamentos
                        .where((agendamento) =>
                            agendamento.cabelereiro == profissional)
                        .toList();

                    return Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Profissional: $profissional',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: 8.0),
                          Container(
                            color: Colors.transparent,
                            child: GridView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 8.0,
                                mainAxisSpacing: 8.0,
                                childAspectRatio: 0.75,
                              ),
                              itemCount: agendamentosDoProfissional.length,
                              itemBuilder: (BuildContext context, int index) {
                                final agendamento =
                                    agendamentosDoProfissional[index];

                                return Card(
                                  color: Colors.white.withOpacity(0.85),
                                  elevation: 2,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Cliente: ${agendamento.nomeCliente}',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(height: 4.0),
                                        Text('Serviço: ${agendamento.servico}'),
                                        SizedBox(height: 4.0),
                                        Text('Data: ${agendamento.data}'),
                                        Text('Horário: ${agendamento.horario}'),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
