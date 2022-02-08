import 'package:login_service/app/modules/auth/domain/entities/token_entity.dart';

abstract class AuthDriverInterface {
  Future<bool> saveToken({required TokenEntity token});
  Future<TokenEntity> getToken();
  Future<bool> logout();
}
