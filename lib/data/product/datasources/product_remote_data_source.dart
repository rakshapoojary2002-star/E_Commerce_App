import 'package:dio/dio.dart';
import 'package:e_commerce_app/core/providers/dio_provider.dart';
import 'package:e_commerce_app/domain/product/entities/product_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:e_commerce_app/core/network/dio_client.dart';

final productRemoteDataSourceProvider = Provider<ProductRemoteDataSource>((
  ref,
) {
  final dio = ref.read(dioClientProvider).dio;
  return ProductRemoteDataSource(dio);
});

class ProductRemoteDataSource {
  final Dio _dio;

  ProductRemoteDataSource(this._dio);

  Future<List<ProductEntity>> fetchProductsByCategory(int categoryId) async {
    print("my fate $categoryId");
    try {
      final response = await _dio.get(
        '/api/v1/products/category/$categoryId',
        queryParameters: {'limit': 20, 'page': 1},
      );

      final data = response.data['data'] as List;
      print("my fate $data");
      return data.map((e) => ProductEntity.fromJson(e)).toList();
    } on DioError catch (e) {
      throw Exception(
        'Failed to fetch products: ${e.response?.statusCode ?? e.message}',
      );
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }

  Future<ProductEntity> fetchProductById(int productId) async {
    try {
      final response = await _dio.get('/api/v1/products/$productId');
      return ProductEntity.fromJson(response.data['data']);
    } on DioError catch (e) {
      throw Exception(
        'Failed to fetch product: ${e.response?.statusCode ?? e.message}',
      );
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }
}
