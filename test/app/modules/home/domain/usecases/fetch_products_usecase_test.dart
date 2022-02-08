import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:login_service/app/core/error/failure.dart';
import 'package:login_service/app/modules/home/domain/entities/product_entity.dart';
import 'package:login_service/app/modules/home/domain/repositories/product_reposity.dart';
import 'package:login_service/app/modules/home/domain/usecases/fetch_products_usecase.dart';
import 'package:mocktail/mocktail.dart';

class ProductRepositoryMock extends Mock implements ProductRepositoryInterface {
}

class ErrorMock extends Mock implements Failure {}

void main() {
  late final ProductRepositoryInterface repository;
  late final FetchProductsUsecaseInterface useCase;

  setUpAll(() {
    repository = ProductRepositoryMock();
    useCase = FetchProductsUsecase(repository: repository);
  });

  test('Should return List<ProductEntity>', () async {
    List<ProductEntity> list = [];
    when(() => repository.fetchProducts()).thenAnswer((_) async => Right(list));
    var result = await useCase();
    expect(result, Right(list));
    verify(() => repository.fetchProducts()).called(1);
  });
  test('Should return Failure', () async {
    var error = ErrorMock();
    when(() => repository.fetchProducts()).thenAnswer((_) async => Left(error));
    var result = await useCase();
    expect(result, Left(error));
    verify(() => repository.fetchProducts()).called(1);
  });
}
