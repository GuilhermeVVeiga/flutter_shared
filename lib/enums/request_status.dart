/// Representa o estado de uma requisição ou processo assíncrono.
///
/// Útil para controle de estado de telas, formulários, carregamentos de API, etc.
enum RequestStatus {
  /// Estado inicial, sem nenhuma ação iniciada.
  init,

  /// Estado de carregamento, geralmente exibindo um loader/spinner.
  loading,

  /// Estado de sucesso, operação concluída corretamente.
  success,

  /// Estado de erro, operação falhou.
  error,

  /// Estado de vazio, operação concluída mas sem dados (ex: lista vazia).
  empty,
}
