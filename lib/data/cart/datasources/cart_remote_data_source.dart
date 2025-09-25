import 'package:dio/dio.dart';
import 'package:e_commerce_app/core/network/dio_client.dart';
import 'package:e_commerce_app/core/utils/flutter_secure.dart';
import 'package:e_commerce_app/data/cart/models/cart_model.dart';
import 'package:e_commerce_app/domain/cart/entities/cart_entity.dart';

class CartRemoteDataSource {
  final DioClient dioClient;

  CartRemoteDataSource(this.dioClient);

  Future<CartEntity> getCart() async {
    final token = await SecureStorage.getToken();
    final response = await dioClient.dio.get(
      '/api/v1/cart',
      options: Options(headers: {'Authorization': 'Bearer $token'}),
    );
    return CartModel.fromJson(response.data['data']);
  }

  Future<void> addToCart(int productId, int quantity) async {
    final token = await SecureStorage.getToken();
    await dioClient.dio.post(
      '/api/v1/cart/add',
      data: {'productId': productId, 'quantity': quantity},
      options: Options(headers: {'Authorization': 'Bearer $token'}),
    );
  }

  Future<void> updateCartItem(int itemId, int quantity) async {
    final token = await SecureStorage.getToken();
    await dioClient.dio.put(
      '/api/v1/cart/$itemId',
      data: {'quantity': quantity},
      options: Options(headers: {'Authorization': 'Bearer $token'}),
    );
  }

  Future<void> removeFromCart(int itemId) async {
    final token = await SecureStorage.getToken();
    await dioClient.dio.delete(
      '/api/v1/cart/$itemId',
      options: Options(headers: {'Authorization': 'Bearer $token'}),
    );
  }

  Future<void> clearCart() async {
    final token = await SecureStorage.getToken();
    await dioClient.dio.delete(
      '/api/v1/cart',
      options: Options(headers: {'Authorization': 'Bearer $token'}),
    );
  }
}