import 'package:flutter/material.dart';

/// Extensão em [BuildContext] para facilitar a navegação global no [Navigator].
///
/// Todas as operações usam o [rootNavigator], permitindo controlar a navegação
/// principal da aplicação sem depender do contexto local de navegadores internos.
extension GlobalNavigator on BuildContext {
  /// Navega para uma nova rota, empilhando-a na stack de navegação.
  ///
  /// [route]: O nome da rota registrada.
  /// [arguments]: Argumentos opcionais enviados para a nova rota.
  Future<T?> pushGlobal<T>(
    String route, {
    Object? arguments,
  }) {
    return Navigator.of(this, rootNavigator: true).pushNamed<T>(
      route,
      arguments: arguments,
    );
  }

  /// Substitui a rota atual por uma nova rota.
  ///
  /// [route]: O nome da nova rota.
  /// [arguments]: Argumentos opcionais enviados para a nova rota.
  Future<T?> pushReplacementGlobal<T>(
    String route, {
    Object? arguments,
  }) {
    return Navigator.of(this, rootNavigator: true).pushReplacementNamed<T, T>(
      route,
      arguments: arguments,
    );
  }

  /// Navega para uma nova rota e remove as rotas anteriores até que [predicate] retorne `true`.
  ///
  /// Se [predicate] não for informado, todas as rotas anteriores serão removidas.
  ///
  /// [route]: O nome da nova rota.
  /// [arguments]: Argumentos opcionais enviados para a nova rota.
  /// [predicate]: Função que determina qual rota manter na stack.
  Future<T?> pushAndRemoveUntilGlobal<T>(
    String route, {
    Object? arguments,
    bool Function(Route<dynamic>)? predicate,
  }) {
    return Navigator.of(this, rootNavigator: true).pushNamedAndRemoveUntil<T>(
      route,
      predicate ?? (_) => false,
      arguments: arguments,
    );
  }

  /// Fecha a rota atual e retorna, opcionalmente, um [result] para a rota anterior.
  void popGlobal<T extends Object?>([T? result]) {
    Navigator.of(this, rootNavigator: true).pop<T>(result);
  }

  /// Tenta fechar a rota atual se possível.
  ///
  /// Retorna `true` se conseguir fechar, ou `false` caso contrário.
  Future<bool> maybePopGlobal<T extends Object?>([T? result]) {
    return Navigator.of(this, rootNavigator: true).maybePop<T>(result);
  }

  /// Fecha rotas da stack até que [predicate] retorne `true`.
  void popUntilGlobal(bool Function(Route<dynamic>) predicate) {
    Navigator.of(this, rootNavigator: true).popUntil(predicate);
  }

  /// Substitui a rota atual por uma nova rota e remove todas as anteriores até que [predicate] retorne `true`.
  ///
  /// Se [predicate] não for informado, todas as rotas anteriores serão removidas.
  ///
  /// [route]: O nome da nova rota.
  /// [arguments]: Argumentos opcionais enviados para a nova rota.
  /// [predicate]: Função que determina qual rota manter na stack.
  Future<T?> pushReplacementGlobalAndRemoveUntil<T>(
    String route, {
    Object? arguments,
    bool Function(Route<dynamic>)? predicate,
  }) {
    return Navigator.of(this, rootNavigator: true).pushNamedAndRemoveUntil<T>(
      route,
      predicate ?? (_) => false,
      arguments: arguments,
    );
  }
}
