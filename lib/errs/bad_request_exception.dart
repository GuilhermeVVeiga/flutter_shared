import 'http_request_exception.dart';

/// Exceção lançada para erros HTTP 400 (Bad Request).
/// 
/// Indica que o servidor não pôde processar a requisição devido a dados inválidos.
class BadRequestException extends HttpRequestException {
  /// Cria uma [BadRequestException] opcionalmente com uma mensagem personalizada.
  BadRequestException([String? message])
      : super(message ?? 'Requisição inválida (Bad Request).');
}