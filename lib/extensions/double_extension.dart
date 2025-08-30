import 'package:intl/intl.dart';

/// Extensão para [double] que adiciona formatação de moeda, número e percentual.
extension DoubleExtension on double? {
  /// Converte o valor para uma [String] formatada como moeda brasileira.
  ///
  /// Exemplo:
  /// ```dart
  /// 1234.56.toReal(); // R$ 1.234,56
  /// 1234.56.toReal(withSymbol: false); // 1.234,56
  /// ```
  ///
  /// Se o valor for `null`, retorna `"R$ 0,00"` (ou `"0,00"` se [withSymbol] for `false`).
  String toReal({bool withSymbol = true}) {
    final value = this ?? 0.0;
    final formatter = NumberFormat.currency(
      locale: 'pt_BR',
      symbol: withSymbol ? 'R\$' : '',
      decimalDigits: 2,
    );
    return formatter.format(value).trim();
  }

  /// Converte o valor para uma [String] com separadores e casas decimais.
  ///
  /// Exemplo:
  /// ```dart
  /// 1234.56.toFormattedNumber(); // 1.234,56
  /// ```
  String toFormattedNumber({int decimalDigits = 2}) {
    final value = this ?? 0.0;
    final formatter = NumberFormat.decimalPattern('pt_BR')
      ..minimumFractionDigits = decimalDigits
      ..maximumFractionDigits = decimalDigits;
    return formatter.format(value);
  }

  /// Converte o valor para uma [String] formatada como percentual brasileiro.
  ///
  /// Exemplo:
  /// ```dart
  /// 25.0.toPercent();     // % 25,00
  /// 12.5.toPercent();     // % 12,50
  /// null.toPercent();     // % 0,00
  /// ```
  String toPercent() {
    final value = this ?? 0.0;
    final formatter = NumberFormat('#,##0.00', 'pt_BR');
    return '% ${formatter.format(value)}';
  }
}
