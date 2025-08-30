/// Modelo genérico para representar resultados paginados.
///
/// Usado para encapsular uma lista de itens [items] e o total de registros [total]
/// disponíveis, independentemente do número de páginas carregadas.
///
/// Ideal para APIs, consultas a bancos de dados ou carregamento de listas parciais.
class PaginatedResult<T> {
  /// Lista dos itens retornados na página atual.
  final List<T> items;

  /// Número total de itens disponíveis (não apenas os da página atual).
  final int total;

  /// Cria um [PaginatedResult] com uma lista de [items] e o [total] de registros.
  PaginatedResult({required this.items, required this.total});
}
