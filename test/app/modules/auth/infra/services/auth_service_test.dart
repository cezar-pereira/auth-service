import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:login_service/app/modules/auth/domain/entities/token_entity.dart';
import 'package:login_service/app/modules/auth/domain/errors/auth_failures.dart';
import 'package:login_service/app/modules/auth/domain/services/auth_service_interface.dart';
import 'package:mocktail/mocktail.dart';

class AuthServiceMock extends Mock implements AuthServiceInterface {}

void main() {
  late final TokenEntity token;
  late final AuthServiceInterface service;
  setUpAll(() {
    token = TokenEntity(token: '', tokenExpiration: DateTime.now());
    service = AuthServiceMock();
  });

  group('saveToken', () {
    test('Should return a TRUE', () async {
      when(() => service.saveToken(token: token))
          .thenAnswer((_) async => const Right(true));
      var result = await service.saveToken(token: token);
      expect(result, const Right(true));
      verify(() => service.saveToken(token: token)).called(1);
    });

    test('Should return a ErrorSaveToken', () {
      ErrorSaveToken error = ErrorSaveToken.empty();
      when(() => service.saveToken(token: token)).thenThrow(error);
      expect(() => service.saveToken(token: token),
          throwsA(isA<ErrorSaveToken>()));
    });
  });

  group('getToken', () {
    test('Should return a TokenEntity', () async {
      when(() => service.getToken()).thenAnswer((_) async => Right(token));
      var result = await service.getToken();
      expect(result, Right(token));
      verify(() => service.getToken()).called(1);
    });

    test('Should return a ErrorGetToken', () {
      ErrorGetToken error = ErrorGetToken.empty();
      when(() => service.getToken()).thenThrow(error);
      expect(() => service.getToken(), throwsA(isA<ErrorGetToken>()));
    });
  });

  group('logout', () {
    test('Should return a true', () async {
      when(() => service.logout()).thenAnswer((_) async => const Right(true));
      var result = await service.logout();
      expect(result, const Right(true));
      verify(() => service.logout()).called(1);
    });

    test('Should return a ErrorLogout', () {
      ErrorLogout error = ErrorLogout.empty();
      when(() => service.getToken()).thenThrow(error);
      expect(() => service.getToken(), throwsA(isA<ErrorLogout>()));
    });
  });
}
