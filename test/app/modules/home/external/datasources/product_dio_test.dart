import 'package:flutter_test/flutter_test.dart';
import 'package:login_service/app/core/error/failure.dart';
import 'package:login_service/app/modules/home/infra/datasources/product_datasource.dart';
import 'package:login_service/app/modules/home/infra/models/product_model.dart';
import 'package:mocktail/mocktail.dart';

class ProductDataSourceMock extends Mock implements ProductDatasourceInterface {
}

class ErrorMock extends Mock implements Failure {}

void main() {
  ProductDatasourceInterface dataSource = ProductDataSourceMock();
  group('fetchProducts:', () {
    test('Should return a List<ProductModel>', () async {
      List<ProductModel> list = [];
      when(() => dataSource.fetchProducts()).thenAnswer((_) async => list);
      var result = await dataSource.fetchProducts();
      expect(result, list);
      verify(() => dataSource.fetchProducts()).called(1);
    });
    test('Should return a Failure', () async {
      var error = ErrorMock();
      when(() => dataSource.fetchProducts()).thenThrow(error);
      expect(() => dataSource.fetchProducts(), throwsA(isA<Failure>()));
      verify(() => dataSource.fetchProducts()).called(1);
    });
  });
}
