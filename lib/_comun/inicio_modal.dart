import 'package:flutter/material.dart';
import 'package:teste/_comun/minhas_cores.dart';
import 'package:teste/componentes/decoracao_campo_auten.dart';
import 'package:teste/modelos/exercicio_modelo.dart';
import 'package:teste/modelos/sentimento_modelo.dart';
import 'package:teste/servicos/exercicio_servico.dart';
import 'package:uuid/uuid.dart';

mostrarModalInicio(BuildContext context, {ExercicioModelo? exercicio}) {
  showModalBottomSheet(
    context: context,
    backgroundColor: MinhasCores.azulEscuro,
    isDismissible: false,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(32),
      ),
    ),
    builder: (context) {
      return ExercicioModal(
        exercicioModelo: exercicio,
      );
    },
  );
}

class ExercicioModal extends StatefulWidget {
  final ExercicioModelo? exercicioModelo;
  const ExercicioModal({super.key, this.exercicioModelo});

  @override
  State<ExercicioModal> createState() => _ExercicioModalState();
}

class _ExercicioModalState extends State<ExercicioModal> {
  TextEditingController _nomeCtrl = TextEditingController();
  TextEditingController _treinoCtrl = TextEditingController();
  TextEditingController _anotacoesCtrl = TextEditingController();
  TextEditingController _sentindoCtrl = TextEditingController();

  bool isCarregando = false;

  final ExercicioServico _exercicioServico = ExercicioServico();

  @override
  void initState() {
    if (widget.exercicioModelo != null) {
      _nomeCtrl.text = widget.exercicioModelo!.nome;
      _treinoCtrl.text = widget.exercicioModelo!.treino;
      _anotacoesCtrl.text = widget.exercicioModelo!.comoFazer;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(32),
      height: MediaQuery.of(context).size.height * 0.9,
      child: Form(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Text(
                        (widget.exercicioModelo != null)
                            ? "Editar ${widget.exercicioModelo!.nome}"
                            : "Adicionar Exercício",
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.close,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                const Divider(),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _nomeCtrl,
                      decoration: getAuthenticationInputDecoration(
                        "Qual o nome do Exercicio ?",
                        icon: const Icon(
                          Icons.abc,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _treinoCtrl,
                      decoration: getAuthenticationInputDecoration(
                        "Qual treino pertence ?",
                        icon: const Icon(
                          Icons.list_alt_rounded,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _anotacoesCtrl,
                      decoration: getAuthenticationInputDecoration(
                        "Quais anotações você tem ?",
                        icon: const Icon(
                          Icons.notes_rounded,
                          color: Colors.white,
                        ),
                      ),
                      maxLines: null,
                    ),
                    Visibility(
                      visible: (widget.exercicioModelo != null),
                      child: Column(
                        children: [
                          const SizedBox(height: 16),
                          TextFormField(
                            controller: _sentindoCtrl,
                            decoration: getAuthenticationInputDecoration(
                              "Como você está se sentindo ?",
                              icon: const Icon(
                                Icons.emoji_emotions_rounded,
                                color: Colors.white,
                              ),
                            ),
                            maxLines: null,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            ElevatedButton(
              onPressed: () {
                enviarClicado();
              },
              child: (isCarregando)
                  ? const SizedBox(
                      height: 16,
                      width: 16,
                      child: CircularProgressIndicator(
                          color: MinhasCores.azulEscuro),
                    )
                  : Text((widget.exercicioModelo != null)
                      ? "Editar Exercicio"
                      : "Criar exercício"),
            ),
          ],
        ),
      ),
    );
  }

  enviarClicado() {
    setState(() {
      isCarregando = true;
    });

    String nome = _nomeCtrl.text;
    String treino = _treinoCtrl.text;
    String anotacoes = _anotacoesCtrl.text;
    String sentindo = _sentindoCtrl.text;

    ExercicioModelo exercicio = ExercicioModelo(
      id: const Uuid().v1(),
      nome: nome,
      treino: treino,
      comoFazer: anotacoes,
    );

    if (widget.exercicioModelo != null) {
      exercicio.id = widget.exercicioModelo!.id;
    }

    _exercicioServico.adicionarExercicio(exercicio).then((value) {
      SentimentoModelo sentimento = SentimentoModelo(
        id: Uuid().v1(),
        sentindo: sentindo,
        data: DateTime.now().toString(),
      );

      _exercicioServico
          .adicionarSentimento(exercicio.id, sentimento)
          .then((value) {
        setState(() {
          isCarregando = false;
        });
        Navigator.pop(context);
      });
    });
  }
}
