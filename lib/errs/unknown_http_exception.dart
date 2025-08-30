import 'http_request_exception.dart';

/// Exceção genérica para qualquer outro tipo de erro HTTP não mapeado.
/// 
/// Usada como fallback quando o código de erro não é tratado explicitamente.
class UnknownHttpException extends HttpRequestException {
  /// Cria uma [UnknownHttpException] com uma mensagem personalizada.
  UnknownHttpException([String? message])
      : super(message ?? 'Erro desconhecido ao processar a requisição.');
}