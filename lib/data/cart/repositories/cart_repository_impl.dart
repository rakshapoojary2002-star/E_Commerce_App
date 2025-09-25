import 'package:e_commerce_app/data/cart/datasources/cart_remote_data_source.dart';
import 'package:e_commerce_app/domain/cart/entities/cart_entity.dart';
import 'package:e_commerce_app/domain/cart/repositories/cart_repository.dart';

class CartRepositoryImpl implements CartRepository {
  final CartRemoteDataSource remoteDataSource;

  CartRepositoryImpl(this.remoteDataSource);

  @override
  Future<CartEntity> getCart() {
    return remoteDataSource.getCart();
  }

  @override
  Future<void> addToCart(int productId, int quantity) {
    return remoteDataSource.addToCart(productId, quantity);
  }

  @override
  Future<void> updateCartItem(int itemId, int quantity) {
    return remoteDataSource.updateCartItem(itemId, quantity);
  }

  @override
  Future<void> removeFromCart(int itemId) {
    return remoteDataSource.removeFromCart(itemId);
  }

  @override
  Future<void> clearCart() {
    return remoteDataSource.clearCart();
  }
}
