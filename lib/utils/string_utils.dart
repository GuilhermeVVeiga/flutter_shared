/// Utilitário para operações e validações relacionadas a [String].
///
/// Contém métodos estáticos úteis para validar, formatar e extrair dados de texto.
class StringUtils {
  /// Verifica se um [email] é válido.
  static bool isEmailValid(String email) {
    final regex = RegExp(r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$');
    return regex.hasMatch(email);
  }

  /// Remove todos os caracteres que não sejam números da [text].
  ///
  /// Útil para limpar CPFs, CNPJs, telefones, etc.
  static String onlyNumbers(String text) {
    return text.replaceAll(RegExp(r'[^0-9]'), '');
  }

  /// Verifica se o [cpf] é válido conforme regras oficiais.
  ///
  /// Aceita CPFs formatados ou não (com pontos e traços).
  static bool isCPFValid(String cpf) {
    cpf = onlyNumbers(cpf);

    if (cpf.length != 11 || RegExp(r'^(\d)\1{10}$').hasMatch(cpf)) {
      return false;
    }

    final List<int> digits = cpf.split('').map(int.parse).toList();

    int calcVerifyingDigit(List<int> digits, int length) {
      int sum = 0;
      for (int i = 0; i < length; i++) {
        sum += digits[i] * ((length + 1) - i);
      }
      final int mod = sum % 11;
      return (mod < 2) ? 0 : 11 - mod;
    }

    final int d1 = calcVerifyingDigit(digits, 9);
    final int d2 = calcVerifyingDigit(digits, 10);

    return d1 == digits[9] && d2 == digits[10];
  }

  /// Verifica se o [cnpj] é válido conforme regras oficiais.
  ///
  /// Aceita CNPJs formatados ou não (com pontos, barra e hífen).
  static bool isCNPJValid(String cnpj) {
    cnpj = onlyNumbers(cnpj);

    if (cnpj.length != 14 || RegExp(r'^(\d)\1{13}$').hasMatch(cnpj)) {
      return false;
    }

    final List<int> digits = cnpj.split('').map(int.parse).toList();

    int calcVerifyingDigit(List<int> digits, List<int> weights) {
      int sum = 0;
      for (int i = 0; i < weights.length; i++) {
        sum += digits[i] * weights[i];
      }
      final int mod = sum % 11;
      return (mod < 2) ? 0 : 11 - mod;
    }

    final List<int> weights1 = [5, 4, 3, 2, 9, 8, 7, 6, 5, 4, 3, 2];
    final List<int> weights2 = [6, 5, 4, 3, 2, 9, 8, 7, 6, 5, 4, 3, 2];

    final int d1 = calcVerifyingDigit(digits, weights1);
    final int d2 = calcVerifyingDigit(digits, weights2);

    return d1 == digits[12] && d2 == digits[13];
  }

  /// Verifica se o [phone] é válido (9 ou 11 dígitos).
  ///
  /// Útil para validar telefones celulares brasileiros.
  static bool isPhoneValid(String phone) {
    final cleaned = onlyNumbers(phone);
    return cleaned.length == 10 || cleaned.length == 11;
  }

  /// Aplica máscara de CPF no [cpf] informado.
  ///
  /// Exemplo de saída: `123.456.789-00`
  static String maskCPF(String cpf) {
    final numbers = onlyNumbers(cpf);
    if (numbers.length != 11) return cpf;
    return '${numbers.substring(0, 3)}.${numbers.substring(3, 6)}.${numbers.substring(6, 9)}-${numbers.substring(9, 11)}';
  }

  /// Aplica máscara de CNPJ no [cnpj] informado.
  ///
  /// Exemplo de saída: `12.345.678/0001-99`
  static String maskCNPJ(String cnpj) {
    final numbers = onlyNumbers(cnpj);
    if (numbers.length != 14) return cnpj;
    return '${numbers.substring(0, 2)}.${numbers.substring(2, 5)}.${numbers.substring(5, 8)}/${numbers.substring(8, 12)}-${numbers.substring(12, 14)}';
  }
}
