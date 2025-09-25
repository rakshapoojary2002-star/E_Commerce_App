import 'package:e_commerce_app/data/cart/datasources/cart_remote_data_source.dart';
import 'package:e_commerce_app/data/cart/repositories/cart_repository_impl.dart';
import 'package:e_commerce_app/domain/cart/entities/cart_entity.dart';
import 'package:e_commerce_app/domain/cart/repositories/cart_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:e_commerce_app/core/network/dio_client.dart';

final cartRemoteDataSourceProvider = Provider(
  (ref) => CartRemoteDataSource(DioClient()),
);

final cartRepositoryProvider = Provider<CartRepository>(
  (ref) => CartRepositoryImpl(ref.watch(cartRemoteDataSourceProvider)),
);

final cartProvider = StateNotifierProvider<CartNotifier, AsyncValue<CartEntity>>((ref) {
  return CartNotifier(ref.watch(cartRepositoryProvider));
});

class CartNotifier extends StateNotifier<AsyncValue<CartEntity>> {
  final CartRepository repository;

  CartNotifier(this.repository) : super(const AsyncValue.loading()) {
    getCart();
  }

  Future<void> getCart() async {
    state = const AsyncValue.loading();
    try {
      final cart = await repository.getCart();
      state = AsyncValue.data(cart);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> addToCart(int productId, int quantity) async {
    state = const AsyncValue.loading();
    try {
      await repository.addToCart(productId, quantity);
      getCart();
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> updateCartItem(int itemId, int quantity) async {
    state = const AsyncValue.loading();
    try {
      await repository.updateCartItem(itemId, quantity);
      getCart();
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> removeFromCart(int itemId) async {
    state = const AsyncValue.loading();
    try {
      await repository.removeFromCart(itemId);
      getCart();
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> clearCart() async {
    state = const AsyncValue.loading();
    try {
      await repository.clearCart();
      getCart();
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}
