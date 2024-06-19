import 'package:flutter/material.dart';
import 'package:teste/_comun/minhas_cores.dart';
import 'package:teste/modelos/exercicio_modelo.dart';
import 'package:teste/servicos/exercicio_servico.dart';

import 'adicionar_editar_exercicio_modal.dart';
import '../telas/exercicio_tela.dart';

class InicioItemLista extends StatelessWidget {
  final ExercicioModelo exercicioModelo;
  final ExercicioServico servico;
  const InicioItemLista(
      {super.key, required this.exercicioModelo, required this.servico});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                ExercicioTela(exercicioModelo: exercicioModelo),
          ), //aa
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 3,
              color: Colors.black.withAlpha(100),
              spreadRadius: 1,
              offset: const Offset(1, 1),
            ),
          ],
          borderRadius: BorderRadius.circular(16),
        ),
        height: 100,
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 32),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.bottomRight,
              child: Container(
                decoration: const BoxDecoration(
                  color: MinhasCores.azulEscuro,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16),
                      bottomRight: Radius.circular(16)),
                ),
                height: 30,
                width: 150,
                child: Center(
                  child: Text(
                    exercicioModelo.treino,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 200,
                        child: Text(
                          exercicioModelo.nome,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: MinhasCores.azulEscuro,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit),
                            onPressed: () {
                              mostrarAdicionarEditarExercicioModal(context,
                                  exercicio: exercicioModelo);
                            },
                          ),
                          IconButton(
                            onPressed: () {
                              SnackBar snackBar = SnackBar(
                                backgroundColor: Colors.red,
                                content: Text(
                                  "Deseja remover ${exercicioModelo.nome}?",
                                ),
                                action: SnackBarAction(
                                  label: "REMOVER",
                                  textColor: Colors.white,
                                  onPressed: () {
                                    servico.removerExercicio(
                                        idExercicio: exercicioModelo.id);
                                  },
                                ),
                              );

                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            },
                            icon: const Icon(
                              Icons.delete,
                              color: Colors.red,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 150,
                        child: Text(
                          "${exercicioModelo.peso} Kg",
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
