import 'package:login_service/app/modules/home/domain/entities/product_entity.dart';

class ProductModel extends ProductEntity {
  ProductModel(
      {required int id,
      required String description,
      required String barCode,
      required double unitaryValue})
      : super(
            id: id,
            description: description,
            barCode: barCode,
            unitaryValue: unitaryValue);

  factory ProductModel.fromMap({required Map<String, dynamic> map}) {
    return ProductModel(
        id: map['Codigo'],
        barCode: map['CodigoBarras'],
        description: map['Descricao'],
        unitaryValue: map['Preco']);
  }
}
