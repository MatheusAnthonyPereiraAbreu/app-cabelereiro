class Profissional {
  String nome;
  String funcao;
  List<String> diasOcupados;

  Profissional({required this.nome, required this.funcao, required this.diasOcupados});

  Map<String, dynamic> toMap() {
    return {
      'nome': nome,
      'funcao': funcao,
      'diasOcupados': diasOcupados,
    };
  }

  factory Profissional.fromMap(Map<String, dynamic> map) {
    return Profissional(
      nome: map['nome'],
      funcao: map['funcao'],
      diasOcupados: List<String>.from(map['diasOcupados']),
    );
  }
}
