import 'package:flutter/material.dart';
import 'package:login_service/app/modules/home/domain/entities/product_entity.dart';

class CardProductComponent extends StatelessWidget {
  final ProductEntity product;
  const CardProductComponent({Key? key, required this.product})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: Colors.white,
        boxShadow: const [BoxShadow(blurRadius: 3, color: Colors.black45)],
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(product.description, overflow: TextOverflow.ellipsis),
          ),
          Text(
            'R\$ ${product.unitaryValue.toStringAsFixed(2)}',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
