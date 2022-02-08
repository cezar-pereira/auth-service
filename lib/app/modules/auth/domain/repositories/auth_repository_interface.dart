import 'package:dartz/dartz.dart';
import 'package:login_service/app/core/error/failure.dart';
import 'package:login_service/app/modules/auth/domain/entities/token_entity.dart';

abstract class AuthRepositoryInterface {
  Future<Either<Failure, TokenEntity>> login(
      {required String user, required String password});
}
