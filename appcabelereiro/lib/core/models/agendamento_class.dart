import 'package:cloud_firestore/cloud_firestore.dart';

class Agendamento {
  DateTime data;
  String horario;
  String nomeCliente;
  String servico;
  String cabelereiro;

  Agendamento({
    required this.data,
    required this.horario,
    required this.nomeCliente,
    required this.servico,
    required this.cabelereiro,
  });

  Map<String, dynamic> toMap() {
    return {
      'data': data,
      'horario': horario,
      'nomeCliente': nomeCliente,
      'servico': servico,
      'cabelereiro': cabelereiro,
    };
  }

  factory Agendamento.fromMap(Map<String, dynamic> map) {
    return Agendamento(
      data: (map['data'] as Timestamp).toDate(),
      horario: map['horario'],
      nomeCliente: map['nomeCliente'],
      servico: map['servico'],
      cabelereiro: map['cabelereiro'],
    );
  }

}

