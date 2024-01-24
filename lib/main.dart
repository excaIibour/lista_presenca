import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lista_presenca/home/services/lista_bloc.dart';
import 'package:lista_presenca/home/home.dart';
import 'package:lista_presenca/home/perfil.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ListaBloc>(create: (context) => ListaBloc()),
      ],
      child: MaterialApp(
        title: 'Lista de Presença',
        theme: ThemeData(
          primarySwatch: Colors.orange,
        ),
        routes: {
        '/': (context) => const Home(),
        '/perfil': (context) => const Perfil(),
      },
      ),
    );
  }
}