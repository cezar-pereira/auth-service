import 'package:flutter_modular/flutter_modular.dart';
import 'package:login_service/app/core/guards/auth_guard.dart';
import 'package:login_service/app/modules/auth/auth_module.dart';
import 'package:login_service/app/modules/auth/external/drivers/auth_secure_storage.dart';
import 'package:login_service/app/modules/auth/infra/services/auth_service.dart';
import 'package:login_service/app/modules/home/home_module.dart';

class AppModule extends Module {
  @override
  final List<Bind> binds = [];

  @override
  final List<ModularRoute> routes = [
    ModuleRoute('/login/', module: AuthModule()),
    ModuleRoute('/home/', module: HomeModule()),
    ModuleRoute(
      Modular.initialRoute,
      module: HomeModule(),
      guards: [
        AuthGuard(service: AuthService(authDriver: AuthSecureStorage())),
      ],
    ),
  ];
}
