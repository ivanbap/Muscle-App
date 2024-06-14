class ExercicioModelo {
  String id;
  String nome;
  String treino;
  String comoFazer;
  String peso;
  String repeticoes;

  String? urlImagem;

  ExercicioModelo({
    required this.id,
    required this.nome,
    required this.treino,
    required this.comoFazer,
    required this.peso,
    required this.repeticoes,
  });

  ExercicioModelo.fromMap(Map<String, dynamic> map)
      : id = map["id"],
        nome = map["nome"],
        treino = map["treino"],
        comoFazer = map["comoFazer"],
        peso = map["peso"],
        repeticoes = map["repeticoes"];

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "nome": nome,
      "treino": treino,
      "comoFazer": comoFazer,
      "peso": peso,
      "repeticoes": repeticoes,
    };
  }
}
