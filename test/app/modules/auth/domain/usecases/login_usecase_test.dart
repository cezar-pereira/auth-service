import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:login_service/app/modules/auth/domain/entities/token_entity.dart';
import 'package:login_service/app/modules/auth/domain/errors/auth_failures.dart';
import 'package:login_service/app/modules/auth/domain/repositories/auth_repository_interface.dart';
import 'package:login_service/app/modules/auth/domain/services/auth_service_interface.dart';
import 'package:login_service/app/modules/auth/domain/usecases/login_usecase.dart';
import 'package:mocktail/mocktail.dart';

class AuthRepositoryMock extends Mock implements AuthRepositoryInterface {}

class AuthServiceMock extends Mock implements AuthServiceInterface {}

void main() {
  late final LoginUsecaseInterface usecase;
  late final AuthRepositoryInterface repository;
  late final AuthServiceInterface service;

  setUpAll(() {
    repository = AuthRepositoryMock();
    service = AuthServiceMock();
    usecase = LoginUsecase(repository: repository, serviceToken: service);
  });

  test('Should return TokenEntity', () async {
    final token = TokenEntity(token: 'x', tokenExpiration: DateTime.now());
    when(() => service.saveToken(token: token))
        .thenAnswer((__) async => const Right(true));
    when(() => repository.login(user: '', password: ''))
        .thenAnswer((_) async => Right(token));

    var result = await usecase(user: '', password: '');
    expect(result, Right(token));
    verify(() => repository.login(user: '', password: '')).called(1);
  });

  test('Should return ErrorSaveToken', () async {
    final ErrorSaveToken error = ErrorSaveToken.empty();
    final token = TokenEntity(token: 'x', tokenExpiration: DateTime.now());

    when(() => service.saveToken(token: token))
        .thenAnswer((_) async => Left(error));
    when(() => repository.login(user: '', password: ''))
        .thenAnswer((_) async => Left(error));

    var result = await usecase(user: '', password: '');
    expect(result, Left(error));
    verify(() => repository.login(user: '', password: '')).called(1);
  });

  test('Should return ErrorLogin', () async {
    final ErrorLogin error = ErrorLogin();
    final token = TokenEntity(token: 'x', tokenExpiration: DateTime.now());
    when(() => service.saveToken(token: token))
        .thenAnswer((_) async => Left(error));
    when(() => repository.login(user: '', password: ''))
        .thenAnswer((_) async => Left(error));

    var result = await usecase(user: '', password: '');
    expect(result, Left(error));
    verify(() => repository.login(user: '', password: '')).called(1);
  });
}
