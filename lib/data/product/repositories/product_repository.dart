import 'package:e_commerce_app/data/product/datasources/product_remote_data_source.dart';
import 'package:e_commerce_app/domain/product/entities/product_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final productRepositoryProvider = Provider<ProductRepository>((ref) {
  final remoteDataSource = ref.read(productRemoteDataSourceProvider);
  return ProductRepository(remoteDataSource);
});

class ProductRepository {
  final ProductRemoteDataSource remoteDataSource;

  ProductRepository(this.remoteDataSource);

  Future<List<ProductEntity>> getProductsByCategory(int categoryId) {
    return remoteDataSource.fetchProductsByCategory(categoryId);
  }
}
