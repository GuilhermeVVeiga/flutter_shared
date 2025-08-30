import 'package:flutter/material.dart';

/// Helper para navegação global utilizando um [GlobalKey<NavigatorState>].
/// 
/// Permite navegar sem precisar de [BuildContext], ideal para usar em services, controllers e viewmodels.
class NavigatorHelper {
  /// Chave global para acessar o estado do [Navigator].
  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  /// Navega para uma nova rota empilhando na stack de navegação.
  /// 
  /// [route] é o nome da rota registrada.
  /// [arguments] são argumentos opcionais enviados para a nova rota.
  static Future<T?> push<T>(String route, {Object? arguments}) {
    return navigatorKey.currentState?.pushNamed<T>(
          route,
          arguments: arguments,
        ) ??
        Future.value(null);
  }

  /// Substitui a rota atual por uma nova rota.
  /// 
  /// [route] é o nome da nova rota.
  /// [arguments] são argumentos opcionais enviados para a nova rota.
  static Future<T?> pushReplacement<T>(String route, {Object? arguments}) {
    return navigatorKey.currentState?.pushReplacementNamed<T, T>(
          route,
          arguments: arguments,
        ) ??
        Future.value(null);
  }

  /// Navega para uma nova rota e remove as rotas anteriores até que [predicate] retorne true.
  /// 
  /// Se [predicate] for omitido, remove todas as rotas anteriores.
  /// 
  /// [route] é o nome da nova rota.
  /// [arguments] são argumentos opcionais enviados para a nova rota.
  static Future<T?> pushAndRemoveUntil<T>(
    String route, {
    Object? arguments,
    bool Function(Route<dynamic>)? predicate,
  }) {
    return navigatorKey.currentState?.pushNamedAndRemoveUntil<T>(
          route,
          predicate ?? (_) => false,
          arguments: arguments,
        ) ??
        Future.value(null);
  }

  /// Fecha a rota atual e retorna opcionalmente [result] para a rota anterior.
  static void pop<T extends Object?>([T? result]) {
    navigatorKey.currentState?.pop<T>(result);
  }

  /// Tenta fechar a rota atual se possível.
  /// 
  /// Retorna `true` se conseguir fechar, ou `false` se não houver rota para fechar.
  static Future<bool> maybePop<T extends Object?>([T? result]) {
    return navigatorKey.currentState?.maybePop<T>(result) ?? Future.value(false);
  }

  /// Fecha rotas até que [predicate] retorne `true`.
  /// 
  /// Útil para voltar para uma rota específica na stack.
  static void popUntil(bool Function(Route<dynamic>) predicate) {
    navigatorKey.currentState?.popUntil(predicate);
  }

  /// Substitui a rota atual por uma nova rota e remove todas as anteriores até [predicate] retornar `true`.
  /// 
  /// Se [predicate] for omitido, remove todas as rotas anteriores.
  /// 
  /// [route] é o nome da nova rota.
  /// [arguments] são argumentos opcionais enviados para a nova rota.
  static Future<T?> pushReplacementAndRemoveUntil<T>(
    String route, {
    Object? arguments,
    bool Function(Route<dynamic>)? predicate,
  }) {
    return navigatorKey.currentState?.pushNamedAndRemoveUntil<T>(
          route,
          predicate ?? (_) => false,
          arguments: arguments,
        ) ??
        Future.value(null);
  }
}
