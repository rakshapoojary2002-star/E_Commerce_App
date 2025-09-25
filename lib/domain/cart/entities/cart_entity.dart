import 'package:e_commerce_app/domain/product/entities/product_entity.dart';

class CartItemEntity {
  final ProductEntity product;
  final int quantity;

  CartItemEntity({required this.product, required this.quantity});
}

class CartEntity {
  final List<CartItemEntity> items;
  final double totalPrice;

  CartEntity({required this.items, required this.totalPrice});
}
