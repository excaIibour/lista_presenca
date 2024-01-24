import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lista_presenca/home/services/lista_bloc.dart';
import 'package:lista_presenca/home/services/lista_event.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  bool estaBuscando = false;
  String textoBuscando = '';

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ListaBloc, ListaState>(
      builder: (context, state) {
        List<String> listaExibida = state.nomes
            .where((nome) => nome.toLowerCase().contains(textoBuscando.toLowerCase()))
            .toList();

        return Scaffold(
          appBar: AppBar(
            title: const Text('Lista de presença', style: TextStyle(fontSize: 20)),
            centerTitle: true,
          ),
          body: Stack(
            children: [
              if (listaExibida.isEmpty) 
                const Center(
                  child: Text(
                    'Parece que sua lista está vazia. Adicione os nomes no botão (+) abaixo para registrar as presenças!',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                )
              else
                ListView.builder(
                  itemCount: listaExibida.length,
                  itemBuilder: (context, index) {
                    final nome = listaExibida[index];
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30.0),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 4.0,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        child: ListTile(
                          title: Text(nome),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: Icon(Icons.edit, color: Colors.purple[200]),
                                onPressed: () {
                                  _mostrarPopUpEditar(context, nome);
                                },
                              ),
                              IconButton(
                                icon: Icon(Icons.delete_forever, color: Colors.red[200]),
                                onPressed: () {
                                  context.read<ListaBloc>().add(ExcluirNome(nome));
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  height: estaBuscando ? 100.0 : 0.0,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                        Colors.white.withOpacity(0.9),
                        Colors.white.withOpacity(0.0),
                      ],
                    ),
                  ),
                  child: estaBuscando
                      ? Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: 'Pesquisar...',
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30.0),
                                borderSide: BorderSide.none,
                              ),
                            ),
                            onChanged: (value) {
                              setState(() {
                                textoBuscando = value;
                              });
                            },
                          ),
                        )
                      : const SizedBox.shrink(),
                ),
              ),
            ],
          ),
          bottomNavigationBar: BottomAppBar(
            color: Colors.purple[200],
            shape: const CircularNotchedRectangle(),
            child: Container(
              height: 60.0,
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.person, color: Colors.white),
                    onPressed: () {
                      Navigator.pushNamed(context, '/perfil');
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.search, color: Colors.white),
                    onPressed: () {
                      setState(() {
                        estaBuscando = !estaBuscando;
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
          floatingActionButton: FloatingActionButton.large(
            onPressed: () {
              _mostrarPopUpAdicionar(context);
            },
            backgroundColor: Colors.purple[400],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(60.0),
            ),
            child: const Icon(Icons.add, color: Colors.white),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        );
      },
    );
  }

  void _mostrarPopUpAdicionar(BuildContext context) {
    final TextEditingController nomeController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shadowColor: Colors.white,
          title: const Text('Adicionar nome'),
          content: TextField(
            controller: nomeController,
            decoration: const InputDecoration(labelText: 'Nome'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancelar', style: TextStyle(color: Colors.purple[400])),
            ),
            TextButton(
              onPressed: () {
                final nome = nomeController.text;
                context.read<ListaBloc>().add(AdicionarNome(nome));
                Navigator.of(context).pop();
              },
              child: Text('Adicionar', style: TextStyle(color: Colors.purple[400])),
            ),
          ],
        );
      },
    );
  }

  void _mostrarPopUpEditar(BuildContext context, String nomeAntigo) {
    final TextEditingController nomeController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Editar nome'),
          content: TextField(
            controller: nomeController,
            decoration: const InputDecoration(labelText: 'Novo nome'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancelar', style: TextStyle(color: Colors.purple[400])),
            ),
            TextButton(
              onPressed: () {
                final nomeNovo = nomeController.text;
                context.read<ListaBloc>().add(AlterarNome(nomeAntigo, nomeNovo));
                Navigator.of(context).pop();
              },
              child: Text('Salvar', style: TextStyle(color: Colors.purple[400])),
            ),
          ],
        );
      },
    );
  }
}
