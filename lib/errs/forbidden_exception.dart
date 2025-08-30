import 'http_request_exception.dart';

/// Exceção lançada para erros HTTP 403 (Forbidden).
/// 
/// Indica que o usuário está autenticado, mas não tem permissão para acessar o recurso.
class ForbiddenException extends HttpRequestException {
  /// Cria uma [ForbiddenException] com uma mensagem padrão.
  ForbiddenException([String? message])
      : super(message ?? 'Acesso proibido (Forbidden).');
}