import 'package:flutter/material.dart';
import 'result.dart';

/// Base para comandos reativos que executam uma ação assíncrona
/// e retornam um [Result] contendo [TSuccess] ou [TFailure].
///
/// Notifica listeners durante:
/// - Início da execução (quando [running] vira `true`)
/// - Fim da execução com [result], seja sucesso ou erro
abstract class CommandBase<TSuccess, TFailure> extends ChangeNotifier {
  bool _running = false;
  Result<TSuccess, TFailure>? _result;

  /// Se a ação está em execução
  bool get running => _running;

  /// Resultado da última execução (sucesso ou falha)
  Result<TSuccess, TFailure>? get result => _result;

  /// Valor de sucesso (ou `null` se falhou)
  TSuccess? get value => _result?.getOrNull();

  /// Valor de falha (ou `null` se teve sucesso)
  TFailure? get error => _result?.getOrNullFailure();

  /// `true` se a última execução terminou com sucesso
  bool get completed => _result?.isSuccess == true;

  /// `true` se a última execução terminou com falha
  bool get failed => _result?.isFailure == true;

  /// Executa a função fornecida, atualizando o estado
  @protected
  Future<void> executeImpl(Future<Result<TSuccess, TFailure>> Function() action) async {
    if (_running) return;

    _running = true;
    _result = null;
    notifyListeners();

    try {
      _result = await action();
    } catch (e) {
      _result = Failure<TSuccess, TFailure>(e.toString() as TFailure);
    }

    _running = false;
    notifyListeners();
  }

  /// Limpa o erro/sucesso atual e notifica listeners.
  ///
  /// Útil para evitar que mensagens de erro antigas persistam.
  void clearError() {
    _result = null;
    notifyListeners();
  }
}


/// Comando sem parâmetros.
///
/// Executa uma função assíncrona e emite um [Result].
class Command0<TSuccess, TFailure> extends CommandBase<TSuccess, TFailure> {
  final Future<Result<TSuccess, TFailure>> Function() action;

  Command0(this.action);

  /// Inicia a execução da função encapsulada.
  Future<Result<TSuccess, TFailure>> execute() async {
    await executeImpl(action);
    return result!;
  }
}

/// Comando com um parâmetro.
///
/// [TSuccess] é o tipo de sucesso esperado.
/// [TFailure] é o tipo de falha.
/// [TParam] é o tipo do parâmetro necessário para executar a ação.
class Command1<TSuccess, TFailure, TParam>
    extends CommandBase<TSuccess, TFailure> {
  final Future<Result<TSuccess, TFailure>> Function(TParam param) action;

  /// Cria um comando que espera um parâmetro para executar.
  Command1(this.action);

  /// Executa a ação com o parâmetro fornecido.
  Future<Result<TSuccess, TFailure>> execute(TParam param) async {
    await executeImpl(() => action(param));
    return result!;
  }
}


/// Representa o estado atual de um comando.
class CommandState<TSuccess, TFailure> {
  final TSuccess? data;
  final TFailure? error;
  final bool isLoading;
  final bool hasError;
  final bool hasData;

  const CommandState({
    this.data,
    this.error,
    required this.isLoading,
    required this.hasError,
    required this.hasData,
  });

  factory CommandState.fromCommand(CommandBase<TSuccess, TFailure> command) {
    return CommandState(
      data: command.value,
      error: command.error,
      isLoading: command.running,
      hasError: command.failed,
      hasData: command.completed,
    );
  }
}