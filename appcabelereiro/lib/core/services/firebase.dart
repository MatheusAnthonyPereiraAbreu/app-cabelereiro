import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:appcabelereiro/core/models/profissional.dart';
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


  Future<void> criarProfissional(Profissional profissional) {
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

}
