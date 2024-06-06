import 'package:flutter/material.dart';
import 'package:teste/_comun/minhas_cores.dart';
import 'package:teste/modelos/exercicio_modelo.dart';
import 'package:teste/modelos/sentimento_modelo.dart';

class ExercicioTela extends StatelessWidget {
  final ExercicioModelo exercicioModelo;
  ExercicioTela({super.key, required this.exercicioModelo});

  final List<SentimentoModelo> listaSentimentos = [
    SentimentoModelo(
        id: "SE001", sentindo: "Pouca ativação hoje", data: "2024-04-17"),
    SentimentoModelo(
        id: "SE001", sentindo: "Muita ativação hoje", data: "2024-04-18")
  ];

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
            print("Foi clicado");
          },
          child: const Icon(Icons.add),
        ),
        body: Container(
          margin: EdgeInsets.all(8),
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
                "Como fazer?",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              const SizedBox(height: 8),
              Text(exercicioModelo.comoFazer),
              const Padding(
                padding: const EdgeInsets.all(8.0),
                child: const Divider(color: Colors.black),
              ),
              const Text(
                "Como estou me sentindo?",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              const SizedBox(height: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: List.generate(listaSentimentos.length, (index) {
                  SentimentoModelo sentimentoAgora = listaSentimentos[index];
                  return ListTile(
                    dense: true,
                    contentPadding: EdgeInsets.zero,
                    title: Text(sentimentoAgora.sentindo),
                    subtitle: Text(sentimentoAgora.data),
                    leading: const Icon(Icons.double_arrow),
                    trailing: IconButton(
                      icon: const Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                      onPressed: () {
                        print("DELETAR ${sentimentoAgora.sentindo}");
                      },
                    ),
                  );
                }),
              ),
            ],
          ),
        ));
  }
}
