import 'http_request_exception.dart';

/// Exceção lançada para erros HTTP 401 (Unauthorized).
/// 
/// Indica que o usuário não está autenticado ou a autenticação falhou.
class UnauthorizedException extends HttpRequestException {
  /// Cria uma [UnauthorizedException] com uma mensagem padrão.
  UnauthorizedException([String? message])
      : super(message ?? 'Usuário não autorizado.');
}