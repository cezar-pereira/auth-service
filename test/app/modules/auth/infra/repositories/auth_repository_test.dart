import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:login_service/app/core/error/failure.dart';
import 'package:login_service/app/modules/auth/domain/entities/token_entity.dart';
import 'package:login_service/app/modules/auth/domain/repositories/auth_repository_interface.dart';
import 'package:mocktail/mocktail.dart';

class AuthRepositoryMock extends Mock implements AuthRepositoryInterface {}

class ErrorMock extends Mock implements Failure {}

void main() {
  late final AuthRepositoryInterface repository;
  late final TokenEntity token;
  setUpAll(() {
    token = TokenEntity(token: '', tokenExpiration: DateTime.now());
    repository = AuthRepositoryMock();
  });

  test('Should return TokenEntity ', () async {
    when(() => repository.login(user: '', password: ''))
        .thenAnswer((_) async => Right(token));

    var result = await repository.login(user: '', password: '');
    expect(result, Right(token));
    verify(() => repository.login(user: '', password: '')).called(1);
  });

  test('Should return Failure', () async {
    var error = ErrorMock();
    when(() => repository.login(user: '', password: '')).thenThrow(error);
    expect(() => repository.login(user: '', password: ''),
        throwsA(isA<Failure>()));
    verify(() => repository.login(user: '', password: '')).called(1);
  });
}
