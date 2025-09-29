import 'package:e_commerce_app/core/utils/flutter_secure.dart';
import 'package:e_commerce_app/core/network/dio_client.dart';
import 'package:e_commerce_app/data/cart/datasources/cart_remote_data_source.dart';
import 'package:e_commerce_app/data/cart/repositories/cart_repository_impl.dart';
import 'package:e_commerce_app/domain/cart/entities/cart_entity.dart';
import 'package:e_commerce_app/domain/cart/usecases/add_to_cart_usecase.dart';
import 'package:e_commerce_app/domain/cart/usecases/clear_cart_usecase.dart';
import 'package:e_commerce_app/domain/cart/usecases/get_cart_item_count_usecase.dart';
import 'package:e_commerce_app/domain/cart/usecases/get_cart_usecase.dart';
import 'package:e_commerce_app/domain/cart/usecases/remove_from_cart_usecase.dart';
import 'package:e_commerce_app/domain/cart/usecases/update_cart_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final cartRemoteDataSourceProvider = Provider(
  (ref) => CartRemoteDataSource(DioClient()),
);

final cartRepositoryProvider = Provider(
  (ref) => CartRepositoryImpl(ref.watch(cartRemoteDataSourceProvider)),
);

final getCartUseCaseProvider = Provider(
  (ref) => GetCartUseCase(ref.watch(cartRepositoryProvider)),
);

final addToCartUseCaseProvider = Provider(
  (ref) => AddToCartUseCase(ref.watch(cartRepositoryProvider)),
);

final updateCartUseCaseProvider = Provider(
  (ref) => UpdateCartUseCase(ref.watch(cartRepositoryProvider)),
);

final removeFromCartUseCaseProvider = Provider(
  (ref) => RemoveFromCartUseCase(ref.watch(cartRepositoryProvider)),
);

final clearCartUseCaseProvider = Provider(
  (ref) => ClearCartUseCase(ref.watch(cartRepositoryProvider)),
);

final getCartItemCountUseCaseProvider = Provider(
  (ref) => GetCartItemCountUseCase(ref.watch(cartRepositoryProvider)),
);

final cartItemCountProvider = FutureProvider<int>((ref) async {
  final getCartItemCountUseCase = ref.watch(getCartItemCountUseCaseProvider);
  return await getCartItemCountUseCase.execute();
});

final cartNotifierProvider =
    StateNotifierProvider<CartNotifier, AsyncValue<Cart?>>((ref) {
      return CartNotifier(
        ref, // Pass the ref
        ref.watch(getCartUseCaseProvider),
        ref.watch(addToCartUseCaseProvider),
        ref.watch(updateCartUseCaseProvider),
        ref.watch(removeFromCartUseCaseProvider),
        ref.watch(clearCartUseCaseProvider),
        ref.watch(getCartItemCountUseCaseProvider),
      );
    });

class CartNotifier extends StateNotifier<AsyncValue<Cart?>> {
  final Ref _ref; // Store the ref
  final GetCartUseCase _getCartUseCase;
  final AddToCartUseCase _addToCartUseCase;
  final UpdateCartUseCase _updateCartUseCase;
  final RemoveFromCartUseCase _removeFromCartUseCase;
  final ClearCartUseCase _clearCartUseCase;
  final GetCartItemCountUseCase _getCartItemCountUseCase;

  CartNotifier(
    this._ref, // Accept the ref
    this._getCartUseCase,
    this._addToCartUseCase,
    this._updateCartUseCase,
    this._removeFromCartUseCase,
    this._clearCartUseCase,
    this._getCartItemCountUseCase,
  ) : super(const AsyncValue.loading()) {
    getCart();
  }

  int _cartItemCount = 0;
  int get cartItemCount => _cartItemCount;

  Future<void> getCart() async {
    state = const AsyncValue.loading();
    await Future.delayed(const Duration(seconds: 2));
    try {
      final cart = await _getCartUseCase.execute();
      state = AsyncValue.data(cart);
      _cartItemCount = await _getCartItemCountUseCase.execute();
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> addToCart(int productId, int quantity) async {
    try {
      await _addToCartUseCase.execute(productId, quantity);
      await getCart();
      _ref.refresh(cartItemCountProvider); // Refresh the count
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> updateCart(int itemId, int quantity) async {
    try {
      await _updateCartUseCase.execute(itemId, quantity);
      state = state.whenData((cart) {
        if (cart == null) return null;
        final updatedItems =
            cart.items.map((item) {
              if (item.productId == itemId) {
                return item.copyWith(quantity: quantity);
              }
              return item;
            }).toList();
        return cart.copyWith(items: updatedItems);
      });
      _ref.refresh(cartItemCountProvider); // Refresh the count
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> removeFromCart(int itemId) async {
    try {
      await _removeFromCartUseCase.execute(itemId);
      state = state.whenData((cart) {
        if (cart == null) return null;
        final updatedItems =
            cart.items.where((item) => item.productId != itemId).toList();
        return cart.copyWith(items: updatedItems);
      });
      _ref.refresh(cartItemCountProvider);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> clearCart() async {
    try {
      await _clearCartUseCase.execute();
      state = state.whenData((cart) {
        if (cart == null) return null;
        return cart.copyWith(items: []);
      });
      _ref.refresh(cartItemCountProvider);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> undoRemoveFromCart(CartItem item) async {
    try {
      await _addToCartUseCase.execute(item.productId, item.quantity);
      await getCart();
      _ref.refresh(cartItemCountProvider);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}
