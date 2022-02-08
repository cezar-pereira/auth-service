import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:login_service/app/modules/auth/domain/entities/token_entity.dart';
import 'package:login_service/app/modules/auth/domain/errors/auth_failures.dart';
import 'package:login_service/app/modules/auth/infra/drivers/auth_driver_interface.dart';

class AuthSecureStorage implements AuthDriverInterface {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();
  final String _keyToken = 'token';
  final String _keyTokenExpiration = 'tokenExpiration';
  @override
  Future<bool> saveToken({required TokenEntity token}) async {
    try {
      await _storage.write(key: _keyToken, value: token.token);
      await _storage.write(
          key: _keyTokenExpiration, value: token.tokenExpiration.toString());
      return true;
    } catch (exception, stacktrace) {
      throw ErrorSaveToken(stacktrace, 'AuthSecureStorage-saveToken', exception,
          exception.toString());
    }
  }

  @override
  Future<TokenEntity> getToken() async {
    try {
      String? valueToken = await _storage.read(key: _keyToken);
      String? valueTokenExpiration =
          await _storage.read(key: _keyTokenExpiration);

      if (valueToken == null || valueTokenExpiration == null) {
        throw ErrorNotExistToken();
      }

      return TokenEntity(
          token: valueToken,
          tokenExpiration: DateTime.parse(valueTokenExpiration));
    } catch (exception, stacktrace) {
      throw ErrorGetToken(stacktrace, 'AuthSecureStorage-getToken', exception,
          exception.toString());
    }
  }

  @override
  Future<bool> logout() async {
    try {
      await _storage.delete(key: _keyToken);
      await _storage.delete(key: _keyTokenExpiration);
      return true;
    } catch (exception, stacktrace) {
      throw ErrorLogout(stacktrace, 'AuthSecureStorage-logout', exception,
          exception.toString());
    }
  }
}
