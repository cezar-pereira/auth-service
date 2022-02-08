import 'package:flutter_test/flutter_test.dart';
import 'package:login_service/app/modules/home/infra/models/product_model.dart';

void main() {
  late final ProductModel productModel;

  setUpAll(() {
    productModel = ProductModel.fromMap(map: data['products'][0]);
  });

  test('Should create a ProductModel', () {
    expect(productModel, isA<ProductModel>());
  });
}

Map<String, dynamic> data = {
  "products": [
    {
      "Codigo": 1,
      "CodigoBarras": "xxxxx",
      "Descricao": "name",
      "Preco": 3.89,
    }
  ]
};
