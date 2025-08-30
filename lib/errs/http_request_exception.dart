/// Exceções específicas para erros de requisição HTTP.
/// 
/// Essas exceções devem ser lançadas por implementações de [HttpService]
/// para representar erros padrão de comunicação com APIs.
abstract class HttpRequestException implements Exception {
  /// Mensagem descritiva do erro.
  final String message;

  /// Construtor base para exceções de requisição HTTP.
  HttpRequestException(this.message);

  @override
  String toString() => message;
}