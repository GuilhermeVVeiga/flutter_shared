/// Helper para utilidades relacionadas a tempo.
///
/// Esta classe oferece funções utilitárias para conversão e formatação
/// de valores de tempo, facilitando a exibição amigável de segundos em formatos compreensíveis.
///
/// Exemplo de uso:
/// ```dart
/// final formatado = TimeUtils.formatSeconds(125);
/// print(formatado); // Saída: 02:05
/// ```
class TimeUtils {
  /// Converte um valor em segundos para o formato `MM:SS`.
  ///
  /// - `MM` representa os minutos, preenchido com zero à esquerda caso necessário.
  /// - `SS` representa os segundos restantes, também preenchidos com zero à esquerda.
  ///
  /// Exemplos:
  /// ```dart
  /// TimeUtils.formatSeconds(125); // Retorna "02:05"
  /// TimeUtils.formatSeconds(59);  // Retorna "00:59"
  /// TimeUtils.formatSeconds(0);   // Retorna "00:00"
  /// ```
  ///
  /// [seconds] O total de segundos a ser convertido.
  ///
  /// Retorna uma [String] formatada no padrão `MM:SS`.
  static String formatSeconds(int seconds) {
    final int minutes = seconds ~/ 60;
    final int remainingSeconds = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }
}
