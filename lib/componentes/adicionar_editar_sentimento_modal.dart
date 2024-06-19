import 'package:flutter/material.dart';
import 'package:teste/componentes/adicionar_editar_exercicio_modal.dart';
import 'package:teste/modelos/exercicio_modelo.dart';
import 'package:teste/modelos/sentimento_modelo.dart';
import 'package:teste/servicos/sentimento_servico.dart';
import 'package:uuid/uuid.dart';

Future<dynamic> mostrarAdicionarEditarSentimentoDialog(
  BuildContext context, {
  required String idExercicio,
  SentimentoModelo? sentimentoModelo,
}) {
  return showDialog(
    context: context,
    builder: (context) {
      TextEditingController sentimentoController = TextEditingController();

      if (sentimentoModelo != null) {
        sentimentoController.text = sentimentoModelo.sentindo;
      }

      return AlertDialog(
        title: const Text("Adicionar dica?"),
        content: TextFormField(
          controller: sentimentoController,
          decoration: const InputDecoration(
            label: Text("Digite aqui"),
          ),
          maxLines: null,
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("Cancelar"),
          ),
          ElevatedButton(
            onPressed: () {
              SentimentoModelo sentimento = SentimentoModelo(
                id: const Uuid().v1(),
                sentindo: sentimentoController.text,
                data: DateTime.now().toString(),
              );
              if (sentimentoModelo != null) {
                sentimento.id = sentimentoModelo.id;
              }

              SentimentoServico().adicionarSentimento(
                idExercicio: idExercicio,
                sentimentoModelo: sentimento,
              );

              Navigator.pop(context);
            },
            child: Text((sentimentoModelo != null)
                ? "Editar dica"
                : "Criar dica"), //dicas
          ),
        ],
      );
    },
  );
}
