import 'package:flutter/material.dart';

/// Widget que exibe um botão de "voltar ao topo" quando o [ScrollController] atinge determinado deslocamento.
///
/// Permite customizar o botão exibido e o comportamento de animação ao voltar.
class ScrollTopButtonWidget extends StatefulWidget {
  /// Controlador de rolagem que será monitorado.
  final ScrollController controller;

  /// Offset de scroll a partir do qual o botão será exibido.
  final double showOffset;

  /// Duração da animação de scroll até o topo.
  final Duration scrollDuration;

  /// Duração da animação de exibição do botão.
  final Duration fadeDuration;

  /// Widget do botão que será exibido.
  final Widget Function(BuildContext context) builder;

  const ScrollTopButtonWidget({
    super.key,
    required this.controller,
    required this.builder,
    this.showOffset = 10.0,
    this.scrollDuration = const Duration(milliseconds: 500),
    this.fadeDuration = const Duration(milliseconds: 300),
  });

  @override
  State<ScrollTopButtonWidget> createState() => _ScrollTopButtonWidgetState();
}

class _ScrollTopButtonWidgetState extends State<ScrollTopButtonWidget> {
  bool _show = false;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_onScroll);
  }

  void _onScroll() {
    final shouldShow = widget.controller.offset > widget.showOffset;
    if (_show != shouldShow) {
      setState(() => _show = shouldShow);
    }
  }

  void _scrollToTop() {
    widget.controller.animateTo(
      0,
      duration: widget.scrollDuration,
      curve: Curves.easeOut,
    );
  }

  @override
  void dispose() {
    widget.controller.removeListener(_onScroll);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: _show ? 1.0 : 0.0,
      duration: widget.fadeDuration,
      child: _show
          ? GestureDetector(
              onTap: _scrollToTop,
              child: widget.builder(context),
            )
          : const SizedBox.shrink(),
    );
  }
}
