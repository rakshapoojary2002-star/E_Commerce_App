import 'package:e_commerce_app/domain/cart/entities/cart_entity.dart';

abstract class CartRepository {
  Future<Cart> getCart();
  Future<void> addToCart(int productId, int quantity);
  Future<void> updateCart(int itemId, int quantity);
  Future<void> removeFromCart(int itemId);
  Future<int> getCartItemCount();
  Future<void> clearCart();
}
