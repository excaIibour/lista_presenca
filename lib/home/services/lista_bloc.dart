import 'package:bloc/bloc.dart';
import 'package:lista_presenca/home/services/lista_event.dart';

class ListaState {
  final List<String> nomes;

  ListaState(this.nomes);
}

class ListaBloc extends Bloc<ListaEvent, ListaState> {
  ListaBloc() : super(ListaState([])) {
    on<AdicionarNome>((event, emit) {
      emit(ListaState([...state.nomes, event.nome]));
    });

    on<ExcluirNome>((event, emit) {
      emit(ListaState(List.from(state.nomes)..remove(event.nome)));
    });

    on<AlterarNome>((event, emit) {
      final index = state.nomes.indexOf(event.nomeAntigo);
      final nomesAtualizados = List<String>.from(state.nomes);
      nomesAtualizados[index] = event.nomeNovo;
      emit(ListaState(nomesAtualizados));
    });
  }
}
