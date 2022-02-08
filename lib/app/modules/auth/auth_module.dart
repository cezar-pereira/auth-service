import 'package:flutter_modular/flutter_modular.dart';
import 'package:login_service/app/modules/auth/domain/usecases/login_usecase.dart';
import 'package:login_service/app/modules/auth/external/datasources/auth_dio.dart';
import 'package:login_service/app/modules/auth/external/drivers/auth_secure_storage.dart';
import 'package:login_service/app/modules/auth/infra/repositories/auth_repository.dart';
import 'package:login_service/app/modules/auth/infra/services/auth_service.dart';
import 'package:login_service/app/modules/auth/presenter/auth_page.dart';
import 'package:login_service/app/modules/auth/presenter/auth_store.dart';

import 'domain/repositories/auth_repository_interface.dart';
import 'domain/services/auth_service_interface.dart';
import 'infra/datasources/auth_datasource.dart';
import 'infra/drivers/auth_driver_interface.dart';

class AuthModule extends Module {
  @override
  final List<Bind> binds = [
    /*** STORE ***/
    Bind.lazySingleton(
        (i) => AuthStore(usecase: i.get<LoginUsecaseInterface>())),

    /*** DATASOURCES  ***/
    Bind.lazySingleton((i) => AuthDio()),

    /*** DRIVERS  ***/
    Bind.lazySingleton((i) => AuthSecureStorage()),

    /*** REPOSITORIES  ***/
    Bind.lazySingleton(
        (i) => AuthRepository(datasource: i.get<AuthDatasourceInterface>())),

    /*** SERVICES  ***/
    Bind.lazySingleton(
        (i) => AuthService(authDriver: i.get<AuthDriverInterface>())),

    /*** USECASES  ***/
    Bind.lazySingleton((i) => LoginUsecase(
        repository: i.get<AuthRepositoryInterface>(),
        serviceToken: i.get<AuthServiceInterface>())),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(Modular.initialRoute, child: (_, args) => const AuthPage()),
  ];
}
