import 'http_request_exception.dart';

/// Exceção lançada para erros HTTP 500 (Internal Server Error).
/// 
/// Indica que ocorreu um erro inesperado no servidor.
class ServerErrorException extends HttpRequestException {
  /// Cria uma [ServerErrorException] com uma mensagem padrão.
  ServerErrorException([String? message])
      : super(message ?? 'Erro interno no servidor.');
}