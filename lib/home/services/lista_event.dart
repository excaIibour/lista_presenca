abstract class ListaEvent {}

class AdicionarNome extends ListaEvent {
  final String nome;

  AdicionarNome(this.nome);
}

class ExcluirNome extends ListaEvent {
  final String nome;

  ExcluirNome(this.nome);
}

class AlterarNome extends ListaEvent {
  final String nomeAntigo;
  final String nomeNovo;

  AlterarNome(this.nomeAntigo, this.nomeNovo);
}