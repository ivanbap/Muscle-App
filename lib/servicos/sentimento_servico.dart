import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../modelos/sentimento_modelo.dart';

class SentimentoServico {
  String userId;
  SentimentoServico() : userId = FirebaseAuth.instance.currentUser!.uid;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static const String key = "Dicas";

  Future<void> adicionarSentimento({
    required String idExercicio,
    required SentimentoModelo sentimentoModelo,
  }) async {
    return await _firestore
        .collection(userId)
        .doc(idExercicio)
        .collection(key)
        .doc(sentimentoModelo.id)
        .set(sentimentoModelo.toMap());
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> conectarStream(
      {required String idExercicio}) {
    return _firestore
        .collection(userId)
        .doc(idExercicio)
        .collection(key)
        .orderBy("data", descending: true)
        .snapshots();
  }

  Future<void> removerSentimento(
      {required String exercicioId, required String sentimentoId}) async {
    return _firestore
        .collection(userId)
        .doc(exercicioId)
        .collection(key)
        .doc(sentimentoId)
        .delete();
  }
}
