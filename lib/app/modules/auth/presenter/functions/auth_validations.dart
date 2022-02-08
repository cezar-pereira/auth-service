class AuthValidations {
  String? user(String value) => value.length >= 5 ? null : 'Usuário inválido.';
  String? pass(String value) => value.length >= 5 ? null : 'Sennha inválida.';
}
