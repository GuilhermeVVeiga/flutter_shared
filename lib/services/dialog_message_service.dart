import 'package:flutter/material.dart';
import '../interfaces/message_service.dart';

/// Implementação de MessageService usando AlertDialogs.
class DialogMessageService implements MessageService {
  @override
  Future<void> showSuccess(BuildContext context, String message, {String? title}) async =>
      _showDialog(
        context,
        title ?? 'Sucesso',
        message,
        icon: Icons.check_circle,
        iconColor: Colors.green,
      );

  @override
  Future<void> showError(BuildContext context, String message, {String? title}) async =>
      _showDialog(
        context,
        title ?? 'Erro',
        message,
        icon: Icons.error,
        iconColor: Colors.red,
      );

  @override
  Future<void> showInfo(BuildContext context, String message, {String? title}) async =>
      _showDialog(
        context,
        title ?? 'Informação',
        message,
        icon: Icons.info,
        iconColor: Colors.blue,
      );

  @override
  Future<void> showWarning(BuildContext context, String message, {String? title}) async =>
      _showDialog(
        context,
        title ?? 'Alerta',
        message,
        icon: Icons.warning,
        iconColor: Colors.orange,
      );

  Future<void> _showDialog(
    BuildContext context,
    String title,
    String message, {
    required IconData icon,
    required Color iconColor,
  }) async {
    return showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            Icon(icon, color: iconColor),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}
