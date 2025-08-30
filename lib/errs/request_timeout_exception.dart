import 'http_request_exception.dart';

/// Exceção lançada para erros HTTP 408 (Request Timeout).
/// 
/// Indica que o tempo limite de espera da requisição foi excedido.
class RequestTimeoutException extends HttpRequestException {
  /// Cria uma [RequestTimeoutException] com uma mensagem padrão.
  RequestTimeoutException([String? message])
      : super(message ?? 'Tempo de requisição excedido (Timeout).');
}