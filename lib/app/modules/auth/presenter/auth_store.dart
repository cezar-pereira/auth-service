import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:login_service/app/core/error/failure.dart';
import 'package:login_service/app/modules/auth/domain/entities/token_entity.dart';
import 'package:login_service/app/modules/auth/domain/usecases/login_usecase.dart';

class AuthStore {
  final LoginUsecaseInterface usecase;
  AuthStore({required this.usecase});

  final controllerUser = TextEditingController();
  final controllerPassword = TextEditingController();

  Future<Either<Failure, TokenEntity>> login() async {
    return await usecase(
        user: controllerUser.text, password: controllerPassword.text);
  }
}
