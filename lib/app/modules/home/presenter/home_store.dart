import 'package:flutter_triple/flutter_triple.dart';
import 'package:login_service/app/core/either_adapter/dartz_either_adapter.dart';
import 'package:login_service/app/core/error/failure.dart';
import 'package:login_service/app/modules/auth/domain/usecases/logout_usecasae.dart';
import 'package:login_service/app/modules/home/domain/entities/product_entity.dart';
import 'package:login_service/app/modules/home/domain/usecases/fetch_products_usecase.dart';

class HomeStore extends NotifierStore<Failure, List<ProductEntity>> {
  final LogoutUsecaseInterface _logoutUsecase;
  final FetchProductsUsecaseInterface _fetchProductsUsecase;

  HomeStore(
      {required LogoutUsecaseInterface logoutUsecase,
      required FetchProductsUsecaseInterface fetchProductsUsecase})
      : _logoutUsecase = logoutUsecase,
        _fetchProductsUsecase = fetchProductsUsecase,
        super([]);

  Future<void> logout() async {
    await _logoutUsecase();
  }

  Future<void> fetchProducts() async =>
      executeEither(() => DartzEitherAdapter.adapter(_fetchProductsUsecase()));
}
