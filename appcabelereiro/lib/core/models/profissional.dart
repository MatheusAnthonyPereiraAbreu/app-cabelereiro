class Profissional {
  String nome;
  String funcao;

  Profissional({required this.nome, required this.funcao});

  Map<String, dynamic> toMap() {
    return {
      'nome': nome,
      'funcao': funcao,
    };
  }

  factory Profissional.fromMap(Map<String, dynamic> map) {
    return Profissional(
      nome: map['nome'],
      funcao: map['funcao'],
    );
  }
}
