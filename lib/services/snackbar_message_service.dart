import 'package:flutter/material.dart';

import '../interfaces/message_service.dart';

/// Implementação padrão de MessageService usando Snackbars.
class SnackbarMessageService implements MessageService {
  @override
  Future<void> showSuccess(
    BuildContext context,
    String message, {
    String? title,
  }) async => _show(context, message, Colors.green, Icons.check_circle);

  @override
  Future<void> showError(
    BuildContext context,
    String message, {
    String? title,
  }) async => _show(context, message, Colors.red, Icons.error);

  @override
  Future<void> showInfo(
    BuildContext context,
    String message, {
    String? title,
  }) async => _show(context, message, Colors.blue, Icons.info);

  @override
  Future<void> showWarning(
    BuildContext context,
    String message, {
    String? title,
  }) async => _show(context, message, Colors.orange, Icons.warning);

  Future<void> _show(
    BuildContext context,
    String message,
    Color color,
    IconData icon,
  ) async {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(icon, color: Colors.white),
            const SizedBox(width: 12),
            Expanded(
              child: Text(message, style: const TextStyle(color: Colors.white)),
            ),
          ],
        ),
        backgroundColor: color,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(16),
        duration: const Duration(seconds: 3),
      ),
    );
  }
}
