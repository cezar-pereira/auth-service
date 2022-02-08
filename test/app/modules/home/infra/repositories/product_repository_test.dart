import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:login_service/app/core/error/failure.dart';
import 'package:login_service/app/modules/home/domain/entities/product_entity.dart';
import 'package:login_service/app/modules/home/domain/repositories/product_reposity.dart';
import 'package:mocktail/mocktail.dart';

class ProductRepositoryMock extends Mock implements ProductRepositoryInterface {
}

class ErrorMock extends Mock implements Failure {}

void main() {
  late final ProductRepositoryInterface repository;
  setUpAll(() {
    repository = ProductRepositoryMock();
  });

  group('fetchProducts:', () {
    test('Should return a List<ProductEntity>', () async {
      List<ProductEntity> list = [];
      when(() => repository.fetchProducts())
          .thenAnswer((_) async => Right(list));
      var result = await repository.fetchProducts();
      expect(result, Right(list));
      verify(() => repository.fetchProducts()).called(1);
    });
    test('Should return a Failure', () async {
      var error = ErrorMock();
      when(() => repository.fetchProducts())
          .thenAnswer((_) async => Left(error));
      var result = await repository.fetchProducts();
      expect(result, Left(error));
      verify(() => repository.fetchProducts()).called(1);
    });
  });
}
