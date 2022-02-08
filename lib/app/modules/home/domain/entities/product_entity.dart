class ProductEntity {
  final int id;
  final String description;
  final double unitaryValue;
  final String barCode;

  ProductEntity({
    required this.id,
    required this.description,
    required this.unitaryValue,
    required this.barCode,
  });

  @override
  String toString() => description;
}
