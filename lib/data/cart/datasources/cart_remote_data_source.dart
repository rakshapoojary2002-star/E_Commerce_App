import 'package:dio/dio.dart';
import 'package:e_commerce_app/core/network/dio_client.dart';
import 'package:e_commerce_app/data/cart/models/cart_model.dart';

class CartRemoteDataSource {
  final DioClient _dioClient;

  CartRemoteDataSource(this._dioClient);

  Future<CartModel> getCart(String token) async {
    try {
      final response = await _dioClient.dio.get(
        '/api/v1/cart',
        options: _dioClient.getAuthOptions(token),
      );

      if (response.statusCode == 200) {
        print('Cart API Response: ${response.data}');
        return CartModel.fromJson(response.data['data']);
      } else {
        throw Exception('Failed to get cart with status: ${response.statusCode}');
      }
    } on DioException catch (e) {
      throw Exception('Failed to get cart: ${e.message}');
    } catch (e) {
      throw Exception('Failed to get cart: $e');
    }
  }

  Future<void> addToCart(String token, int productId, int quantity) async {
    try {
      await _dioClient.dio.post(
        '/api/v1/cart/add',
        data: {'productId': productId, 'quantity': quantity},
        options: _dioClient.getAuthOptions(token),
      );
    } catch (e) {
      throw Exception('Failed to add to cart: $e');
    }
  }

  Future<void> updateCart(String token, int itemId, int quantity) async {
    print('Updating cart item: $itemId with quantity: $quantity');
    print('Auth Token: $token');
    try {
      await _dioClient.dio.put(
        '/api/v1/cart/$itemId',
        data: '{"quantity": $quantity}',
        options: _dioClient.getAuthOptions(token),
      );
    } catch (e) {
      print('Failed to update cart: $e');
      throw Exception('Failed to update cart: $e');
    }
  }

  Future<void> removeFromCart(String token, int itemId) async {
    try {
      await _dioClient.dio.delete(
        '/api/v1/cart/$itemId',
        options: _dioClient.getAuthOptions(token),
      );
    } catch (e) {
      throw Exception('Failed to remove from cart: $e');
    }
  }

  Future<int> getCartItemCount(String token) async {
    try {
      final response = await _dioClient.dio.get(
        '/api/v1/cart/count',
        options: _dioClient.getAuthOptions(token),
      );
      print('Cart Item Count API Response: ${response.data}');
      if (response.data != null && response.data['data'] != null) {
        return response.data['data']['total_items'] as int;
      }
      return 0;
    } catch (e) {
      throw Exception('Failed to get cart item count: $e');
    }
  }

  Future<void> clearCart(String token) async {
    try {
      await _dioClient.dio.delete(
        '/api/v1/cart',
        options: _dioClient.getAuthOptions(token),
      );
    } catch (e) {
      throw Exception('Failed to clear cart: $e');
    }
  }
}
