import 'package:flutter/foundation.dart';

@immutable
class Cart {
  final List<CartItem> items;

  const Cart({required this.items});

  Cart copyWith({
    List<CartItem>? items,
  }) {
    return Cart(
      items: items ?? this.items,
    );
  }
}

@immutable
class CartItem {
  final int id;
  final int productId;
  final int quantity;
  final String name;
  final double price;
  final String? imageUrl;

  const CartItem({
    required this.id,
    required this.productId,
    required this.quantity,
    required this.name,
    required this.price,
    this.imageUrl,
  });

  CartItem copyWith({
    int? id,
    int? productId,
    int? quantity,
    String? name,
    double? price,
    String? imageUrl,
  }) {
    return CartItem(
      id: id ?? this.id,
      productId: productId ?? this.productId,
      quantity: quantity ?? this.quantity,
      name: name ?? this.name,
      price: price ?? this.price,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }
}