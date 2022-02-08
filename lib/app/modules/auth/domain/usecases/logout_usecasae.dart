import 'package:dartz/dartz.dart';
import 'package:login_service/app/core/error/failure.dart';
import 'package:login_service/app/modules/auth/domain/services/auth_service_interface.dart';

abstract class LogoutUsecaseInterface {
  Future<Either<Failure, bool>> call();
}

class LogoutUsecase implements LogoutUsecaseInterface {
  final AuthServiceInterface serviceToken;

  LogoutUsecase({required this.serviceToken});

  @override
  Future<Either<Failure, bool>> call() async {
    return serviceToken.logout();
  }
}
