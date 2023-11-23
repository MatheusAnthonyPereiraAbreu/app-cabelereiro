import 'package:cloud_firestore/cloud_firestore.dart';

class Agendamento {
  String data;
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
    dynamic timestamp = map['data']; // Obtenha o valor de 'data'

    // Verifique se 'data' é do tipo Timestamp ou String
    String formattedDate = timestamp is Timestamp
        ? timestamp
            .toDate()
            .toIso8601String()
            .split('T')[0] // Se for Timestamp, converta para String
        : timestamp as String; // Se for String, use diretamente

    return Agendamento(
      data: formattedDate,
      horario: map['horario'] as String,
      nomeCliente: map['nomeCliente'] as String,
      servico: map['servico'] as String,
      cabelereiro: map['cabelereiro'] as String,
    );
  }
}
