import 'package:dartz/dartz.dart';
import 'package:login_service/app/core/error/failure.dart';
import 'package:login_service/app/modules/home/domain/entities/product_entity.dart';

import 'package:login_service/app/modules/home/domain/repositories/product_reposity.dart';
import 'package:login_service/app/modules/home/infra/datasources/product_datasource.dart';

class ProductRrepository implements ProductRepositoryInterface {
  final ProductDatasourceInterface _datasource;

  ProductRrepository({required ProductDatasourceInterface datasource})
      : _datasource = datasource;

  @override
  Future<Either<Failure, List<ProductEntity>>> fetchProducts() async {
    try {
      var result = await _datasource.fetchProducts();
      return Right(result);
    } on Failure catch (e) {
      return Left(e);
    }
  }
}
