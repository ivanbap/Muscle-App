import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:teste/modelos/exercicio_modelo.dart';
import 'package:teste/modelos/sentimento_modelo.dart';

class ExercicioServico {
  String userId;
  ExercicioServico() : userId = FirebaseAuth.instance.currentUser!.uid;

  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> adicionarExercicio(ExercicioModelo exercicioModelo) async {
    await _firestore
        .collection(userId)
        .doc(exercicioModelo.id)
        .set(exercicioModelo.toMap());
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> conectarStreamExercicios(
      bool isDecrescente) {
    return _firestore
        .collection(userId)
        .orderBy("treino", descending: isDecrescente)
        .snapshots();
  }

  Future<void> removerExercicio({required String idExercicio}) {
    return _firestore.collection(userId).doc(idExercicio).delete();
  }
}
