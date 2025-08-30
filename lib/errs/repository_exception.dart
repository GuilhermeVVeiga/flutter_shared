/// Exceção lançada para indicar falhas nas operações de repositórios.
///
/// Normalmente usada para representar erros ao acessar ou manipular fontes de dados,
/// como APIs, bancos de dados locais, caches, etc.
class RepositoryException implements Exception {
  /// Mensagem descritiva do erro ocorrido no repositório.
  final String message;

  /// Cria uma [RepositoryException] com a [message] fornecida.
  RepositoryException(this.message);

  @override
  String toString() => message;
}
