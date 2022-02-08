import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:login_service/app/modules/auth/domain/errors/auth_failures.dart';
import 'package:login_service/app/modules/auth/domain/services/auth_service_interface.dart';
import 'package:login_service/app/modules/auth/domain/usecases/logout_usecasae.dart';
import 'package:mocktail/mocktail.dart';

class AuthServiceMock extends Mock implements AuthServiceInterface {}

void main() {
  late final AuthServiceInterface service;
  late final LogoutUsecaseInterface usecase;

  setUpAll(() {
    service = AuthServiceMock();
    usecase = LogoutUsecase(serviceToken: service);
  });

  test('Should return TRUE', () async {
    when(() => service.logout()).thenAnswer((_) async => const Right(true));
    var result = await usecase();
    expect(result, const Right(true));
    verify(() => service.logout()).called(1);
  });
  test('Should return ErrorLogout', () async {
    final error = ErrorLogout.empty();
    when(() => service.logout()).thenAnswer((_) async => Left(error));
    var result = await usecase();
    expect(result, Left(error));
    verify(() => service.logout()).called(1);
  });
}
