import 'package:intl/intl.dart';

/// Utilitário para conversões de tipos numéricos, monetários e de datas.
///
/// Todas as operações utilizam o padrão brasileiro (`pt_BR`) por padrão.
///
/// Essa classe não pode ser instanciada.
class ConvertType {
  ConvertType._(); // Evitar instanciação

  /// Converte uma [String] representando um valor monetário (em Real) para [double].
  ///
  /// Remove símbolos como "R$", espaços e formatações locais antes da conversão.
  ///
  /// Retorna `0.0` se ocorrer erro na conversão.
  static double realToDouble(String real) {
    try {
      real = real
          .replaceAll(RegExp(r'[R$\s%]'), '')
          .replaceAll('.', '')
          .replaceAll(',', '.');
      return double.parse(real);
    } catch (e) {
      return 0.0;
    }
  }

  /// Converte um [double] para uma [String] formatada como porcentagem (ex: "25,00%").
  ///
  /// [includeSymbol] define se o símbolo `%` será incluído ou não na saída.
  static String doubleToPercent(double value, {bool includeSymbol = true}) {
    final NumberFormat formatter = NumberFormat.decimalPercentPattern(
      locale: 'pt_BR',
      decimalDigits: 2,
    );
    final String formatted = formatter.format(value / 100);
    return includeSymbol ? formatted : formatted.replaceAll('%', '').trim();
  }

  /// Converte um [double] para uma [String] formatada como moeda Real (ex: "R$ 1.234,56").
  ///
  /// [withSymbol] define se o símbolo `R$` será incluído na saída.
  static String doubleToReal(double value, {bool withSymbol = true}) {
    final NumberFormat currencyFormatter = NumberFormat.currency(
      locale: 'pt_BR',
      symbol: withSymbol ? 'R\$' : '',
      decimalDigits: 2,
    );
    return currencyFormatter.format(value).trim();
  }

  /// Formata uma [String] representando uma data (no padrão ISO) para um novo formato.
  ///
  /// [outputPattern] define o padrão de saída. O padrão padrão é `'dd/MM/yyyy'`.
  ///
  /// Retorna uma string vazia em caso de erro na conversão.
  static String formatDate(String date, {String outputPattern = 'dd/MM/yyyy'}) {
    try {
      final DateTime parsedDate = DateTime.parse(date);
      return DateFormat(outputPattern, 'pt_BR').format(parsedDate);
    } catch (e) {
      return '';
    }
  }

  /// Converte uma [String] no formato ISO para uma representação completa de data e hora.
  ///
  /// Retorna no formato `'dd/MM/yyyy HH:mm:ss'`.
  static String stringToDateTime(String date) {
    try {
      final DateTime parsedDate = DateTime.parse(date);
      return DateFormat('dd/MM/yyyy HH:mm:ss', 'pt_BR').format(parsedDate);
    } catch (e) {
      return '';
    }
  }

  /// Converte um objeto [DateTime] para uma [String] formatada.
  ///
  /// [pattern] define o padrão de formatação (ex: `'dd/MM/yyyy'`).
  static String dateTimeToString(
    DateTime date, {
    String pattern = 'dd/MM/yyyy',
  }) {
    return DateFormat(pattern, 'pt_BR').format(date);
  }

  /// Converte uma [String] em formato de data para um objeto [DateTime].
  ///
  /// [inputPattern] define o padrão esperado da string.
  ///
  /// Retorna `null` em caso de erro na conversão.
  static DateTime? stringToDate(
    String date, {
    String inputPattern = 'dd/MM/yyyy',
  }) {
    try {
      return DateFormat(inputPattern, 'pt_BR').parse(date);
    } catch (e) {
      return null;
    }
  }

  /// Formata um número [double] com separadores de milhar e casas decimais.
  ///
  /// [decimalDigits] define a quantidade de casas decimais (padrão é 2).
  static String formatNumber(double value, {int decimalDigits = 2}) {
    final formatter =
        NumberFormat.decimalPattern('pt_BR')
          ..minimumFractionDigits = decimalDigits
          ..maximumFractionDigits = decimalDigits;
    return formatter.format(value);
  }

  /// Remove todas as máscaras de um [String] (deixa apenas os números).
  ///
  /// Útil para limpar dados como CPF, CNPJ, telefones, valores monetários.
  static String removeMask(String value) {
    return value.replaceAll(RegExp(r'[^0-9]'), '');
  }
}
