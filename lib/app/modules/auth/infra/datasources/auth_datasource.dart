import 'package:login_service/app/modules/auth/domain/entities/token_entity.dart';

abstract class AuthDatasourceInterface {
  Future<TokenEntity> login({required String user, required String password});
}
