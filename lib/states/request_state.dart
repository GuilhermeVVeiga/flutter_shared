import '../enums/request_status.dart';

/// Representa o estado de uma operação assíncrona.
///
/// Gerencia os diferentes momentos de uma requisição, como inicialização,
/// carregamento, sucesso, erro ou vazio.
///
/// Útil para controle de estado de listas, formulários, carregamentos de API, etc.
class RequestState<T> {
  /// Status atual da operação.
  final RequestStatus status;

  /// Dados retornados pela operação, se houver.
  final T? data;

  /// Mensagem de erro, se houver.
  final String? message;

  /// Construtor interno usado pelos outros construtores nomeados.
  const RequestState._(this.status, this.data, this.message);

  /// Estado inicial, sem ação ainda executada.
  const RequestState.init([T? data]) : this._(RequestStatus.init, data, null);

  /// Estado de carregamento ativo.
  const RequestState.loading() : this._(RequestStatus.loading, null, null);

  /// Estado de sucesso, com os [data] recebidos.
  const RequestState.success(T data) : this._(RequestStatus.success, data, null);

  /// Estado de erro, com uma [message] descritiva.
  const RequestState.error(String message) : this._(RequestStatus.error, null, message);

  /// Estado de sucesso, mas sem dados disponíveis.
  const RequestState.empty() : this._(RequestStatus.empty, null, null);

  /// Indica se o estado atual é de carregamento.
  bool get isLoading => status == RequestStatus.loading;

  /// Indica se o estado atual é de sucesso.
  bool get isSuccess => status == RequestStatus.success;

  /// Indica se o estado atual é de erro.
  bool get isError => status == RequestStatus.error;

  /// Indica se o estado atual é de inicialização.
  bool get isInit => status == RequestStatus.init;

  /// Indica se o estado atual é vazio.
  bool get isEmpty => status == RequestStatus.empty;
}
