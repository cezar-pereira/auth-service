import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:login_service/app/core/error/failure.dart';
import 'package:login_service/app/modules/auth/domain/entities/token_entity.dart';
import 'package:login_service/app/modules/auth/infra/datasources/auth_datasource.dart';
import 'package:mocktail/mocktail.dart';

class AuthDatasourceMock extends Mock implements AuthDatasourceInterface {}

class MockClient extends Mock implements Dio {}

class ErrorMock extends Mock implements Failure {}

void main() {
  late final AuthDatasourceInterface datasource;

  setUpAll(() {
    datasource = AuthDatasourceMock();
  });
  test('Should return TokenEntity', () async {
    var token = TokenEntity(token: '', tokenExpiration: DateTime.now());
    when(() => datasource.login(user: '', password: ''))
        .thenAnswer((_) async => token);

    var result = await datasource.login(user: '', password: '');
    expect(result, token);
    verify(() => datasource.login(user: '', password: '')).called(1);
  });

  test('Should return Failure', () async {
    var error = ErrorMock();
    when(() => datasource.login(user: '', password: '')).thenThrow(error);
    expect(() => datasource.login(user: '', password: ''),
        throwsA(isA<Failure>()));
    verify(() => datasource.login(user: '', password: '')).called(1);
  });
}
