// ignore_for_file: avoid_renaming_method_parameters

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:login_service/app/modules/auth/domain/services/auth_service_interface.dart';

class AuthGuard extends RouteGuard {
  AuthGuard({required this.service}) : super(redirectTo: '/login/');

  final AuthServiceInterface service;

  @override
  Future<bool> canActivate(String path, ModularRoute router) async {
    var token = await service.getToken();

    return token.fold((error) {
      debugPrint(error.errorMessage);
      return false;
    }, (user) {
      return true;
    });
  }
}
