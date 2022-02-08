import 'package:login_service/app/modules/home/infra/models/product_model.dart';

abstract class ProductDatasourceInterface {
  Future<List<ProductModel>> fetchProducts();
}
