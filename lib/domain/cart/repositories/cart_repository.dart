import 'package:e_commerce_app/domain/cart/entities/cart_entity.dart';

abstract class CartRepository {
  Future<CartEntity> getCart();
  Future<void> addToCart(int productId, int quantity);
  Future<void> updateCartItem(int itemId, int quantity);
  Future<void> removeFromCart(int itemId);
  Future<void> clearCart();
}
