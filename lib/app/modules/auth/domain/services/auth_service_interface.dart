import 'package:dartz/dartz.dart';
import 'package:login_service/app/core/error/failure.dart';
import 'package:login_service/app/modules/auth/domain/entities/token_entity.dart';

abstract class AuthServiceInterface {
  Future<Either<Failure, bool>> saveToken({required TokenEntity token});
  Future<Either<Failure, TokenEntity>> getToken();
  Future<Either<Failure, bool>> logout();
}
