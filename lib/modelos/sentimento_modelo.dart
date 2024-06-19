class SentimentoModelo {
  String id;
  String sentindo;
  String data;

  SentimentoModelo({
    required this.id,
    required this.sentindo,
    required this.data,
  });

  SentimentoModelo.fromMap(Map<String, dynamic> map) //sentind
      : id = map["id"],
        sentindo = map["sentindo"],
        data = map["data"];

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "sentindo": sentindo,
      "data": data,
    };
  }
}
