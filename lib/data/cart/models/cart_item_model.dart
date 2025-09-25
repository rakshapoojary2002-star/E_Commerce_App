import 'package:e_commerce_app/domain/cart/entities/cart_entity.dart';
import 'package:e_commerce_app/domain/product/entities/product_entity.dart';

class CartItemModel extends CartItemEntity {
  CartItemModel({required ProductEntity product, required int quantity})
      : super(product: product, quantity: quantity);

  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    return CartItemModel(
      product: ProductEntity.fromJson(json['product']),
      quantity: json['quantity'],
    );
  }
}
