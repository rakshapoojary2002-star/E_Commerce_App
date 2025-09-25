import 'package:e_commerce_app/core/network/dio_client.dart';
import 'package:e_commerce_app/data/product/repository/product_impl.dart';
import 'package:e_commerce_app/domain/product/entities/Product.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final productRepositoryProvider = Provider(
  (ref) => ProductRepositoryImpl(DioClient()),
);

final categoryProductsProvider =
    FutureProvider.family<List<ProductEntity>, String>((ref, categoryId) async {
      final repo = ref.watch(productRepositoryProvider);
      return repo.getProductsByCategory(categoryId);
    });
