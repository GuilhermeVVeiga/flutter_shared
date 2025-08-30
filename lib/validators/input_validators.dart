import '../utils/string_utils.dart';

/// Validações para entradas de dados comuns.
class InputValidators {
  /// Valida se o [email] é válido.
  static bool isValidEmail(String email) {
    return StringUtils.isEmailValid(email);
  }

  /// Valida se o [cpf] é válido.
  static bool isValidCPF(String cpf) {
    return StringUtils.isCPFValid(cpf);
  }

  /// Valida se o [cnpj] é válido.
  static bool isValidCNPJ(String cnpj) {
    return StringUtils.isCNPJValid(cnpj);
  }

  /// Valida se o [phone] é válido.
  static bool isValidPhone(String phone) {
    return StringUtils.isPhoneValid(phone);
  }

  /// Valida se o [password] atende critérios básicos.
  ///
  /// Ex: mínimo de 6 caracteres.
  static bool isValidPassword(String password, {int minLength = 6}) {
    return password.trim().length >= minLength;
  }

  /// Valida se o [text] não é vazio ou apenas espaços.
  static bool isRequired(String text) {
    return text.trim().isNotEmpty;
  }
}
