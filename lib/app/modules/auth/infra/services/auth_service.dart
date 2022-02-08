import 'package:login_service/app/modules/auth/domain/entities/token_entity.dart';
import 'package:login_service/app/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:login_service/app/modules/auth/domain/services/auth_service_interface.dart';
import 'package:login_service/app/modules/auth/infra/drivers/auth_driver_interface.dart';

class AuthService implements AuthServiceInterface {
  final AuthDriverInterface _authDriver;

  AuthService({required AuthDriverInterface authDriver})
      : _authDriver = authDriver;

  @override
  Future<Either<Failure, bool>> saveToken({required TokenEntity token}) async {
    try {
      var result = await _authDriver.saveToken(token: token);
      return Right(result);
    } on Failure catch (e) {
      return Left(e);
    } catch (exception, stacktrace) {
      return Left(UnknownError(
          exception: exception,
          stackTrace: stacktrace,
          label: 'AuthService-saveToken'));
    }
  }

  @override
  Future<Either<Failure, TokenEntity>> getToken() async {
    try {
      var result = await _authDriver.getToken();

      if (result.tokenExpiration.isAfter(DateTime.now())) {
        return Right(result);
      } else {
        return throw (ErrorExpirationToken());
      }
    } on Failure catch (e) {
      return Left(e);
    } catch (exception, stacktrace) {
      return Left(UnknownError(
          exception: exception,
          stackTrace: stacktrace,
          label: 'AuthService-getToken'));
    }
  }

  @override
  Future<Either<Failure, bool>> logout() async {
    try {
      var result = await _authDriver.logout();
      return Right(result);
    } on Failure catch (e) {
      return Left(e);
    } catch (exception, stacktrace) {
      return Left(UnknownError(
          exception: exception,
          stackTrace: stacktrace,
          label: 'AuthService-logout'));
    }
  }
}
