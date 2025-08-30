import 'package:flutter/material.dart';

/// Um widget que intercepta tentativas de sair da tela (back button)
/// e permite confirmar ou bloquear a navegação.
///
/// Utiliza o [PopScope] internamente para controlar a navegação.
/// 
/// Quando o usuário tenta sair:
/// - Se [blockExit] for `true`, o widget impede o pop automático.
/// - Se [onConfirmExit] for fornecido, ele será chamado para decidir se deve permitir a saída.
/// - Se [onConfirmExit] retornar `true`, o pop será executado.
/// - Se [onConfirmExit] retornar `false`, a navegação será bloqueada.
/// 
/// Exemplo de uso:
/// ```dart
/// ConfirmExitWidget(
///   onConfirmExit: () async {
///     return await showDialog<bool>(
///           context: context,
///           builder: (context) => AlertDialog(
///             title: Text('Deseja sair?'),
///             content: Text('Tem certeza que quer sair desta tela?'),
///             actions: [
///               TextButton(onPressed: () => Navigator.of(context).pop(false), child: Text('Cancelar')),
///               TextButton(onPressed: () => Navigator.of(context).pop(true), child: Text('Sair')),
///             ],
///           ),
///         ) ?? false;
///   },
///   child: Scaffold(
///     appBar: AppBar(title: Text('Minha Tela')),
///     body: Center(child: Text('Conteúdo')),
///   ),
/// )
/// ```
///
/// Se [onConfirmExit] não for fornecido, o comportamento de bloqueio será controlado apenas pela flag [blockExit].
class ConfirmExitWidget extends StatelessWidget {
  /// Widget filho que será exibido dentro do [ConfirmExitWidget].
  final Widget child;

  /// Função opcional chamada para confirmar a saída.
  ///
  /// Deve retornar `true` para permitir a navegação, ou `false` para cancelar.
  /// Se não fornecida, apenas a configuração de [blockExit] será considerada.
  final Future<bool> Function()? onConfirmExit;

  /// Indica se deve bloquear a saída automática ao pressionar "voltar".
  ///
  /// Se `true`, impede a navegação até que [onConfirmExit] permita.
  /// Se `false`, o pop é permitido normalmente.
  final bool blockExit;

  /// Cria um [ConfirmExitWidget].
  const ConfirmExitWidget({
    super.key,
    required this.child,
    this.onConfirmExit,
    this.blockExit = true,
  });

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: !blockExit,
      onPopInvokedWithResult: (didPop, _) async {
        if (didPop) return;

        bool shouldExit = false;

        if (onConfirmExit != null) {
          shouldExit = await onConfirmExit!();
        }
        if (shouldExit && context.mounted) {
          Navigator.of(context).maybePop();
        }
      },
      child: child,
    );
  }
}
