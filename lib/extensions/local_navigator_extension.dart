import 'package:flutter/material.dart';

/// Extensão em [BuildContext] para facilitar a navegação **local** usando o [Navigator].
///
/// Todas as operações usam o `Navigator.of(context)` padrão (sem `rootNavigator: true`),
/// ideal para navegar dentro de um **Navigator interno** (ex.: Nested Navigators em abas).
extension LocalNavigator on BuildContext {
  /// Navega para uma nova rota local, empilhando-a na stack de navegação atual.
  ///
  /// [route]: O nome da rota registrada.
  /// [arguments]: Argumentos opcionais enviados para a nova rota.
  Future<T?> pushLocal<T>(
    String route, {
    Object? arguments,
  }) {
    return Navigator.of(this).pushNamed<T>(
      route,
      arguments: arguments,
    );
  }

  /// Substitui a rota local atual por uma nova rota.
  ///
  /// [route]: O nome da nova rota.
  /// [arguments]: Argumentos opcionais enviados para a nova rota.
  Future<T?> pushReplacementLocal<T>(
    String route, {
    Object? arguments,
  }) {
    return Navigator.of(this).pushReplacementNamed<T, T>(
      route,
      arguments: arguments,
    );
  }

  /// Navega para uma nova rota local e remove as rotas anteriores até que [predicate] retorne `true`.
  ///
  /// Se [predicate] não for informado, todas as rotas anteriores serão removidas.
  ///
  /// [route]: O nome da nova rota.
  /// [arguments]: Argumentos opcionais enviados para a nova rota.
  /// [predicate]: Função que determina quais rotas manter na pilha.
  Future<T?> pushAndRemoveUntilLocal<T>(
    String route, {
    Object? arguments,
    bool Function(Route<dynamic>)? predicate,
  }) {
    return Navigator.of(this).pushNamedAndRemoveUntil<T>(
      route,
      predicate ?? (_) => false,
      arguments: arguments,
    );
  }

  /// Fecha a rota local atual e retorna, opcionalmente, um [result] para a rota anterior.
  void popLocal<T extends Object?>([T? result]) {
    Navigator.of(this).pop<T>(result);
  }

  /// Tenta fechar a rota local atual.
  ///
  /// Retorna `true` se conseguir fechar, ou `false` caso contrário.
  Future<bool> maybePopLocal<T extends Object?>([T? result]) {
    return Navigator.of(this).maybePop<T>(result);
  }

  /// Fecha as rotas locais da stack até que [predicate] retorne `true`.
  ///
  /// [predicate]: Função que determina até onde a stack será desempilhada.
  void popUntilLocal(bool Function(Route<dynamic>) predicate) {
    Navigator.of(this).popUntil(predicate);
  }
}
