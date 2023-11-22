import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:appcabelereiro/core/models/profissional.dart';
import 'package:appcabelereiro/core/models/agendamento_class.dart';

class FirebaseService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<List<Profissional>> getProfissionais(String? servico) async {
    QuerySnapshot snapshot = await _db.collection('profissionais')
      .where('funcao', isEqualTo: servico)
      .get();

    return snapshot.docs.map((doc) => Profissional.fromMap(doc.data() as Map<String, dynamic>)).toList();
  }

 Future<List<String>> getHorariosOcupados(String profissional, String data) async {
  QuerySnapshot snapshot = await _db.collection('agendamentos')
    .where('cabelereiro', isEqualTo: profissional)
    .where('data', isEqualTo: data)
    .get();

  return snapshot.docs.map((doc) => doc['horario'] as String).toList();
}

  Future<void> criarProfissional(Profissional profissional) {
    return _db.collection('profissionais').doc(profissional.nome).set(profissional.toMap());
  }

Future<void> criarAgendamento(Agendamento agendamento) {
  return _db.collection('agendamentos')
    .doc() // Usa a data como string aqui
    .set(agendamento.toMap());
}


   Future<List<Agendamento>> getAgendamentosDoCliente(String? clienteId) async {
    QuerySnapshot snapshot = await _db.collection('agendamentos')
      .where('nomeCliente', isEqualTo: clienteId)
      .get();

    return snapshot.docs.map((doc) => Agendamento.fromMap(doc.data() as Map<String, dynamic>)).toList();
  }

  Future<void> cancelarAgendamento(Agendamento agendamento) {
    return _db.collection('agendamentos')
      .doc('${agendamento.data}_${agendamento.horario}') // Usa a data como string aqui
      .delete();
  }

}
