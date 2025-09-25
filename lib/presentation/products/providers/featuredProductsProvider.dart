import 'package:e_commerce_app/core/network/dio_client.dart';
import 'package:e_commerce_app/data/product/repository/product_impl.dart';
import 'package:e_commerce_app/domain/product/entities/Product.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final productRepositoryProvider = Provider(
  (ref) => ProductRepositoryImpl(DioClient()),
);

final featuredProductsProvider =
    FutureProvider.family<List<ProductEntity>, int>((ref, limit) async {
      final repo = ref.watch(productRepositoryProvider);
      return repo.getFeaturedProducts(limit: limit);
    });
