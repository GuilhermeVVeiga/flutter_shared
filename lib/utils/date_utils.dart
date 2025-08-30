/// Utilitário para operações adicionais com datas.
///
/// Contém métodos estáticos para facilitar manipulações comuns de [DateTime].
class DateUtilsCustom {
  /// Adiciona uma quantidade de [days] ao [date] fornecido.
  ///
  /// [date]: Data base para o cálculo.
  /// [days]: Quantidade de dias a adicionar (pode ser negativo para subtrair).
  ///
  /// Retorna um novo objeto [DateTime] com a alteração aplicada.
  ///
  /// Exemplo:
  /// ```dart
  /// final hoje = DateTime.now();
  /// final amanha = DateUtilsCustom.addDays(hoje, 1);
  /// ```
  static DateTime addDays(DateTime date, int days) {
    return date.add(Duration(days: days));
  }
}
