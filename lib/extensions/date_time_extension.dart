import 'package:intl/intl.dart';

/// Extensão de [DateTime] para facilitar a formatação de datas.
///
/// Permite converter objetos [DateTime] em [String] utilizando padrões personalizados.
extension DateTimeExtension on DateTime {
  /// Formata a data atual para uma [String] baseada no [pattern] informado.
  ///
  /// O padrão padrão é `'dd/MM/yyyy'`, usando a localização 'pt_BR' (Português - Brasil).
  ///
  /// Exemplo:
  /// ```dart
  /// DateTime.now().format(); // 25/04/2025
  /// DateTime.now().format(pattern: 'yyyy-MM-dd'); // 2025-04-25
  /// ```
  ///
  /// [pattern]: Um formato válido para [DateFormat].
  String format({String pattern = 'dd/MM/yyyy'}) {
    return DateFormat(pattern, 'pt_BR').format(this);
  }
}

extension NullableDateTimeExtension on DateTime? {
  /// Formata [DateTime?] (pode ser nulo).
  /// Se nulo, retorna uma [String] vazia.
  String formatOrEmpty({String pattern = 'dd/MM/yyyy'}) {
    if (this == null) return '';
    return DateFormat(pattern, 'pt_BR').format(this!);
  }
}