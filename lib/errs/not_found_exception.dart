import 'http_request_exception.dart';

/// Exceção lançada para erros HTTP 404 (Not Found).
/// 
/// Indica que o recurso solicitado não foi encontrado no servidor.
class NotFoundException extends HttpRequestException {
  /// Cria uma [NotFoundException] com uma mensagem padrão.
  NotFoundException([String? message])
      : super(message ?? 'Recurso não encontrado.');
}