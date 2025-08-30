import 'package:flutter/material.dart';

/// Interface que define a estrutura de um layout de Loader (indicador de carregamento) no aplicativo.
///
/// Implementações dessa interface são responsáveis por construir o Widget visual exibido durante operações assíncronas.
/// Pode ser utilizada para personalizar globalmente o estilo do Loader no projeto.
abstract interface class LoaderLayout {
  /// Método responsável por construir o Widget do Loader.
  ///
  /// [context] é fornecido para que o layout possa utilizar temas, dimensões ou outros recursos do contexto.
  ///
  /// Retorna o Widget que será exibido como indicador de carregamento.
  Widget buildLoader(BuildContext context);
}
