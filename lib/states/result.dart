/// Um tipo funcional que representa o resultado de uma operação que pode
/// ser bem-sucedida ([Success]) ou falhar ([Failure]).
///
/// Baseado em padrões como `Either` e `Result` de linguagens funcionais,
/// esse tipo ajuda a escrever código mais seguro e expressivo,
/// evitando o uso de `try/catch` diretamente.
///
/// - [TSuccess] representa o tipo em caso de sucesso.
/// - [TFailure] representa o tipo em caso de erro.
sealed class Result<TSuccess, TFailure> {
  const Result();

  /// `true` se o resultado representa sucesso.
  bool get isSuccess => this is Success<TSuccess, TFailure>;

  /// `true` se o resultado representa falha.
  bool get isFailure => this is Failure<TSuccess, TFailure>;

  /// Retorna o valor de sucesso, ou `null` se for falha.
  TSuccess? getOrNull() {
    if (this is Success<TSuccess, TFailure>) {
      return (this as Success).value;
    }
    return null;
  }

  /// Retorna o valor de falha, ou `null` se for sucesso.
  TFailure? getOrNullFailure() {
    if (this is Failure<TSuccess, TFailure>) {
      return (this as Failure).value;
    }
    return null;
  }

  /// Executa uma das funções dependendo se é [Success] ou [Failure].
  ///
  /// - [onSuccess] é executado se for sucesso.
  /// - [onFailure] é executado se for falha.
  ///
  /// Retorna o valor resultante da função executada.
  T fold<T>(
    T Function(TSuccess value) onSuccess,
    T Function(TFailure error) onFailure,
  ) {
    if (this is Success<TSuccess, TFailure>) {
      return onSuccess((this as Success).value);
    } else {
      return onFailure((this as Failure).value);
    }
  }

  /// Transforma o valor de sucesso mantendo o tipo de falha.
  ///
  /// Útil para converter de `Result<UserEntity, String>` para
  /// `Result<UserDto, String>`, por exemplo.
  Result<TNewSuccess, TFailure> map<TNewSuccess>(
    TNewSuccess Function(TSuccess value) transform,
  ) {
    if (this is Success<TSuccess, TFailure>) {
      return Success<TNewSuccess, TFailure>(
        transform((this as Success).value),
      );
    } else {
      return Failure<TNewSuccess, TFailure>((this as Failure).value);
    }
  }

  /// Transforma o valor de falha mantendo o tipo de sucesso.
  ///
  /// Útil para traduzir ou adaptar erros para outros formatos.
  Result<TSuccess, TNewFailure> mapFailure<TNewFailure>(
    TNewFailure Function(TFailure error) transform,
  ) {
    if (this is Failure<TSuccess, TFailure>) {
      return Failure<TSuccess, TNewFailure>(
        transform((this as Failure).value),
      );
    } else {
      return Success<TSuccess, TNewFailure>((this as Success).value);
    }
  }

  /// Encadeia uma nova operação baseada no valor de sucesso.
  ///
  /// Se for falha, mantém a mesma falha.
  Result<TNewSuccess, TFailure> flatMap<TNewSuccess>(
    Result<TNewSuccess, TFailure> Function(TSuccess value) transform,
  ) {
    if (this is Success<TSuccess, TFailure>) {
      return transform((this as Success).value);
    } else {
      return Failure<TNewSuccess, TFailure>((this as Failure).value);
    }
  }

  /// Encadeia uma nova operação baseada no valor de falha.
  ///
  /// Se for sucesso, mantém o mesmo sucesso.
  Result<TSuccess, TNewFailure> flatMapFailure<TNewFailure>(
    Result<TSuccess, TNewFailure> Function(TFailure error) transform,
  ) {
    if (this is Failure<TSuccess, TFailure>) {
      return transform((this as Failure).value);
    } else {
      return Success<TSuccess, TNewFailure>((this as Success).value);
    }
  }
}

/// Representa um resultado bem-sucedido, contendo um valor do tipo [TSuccess].
class Success<TSuccess, TFailure> extends Result<TSuccess, TFailure> {
  /// Valor retornado com sucesso.
  final TSuccess value;

  /// Cria uma instância de sucesso com [value].
  const Success(this.value);
}

/// Representa um resultado de erro, contendo um valor do tipo [TFailure].
class Failure<TSuccess, TFailure> extends Result<TSuccess, TFailure> {
  /// Valor representando a falha.
  final TFailure value;

  /// Cria uma instância de falha com [value].
  const Failure(this.value);
}

/// Representa um tipo vazio para operações de sucesso que não retornam valor.
///
/// Ideal para `Result<ResultVoid, String>`, evitando o uso direto de `void`.
class ResultVoid {
  /// Instância vazia.
  const ResultVoid();
}

