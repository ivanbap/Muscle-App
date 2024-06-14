import 'package:flutter/material.dart';
import 'package:teste/_comun/minhas_cores.dart';
import 'package:teste/componentes/adicionar_editar_sentimento_modal.dart';
import 'package:teste/modelos/exercicio_modelo.dart';
import 'package:teste/modelos/sentimento_modelo.dart';
import 'package:teste/servicos/sentimento_servico.dart';

class ExercicioTela extends StatelessWidget {
  final ExercicioModelo exercicioModelo;
  ExercicioTela({super.key, required this.exercicioModelo});

  SentimentoServico _sentimentoServico = SentimentoServico();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blue,
        appBar: AppBar(
          title: Column(children: [
            Text(
              exercicioModelo.nome,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
            ),
            Text(
              exercicioModelo.treino,
              style: const TextStyle(fontSize: 15),
            ),
          ]),
          centerTitle: true,
          backgroundColor: MinhasCores.azulEscuro,
          elevation: 0,
          toolbarHeight: 72,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(32),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            mostrarAdicionarEditarSentimentoDialog(context,
                idExercicio: exercicioModelo.id);
          },
          child: const Icon(Icons.add),
        ),
        body: Container(
          margin: const EdgeInsets.all(8),
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(16)),
          child: ListView(
            children: [
              SizedBox(
                height: 250,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                      onPressed: () {},
                      child: const Text("Enviar Foto"),
                    ),
                    ElevatedButton(
                        onPressed: () {}, child: const Text("Tirar foto")),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                "Quantas repetições ?",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              const SizedBox(height: 8),
              Text(exercicioModelo.repeticoes),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Divider(color: Colors.black),
              ),
              const SizedBox(height: 8),
              const Text(
                "Quantos Kg ?",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              const SizedBox(height: 8),
              Text(exercicioModelo.peso),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Divider(color: Colors.black),
              ),
              const Text(
                "Como fazer/Dicas ?",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              const SizedBox(height: 8),
              StreamBuilder(
                stream: _sentimentoServico.conectarStream(
                    idExercicio: exercicioModelo.id),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    if (snapshot.hasData &&
                        snapshot.data != null &&
                        snapshot.data!.docs.isNotEmpty) {
                      final List<SentimentoModelo> listaSentimentos = [];

                      for (var doc in snapshot.data!.docs) {
                        listaSentimentos
                            .add(SentimentoModelo.fromMap(doc.data()));
                      }
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children:
                            List.generate(listaSentimentos.length, (index) {
                          SentimentoModelo sentimentoAgora =
                              listaSentimentos[index];
                          return ListTile(
                            dense: true,
                            contentPadding: EdgeInsets.zero,
                            title: Text(sentimentoAgora.sentindo),
                            subtitle: Text(sentimentoAgora.data),
                            leading: const Icon(Icons.double_arrow),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  onPressed: () {
                                    mostrarAdicionarEditarSentimentoDialog(
                                      context,
                                      idExercicio: exercicioModelo.id,
                                      sentimentoModelo: sentimentoAgora,
                                    );
                                  },
                                  icon: const Icon(Icons.edit),
                                ),
                                IconButton(
                                  icon: const Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  ),
                                  onPressed: () {
                                    _sentimentoServico.removerSentimento(
                                        exercicioId: exercicioModelo.id,
                                        sentimentoId: sentimentoAgora.id);
                                  },
                                ),
                              ],
                            ),
                          );
                        }),
                      );
                    } else {
                      return const Text("Nenhuma anotação de peso ainda");
                    }
                  }
                },
              )
            ],
          ),
        ));
  }
}
