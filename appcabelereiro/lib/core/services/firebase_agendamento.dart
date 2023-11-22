import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:appcabelereiro/core/models/profissional.dart';
import 'package:appcabelereiro/core/models/agendamento_class.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:intl/intl.dart';

class FirebaseService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<List<Profissional>> getProfissionais(String? servico) async {
    QuerySnapshot snapshot = await _db.collection('profissionais')
      .where('funcao', isEqualTo: servico)
      .get();

    return snapshot.docs.map((doc) => Profissional.fromMap(doc.data() as Map<String, dynamic>)).toList();
  }

  Future<List<String>> getHorariosOcupados(String profissional, DateTime data) async {
    DocumentSnapshot snapshot = await _db.collection('profissionais')
      .doc(profissional)
      .collection('agendamentos')
      .doc(DateFormat('yyyy-MM-dd').format(data))
      .get();

    if (snapshot.exists) {
      Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
      return List<String>.from(data['horariosOcupados'] ?? []);
    } else {
      return [];
    }
  }


  Future<void> criarProfissional(Profissional profissional, File imageFile) async {
  // Fazer o upload da imagem para o Firebase Storage
  String fileName = '${DateTime.now().millisecondsSinceEpoch}_${profissional.nome}';
  Reference ref = FirebaseStorage.instance.ref().child('profissionais').child(fileName);
  UploadTask uploadTask = ref.putFile(imageFile);
  TaskSnapshot taskSnapshot = await uploadTask;

  // Obter a URL da imagem
  String imageUrl = await taskSnapshot.ref.getDownloadURL();

  // Salvar a URL da imagem no Firestore
  profissional.imageUrl = imageUrl;
  return _db.collection('profissionais').doc(profissional.nome).set(profissional.toMap());
}


  Future<void> agendarHorario(String profissional, DateTime data, String horario) {
    return _db.collection('profissionais')
      .doc(profissional)
      .collection('agendamentos')
      .doc(DateFormat('yyyy-MM-dd').format(data))
      .set({
        'horariosOcupados': FieldValue.arrayUnion([horario])
      }, SetOptions(merge: true));
  }

  Future<void> criarAgendamento(Agendamento agendamento) {
    return _db.collection('agendamentos')
      .doc('${agendamento.data.toIso8601String()}_${agendamento.horario}')
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
      .doc('${agendamento.data.toIso8601String()}_${agendamento.horario}')
      .delete();
  }

}
