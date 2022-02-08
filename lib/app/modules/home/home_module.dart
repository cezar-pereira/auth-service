import 'package:flutter_modular/flutter_modular.dart';
import 'package:login_service/app/modules/auth/domain/services/auth_service_interface.dart';
import 'package:login_service/app/modules/auth/domain/usecases/logout_usecasae.dart';
import 'package:login_service/app/modules/auth/external/drivers/auth_secure_storage.dart';
import 'package:login_service/app/modules/auth/infra/drivers/auth_driver_interface.dart';
import 'package:login_service/app/modules/auth/infra/services/auth_service.dart';
import 'package:login_service/app/modules/home/domain/repositories/product_reposity.dart';
import 'package:login_service/app/modules/home/external/datasources/product_dio.dart';
import 'package:login_service/app/modules/home/infra/datasources/product_datasource.dart';
import 'package:login_service/app/modules/home/infra/repositories/product_repository.dart';
import 'package:login_service/app/modules/home/presenter/home_store.dart';

import 'domain/usecases/fetch_products_usecase.dart';
import 'presenter/home_page.dart';

class HomeModule extends Module {
  @override
  final List<Bind> binds = [
    /*** STORE ***/
    Bind.lazySingleton((i) => HomeStore(
        logoutUsecase: i.get<LogoutUsecaseInterface>(),
        fetchProductsUsecase: i.get<FetchProductsUsecaseInterface>())),

    /*** DRIVERS  ***/
    Bind.lazySingleton((i) => AuthSecureStorage()),
    /*** DATASOURCE  ***/
    Bind.lazySingleton(
        (i) => ProductDio(service: i.get<AuthServiceInterface>())),

    /*** REPOSITORIES  ***/

    Bind.lazySingleton((i) =>
        ProductRrepository(datasource: i.get<ProductDatasourceInterface>())),

    /*** SERVICES  ***/
    Bind.lazySingleton(
        (i) => AuthService(authDriver: i.get<AuthDriverInterface>()),
        export: true),

    /*** USECASES  ***/
    Bind.lazySingleton(
        (i) => LogoutUsecase(serviceToken: i.get<AuthServiceInterface>()),
        export: true),
    Bind.lazySingleton((i) =>
        FetchProductsUsecase(repository: i.get<ProductRepositoryInterface>()))
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(Modular.initialRoute, child: (_, args) => const HomePage()),
  ];
}
