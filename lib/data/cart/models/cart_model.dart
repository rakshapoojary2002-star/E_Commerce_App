import 'package:e_commerce_app/data/cart/models/cart_item_model.dart';
import 'package:e_commerce_app/domain/cart/entities/cart_entity.dart';

class CartModel extends CartEntity {
  CartModel({required List<CartItemModel> items, required double totalPrice})
      : super(items: items, totalPrice: totalPrice);

  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
      items: (json['items'] as List)
          .map((item) => CartItemModel.fromJson(item))
          .toList(),
      totalPrice: (json['totalPrice'] as num).toDouble(),
    );
  }
}
