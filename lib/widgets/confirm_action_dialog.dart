import 'package:flutter/material.dart';

/// Um diálogo genérico de confirmação + cancelamento.
/// A lógica de negócio (o que acontece quando confirma)
/// fica isolada no seu callback [onConfirm].
class ConfirmActionDialog extends StatelessWidget {
  final String title;
  final String message;
  final String confirmLabel;
  final String cancelLabel;
  final VoidCallback onConfirm;

  const ConfirmActionDialog({
    super.key,
    required this.title,
    required this.message,
    required this.onConfirm,
    this.confirmLabel = 'OK',
    this.cancelLabel = 'Cancelar',
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: Text(cancelLabel),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(true);
            onConfirm();
          },
          child: Text(confirmLabel),
        ),
      ],
    );
  }
}
