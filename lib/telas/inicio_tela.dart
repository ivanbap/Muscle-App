import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:teste/_comun/inicio_modal.dart';
import 'package:teste/_comun/minhas_cores.dart';
import 'package:teste/componentes/inicio_lista_widgets.dart';
import 'package:teste/servicos/autenticacao_servico.dart';
import 'package:teste/modelos/exercicio_modelo.dart';
import 'package:teste/servicos/exercicio_servico.dart';
import 'package:teste/telas/exercicio_tela.dart';

class InicioTela extends StatefulWidget {
  final User user;
  InicioTela({super.key, required this.user});

  @override
  State<InicioTela> createState() => _InicioTelaState();
}

class _InicioTelaState extends State<InicioTela> {
  final ExercicioServico servico = ExercicioServico();
  bool isDecrescente = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blue,
        appBar: AppBar(
          title: const Text("Meus Exercícios"),
          actions: [
            IconButton(
                onPressed: () {
                  setState(() {
                    isDecrescente = !isDecrescente;
                  });
                },
                icon: const Icon(Icons.sort_by_alpha_rounded))
          ],
        ),
        drawer: Drawer(
          child: ListView(
            children: [
              UserAccountsDrawerHeader(
                currentAccountPicture: const CircleAvatar(
                    backgroundImage: AssetImage("assets/testt.png")),
                accountName: Text((widget.user.displayName != null)
                    ? widget.user.displayName!
                    : ""),
                accountEmail: Text(widget.user.email!),
              ),
              ListTile(
                title: const Text("Quer saber como esse App foi feito?"),
                leading: const Icon(Icons.menu_book_rounded),
                dense: true,
                onTap: () {},
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.logout),
                title: const Text("Deslogar"),
                dense: true,
                onTap: () {
                  AutenticacaoServico().deslogar();
                },
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            mostrarModalInicio(context);
          },
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: StreamBuilder(
            stream: servico.conectarStreamExercicios(isDecrescente),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                if (snapshot.hasData &&
                    snapshot.data != null &&
                    snapshot.data!.docs.isNotEmpty) {
                  List<ExercicioModelo> listaExericios = [];

                  for (var doc in snapshot.data!.docs) {
                    listaExericios.add(ExercicioModelo.fromMap(doc.data()));
                  }

                  return ListView(
                    children: List.generate(
                      listaExericios.length,
                      (index) {
                        ExercicioModelo exercicioModelo = listaExericios[index];
                        return InicioItemLista(
                          exercicioModelo: exercicioModelo,
                          servico: servico,
                        );
                      },
                    ),
                  );
                } else {
                  return const Center(
                    child: Text("Ainda nenhum exercício.\nVamos adicionar?"),
                  );
                }
              }
            },
          ),
        ));
  }
}
