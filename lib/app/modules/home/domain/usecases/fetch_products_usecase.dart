import 'package:dartz/dartz.dart';
import 'package:login_service/app/core/error/failure.dart';
import 'package:login_service/app/modules/home/domain/entities/product_entity.dart';
import 'package:login_service/app/modules/home/domain/repositories/product_reposity.dart';

abstract class FetchProductsUsecaseInterface {
  Future<Either<Failure, List<ProductEntity>>> call();
}

class FetchProductsUsecase implements FetchProductsUsecaseInterface {
  final ProductRepositoryInterface repository;

  FetchProductsUsecase({required this.repository});
  @override
  Future<Either<Failure, List<ProductEntity>>> call() async {
    return repository.fetchProducts();
  }
}
