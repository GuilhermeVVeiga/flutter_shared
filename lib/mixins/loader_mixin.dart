import 'package:flutter/material.dart';
import '../interfaces/loader_layout.dart';

/// Mixin que fornece funcionalidades de exibição e ocultação de um Loader (indicador de carregamento) no aplicativo.
///
/// Permite mostrar e esconder loaders reutilizando a estrutura padronizada do projeto.
/// O layout do loader pode ser personalizado sobrescrevendo o [LoaderLayout] utilizado.
///
/// Esta versão usa [OverlayEntry] ao invés de [showDialog],
/// tornando o Loader independente da árvore de navegação, funcionando em qualquer contexto da aplicação.
mixin LoaderMixin<T extends StatefulWidget> on State<T> {
  /// Indica se o Loader atualmente está sendo exibido.
  bool _isLoaderOpen = false;

  /// Referência ao OverlayEntry utilizado para exibir o Loader.
  OverlayEntry? _overlayEntry;

  /// Fornece a instância de [LoaderLayout] que constrói o Loader.
  ///
  /// Pode ser sobrescrito para personalizar a aparência do Loader globalmente.
  LoaderLayout get loaderLayout => DefaultLoaderLayout.instance;

  /// Exibe o Loader na tela, bloqueando interação com a interface.
  ///
  /// Se o Loader já estiver visível, o método não faz nada.
  void showLoader() {
    if (_isLoaderOpen) return;
    _overlayEntry = _createOverlay();
    Overlay.of(context, rootOverlay: true).insert(_overlayEntry!);
    _isLoaderOpen = true;
  }

  /// Esconde o Loader atualmente visível na tela.
  ///
  /// Se nenhum Loader estiver visível, o método não faz nada.
  void hideLoader() {
    if (!_isLoaderOpen) return;
    _overlayEntry?.remove();
    _overlayEntry = null;
    _isLoaderOpen = false;
  }

  /// Cria a instância do [OverlayEntry] que será exibida como Loader.
  ///
  /// Este método pode ser sobrescrito para fornecer um comportamento customizado
  /// ao Overlay, como animações ou diferentes estilos de background.
  OverlayEntry _createOverlay() {
    return OverlayEntry(
      builder:
          (context) => Stack(
            children: [
              ModalBarrier(
                dismissible: false,
                color: Colors.black.withAlpha((0.3 * 255).toInt()),
              ),
              Center(child: loaderLayout.buildLoader(context)),
            ],
          ),
    );
  }
}

/// Implementação padrão de [LoaderLayout], utilizada caso nenhum layout personalizado seja fornecido.
///
/// Exibe um [CircularProgressIndicator] centralizado.
class DefaultLoaderLayout implements LoaderLayout {
  /// Instância singleton padrão do Loader.
  static final DefaultLoaderLayout instance = DefaultLoaderLayout._();

  /// Construtor privado para garantir singleton.
  DefaultLoaderLayout._();

  @override
  Widget buildLoader(BuildContext context) {
    return const SizedBox(
      height: 60,
      width: 60,
      child: CircularProgressIndicator(strokeWidth: 6),
    );
  }
}
