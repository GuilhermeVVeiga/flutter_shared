import 'package:intl/intl.dart';

/// Extensão para [String] que adiciona utilitários comuns.
///
/// Permite verificar se a string é nula ou vazia,
/// além de capitalizar a primeira letra e definir valor padrão.
extension StringExtension on String? {
  /// Verifica se a string é `null` ou está vazia (após remover espaços em branco).
  ///
  /// Retorna `true` se [this] for `null` ou contiver apenas espaços.
  ///
  /// Exemplo:
  /// ```dart
  /// String? text = '';
  /// print(text.isNullOrEmpty); // true
  /// ```
  bool get isNullOrEmpty => this == null || this!.trim().isEmpty;

  /// Capitaliza a primeira letra da string.
  ///
  /// Se [this] for `null` ou vazia, retorna uma string vazia.
  ///
  /// Exemplo:
  /// ```dart
  /// String? text = 'flutter';
  /// print(text.capitalize()); // Flutter
  /// ```
  String capitalize() {
    if (this == null || this!.isEmpty) return '';
    return this![0].toUpperCase() + this!.substring(1);
  }

  /// Retorna o próprio valor da string, ou um [defaultValue] se [this] for `null` ou vazia.
  ///
  /// Exemplo:
  /// ```dart
  /// String? message;
  /// print(message.orElse('Mensagem padrão')); // Mensagem padrão
  /// ```
  String orElse(String defaultValue) {
    if (isNullOrEmpty) {
      return defaultValue;
    }
    return this!;
  }

  /// Converte uma [String] monetária brasileira em [double].
  ///
  /// Remove símbolos como `R$`, `%`, espaços e converte separadores
  /// decimais de vírgula para ponto.
  ///
  /// Exemplo:
  /// ```dart
  /// StringUtils.realToDouble('R\$ 1.234,56') // retorna 1234.56
  /// ```
  double realToDouble() {
    if (this == null) return 0.0;

    final String cleaned = this!
        .replaceAll(RegExp(r'[R$\s%]'), '')
        .replaceAll('.', '')
        .replaceAll(',', '.');

    return double.tryParse(cleaned) ?? 0.0;
  }

  /// Converte uma [String] representando uma data ISO (`yyyy-MM-dd`) para o formato `'dd/MM/yyyy'`.
  ///
  /// Retorna uma string vazia se a data for inválida ou `null`.
  ///
  /// Exemplo:
  /// ```dart
  /// '2024-05-03'.formatDate(); // 03/05/2024
  /// null.formatDate();         // ''
  /// 'abc'.formatDate();        // ''
  /// ```
  String formatDate({String outputPattern = 'dd/MM/yyyy'}) {
    if (this == null) return '';
    try {
      final date = DateTime.parse(this!);
      return DateFormat(outputPattern, 'pt_BR').format(date);
    } catch (_) {
      return '';
    }
  }
}
