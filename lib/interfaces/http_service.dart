/// Interface para serviços HTTP genéricos.
///
/// Define os métodos básicos de comunicação HTTP: [get], [post], [put], [patch], [delete],
/// além de um método para liberar recursos com [dispose].
///
/// Esta abstração permite isolar a camada de rede, facilitando testes, manutenção
/// e troca de implementação (ex: Dio, http, Chopper).
abstract interface class HttpService {
  /// Realiza uma requisição GET para [url].
  ///
  /// [headers]: Cabeçalhos HTTP opcionais.
  /// [queryParameters]: Parâmetros de consulta opcionais.
  Future<T> get<T>(
    String url, {
    Map<String, String>? headers,
    Map<String, dynamic>? queryParameters,
  });

  /// Realiza uma requisição POST para [url] com o [body].
  ///
  /// [headers]: Cabeçalhos HTTP opcionais.
  Future<T> post<T>(
    String url, {
    Map<String, String>? headers,
    dynamic body,
  });

  /// Realiza uma requisição PUT para [url] com o [body].
  ///
  /// [headers]: Cabeçalhos HTTP opcionais.
  Future<T> put<T>(
    String url, {
    Map<String, String>? headers,
    dynamic body,
  });

  /// Realiza uma requisição PATCH para [url] com o [body].
  ///
  /// [headers]: Cabeçalhos HTTP opcionais.
  Future<T> patch<T>(
    String url, {
    Map<String, String>? headers,
    dynamic body,
  });

  /// Realiza uma requisição DELETE para [url].
  ///
  /// [headers]: Cabeçalhos HTTP opcionais.
  /// [body]: Corpo da requisição opcional (nem todos servidores aceitam DELETE com body).
  Future<T> delete<T>(
    String url, {
    Map<String, String>? headers,
    dynamic body,
  });

  /// Libera recursos e fecha conexões ativas.
  ///
  /// Deve ser chamado para evitar vazamento de memória ao descartar o serviço.
  void dispose();
}
