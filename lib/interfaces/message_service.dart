import 'package:flutter/material.dart';

/// Interface para exibição de mensagens no aplicativo.
///
/// Define métodos para mostrar mensagens de sucesso, erro, informação e alerta,
/// podendo ser implementado usando Snackbar, Dialog, Toast ou outras abordagens visuais.
abstract class MessageService {
  /// Exibe uma mensagem de sucesso para o usuário.
  ///
  /// [context]: Contexto usado para exibir a mensagem.
  /// [message]: Texto da mensagem principal.
  /// [title]: (Opcional) Título da mensagem.
  Future<void> showSuccess(BuildContext context, String message, {String? title});

  /// Exibe uma mensagem de erro para o usuário.
  ///
  /// [context]: Contexto usado para exibir a mensagem.
  /// [message]: Texto da mensagem principal.
  /// [title]: (Opcional) Título da mensagem.
  Future<void> showError(BuildContext context, String message, {String? title});

  /// Exibe uma mensagem informativa para o usuário.
  ///
  /// [context]: Contexto usado para exibir a mensagem.
  /// [message]: Texto da mensagem principal.
  /// [title]: (Opcional) Título da mensagem.
  Future<void> showInfo(BuildContext context, String message, {String? title});

  /// Exibe uma mensagem de alerta/aviso para o usuário.
  ///
  /// [context]: Contexto usado para exibir a mensagem.
  /// [message]: Texto da mensagem principal.
  /// [title]: (Opcional) Título da mensagem.
  Future<void> showWarning(BuildContext context, String message, {String? title});
}
