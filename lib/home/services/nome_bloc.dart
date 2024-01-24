import 'package:bloc/bloc.dart';

class NomeBloc extends Bloc<String, String> {
  NomeBloc() : super('');

  Stream<String> mapEventToState(String event) async* {
    yield event;
  }
}