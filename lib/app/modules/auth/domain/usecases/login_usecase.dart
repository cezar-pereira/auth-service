import 'package:dartz/dartz.dart';
import 'package:login_service/app/core/error/failure.dart';
import 'package:login_service/app/modules/auth/domain/entities/token_entity.dart';
import 'package:login_service/app/modules/auth/domain/repositories/auth_repository_interface.dart';
import 'package:login_service/app/modules/auth/domain/services/auth_service_interface.dart';

abstract class LoginUsecaseInterface {
  Future<Either<Failure, TokenEntity>> call(
      {required String user, required String password});
}

class LoginUsecase implements LoginUsecaseInterface {
  final AuthRepositoryInterface repository;
  final AuthServiceInterface serviceToken;

  LoginUsecase({required this.repository, required this.serviceToken});

  @override
  Future<Either<Failure, TokenEntity>> call(
      {required String user, required String password}) async {
    var result = await repository.login(user: user, password: password);

    result.fold((l) {}, (r) {
      serviceToken.saveToken(token: r);
    });
    return result;
  }
}
