import 'package:login_service/app/modules/auth/domain/entities/token_entity.dart';
import 'package:login_service/app/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:login_service/app/modules/auth/domain/repositories/auth_repository_interface.dart';
import 'package:login_service/app/modules/auth/infra/datasources/auth_datasource.dart';

class AuthRepository implements AuthRepositoryInterface {
  final AuthDatasourceInterface _datasource;

  AuthRepository({required AuthDatasourceInterface datasource})
      : _datasource = datasource;

  @override
  Future<Either<Failure, TokenEntity>> login(
      {required String user, required String password}) async {
    try {
      var result = await _datasource.login(user: user, password: password);
      return Right(result);
    } on Failure catch (e) {
      return Left(e);
    }
  }
}
