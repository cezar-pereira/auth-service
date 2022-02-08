import 'package:flutter_test/flutter_test.dart';
import 'package:login_service/app/modules/auth/domain/entities/token_entity.dart';
import 'package:login_service/app/modules/auth/domain/errors/auth_failures.dart';
import 'package:login_service/app/modules/auth/infra/drivers/auth_driver_interface.dart';
import 'package:mocktail/mocktail.dart';

class AuthDriverMock extends Mock implements AuthDriverInterface {}

void main() {
  late final TokenEntity token;
  late final AuthDriverInterface authStorage;
  setUpAll(() {
    token = TokenEntity(token: '', tokenExpiration: DateTime.now());
    authStorage = AuthDriverMock();
  });

  group('saveToken', () {
    test('Should return a TRUE', () async {
      when(() => authStorage.saveToken(token: token))
          .thenAnswer((_) async => true);
      var result = await authStorage.saveToken(token: token);
      expect(result, true);
      verify(() => authStorage.saveToken(token: token)).called(1);
    });

    test('Should return a ErrorSaveToken', () {
      ErrorSaveToken error = ErrorSaveToken.empty();
      when(() => authStorage.saveToken(token: token)).thenThrow(error);
      expect(() => authStorage.saveToken(token: token),
          throwsA(isA<ErrorSaveToken>()));
    });
  });

  group('getToken', () {
    test('Should return a TokenEntity', () async {
      when(() => authStorage.getToken()).thenAnswer((_) async => token);
      var result = await authStorage.getToken();
      expect(result, token);
      verify(() => authStorage.getToken()).called(1);
    });

    test('Should return a ErrorGetToken', () {
      ErrorGetToken error = ErrorGetToken.empty();
      when(() => authStorage.getToken()).thenThrow(error);
      expect(() => authStorage.getToken(), throwsA(isA<ErrorGetToken>()));
    });
  });

  group('logout', () {
    test('Should return a true', () async {
      when(() => authStorage.logout()).thenAnswer((_) async => true);
      var result = await authStorage.logout();
      expect(result, true);
      verify(() => authStorage.logout()).called(1);
    });

    test('Should return a ErrorLogout', () {
      ErrorLogout error = ErrorLogout.empty();
      when(() => authStorage.getToken()).thenThrow(error);
      expect(() => authStorage.getToken(), throwsA(isA<ErrorLogout>()));
    });
  });
}
