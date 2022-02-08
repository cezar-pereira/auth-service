import 'package:dartz/dartz.dart';
import 'package:login_service/app/core/error/failure.dart';
import 'package:login_service/app/modules/home/domain/entities/product_entity.dart';

abstract class ProductRepositoryInterface {
  Future<Either<Failure, List<ProductEntity>>> fetchProducts();
}
