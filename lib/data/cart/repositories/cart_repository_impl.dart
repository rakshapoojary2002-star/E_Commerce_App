import 'package:e_commerce_app/core/utils/flutter_secure.dart';
import 'package:e_commerce_app/data/cart/datasources/cart_remote_data_source.dart';
import 'package:e_commerce_app/data/cart/mappers/cart_mapper.dart';
import 'package:e_commerce_app/domain/cart/entities/cart_entity.dart';
import 'package:e_commerce_app/domain/cart/repositories/cart_repository.dart';

class CartRepositoryImpl implements CartRepository {
  final CartRemoteDataSource _remoteDataSource;

  CartRepositoryImpl(this._remoteDataSource);

  @override
  Future<Cart> getCart() async {
    final token = await SecureStorage.getToken();
    if (token == null) {
      throw Exception('Token not found');
    }
    print('Token: $token');
    final cartModel = await _remoteDataSource.getCart(token);
    return CartMapper.fromModel(cartModel);
  }

  @override
  Future<void> addToCart(int productId, int quantity) async {
    final token = await SecureStorage.getToken();
    if (token == null) {
      throw Exception('Token not found');
    }
    await _remoteDataSource.addToCart(token, productId, quantity);
  }

  @override
  Future<void> updateCart(int itemId, int quantity) async {
    final token = await SecureStorage.getToken();
    if (token == null) {
      throw Exception('Token not found');
    }
    await _remoteDataSource.updateCart(token, itemId, quantity);
  }

  @override
  Future<void> removeFromCart(int itemId) async {
    final token = await SecureStorage.getToken();
    if (token == null) {
      throw Exception('Token not found');
    }
    await _remoteDataSource.removeFromCart(token, itemId);
  }

  @override
  Future<int> getCartItemCount() async {
    final token = await SecureStorage.getToken();
    if (token == null) {
      throw Exception('Token not found');
    }
    return await _remoteDataSource.getCartItemCount(token);
  }

  @override
  Future<void> clearCart() async {
    final token = await SecureStorage.getToken();
    if (token == null) {
      throw Exception('Token not found');
    }
    await _remoteDataSource.clearCart(token);
  }
}
