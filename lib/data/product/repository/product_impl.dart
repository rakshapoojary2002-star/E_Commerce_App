import 'package:e_commerce_app/core/network/dio_client.dart';
import 'package:e_commerce_app/data/product/models/product_model.dart';
import 'package:e_commerce_app/domain/product/entities/Product.dart';
import 'package:e_commerce_app/domain/product/repository/product_repository.dart';

class ProductRepositoryImpl implements ProductRepository {
  final DioClient dioClient;

  ProductRepositoryImpl(this.dioClient);

  @override
  Future<List<ProductEntity>> getFeaturedProducts({int limit = 6}) async {
    final response = await dioClient.dio.get(
      '/api/v1/products/featured?limit=$limit',
    );
    final data = response.data['data'] as List;
    return data.map((json) => ProductModel.fromJson(json)).toList();
  }
}
