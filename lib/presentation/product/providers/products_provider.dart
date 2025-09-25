import 'package:e_commerce_app/data/product/datasources/product_remote_data_source.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:e_commerce_app/domain/product/entities/product_entity.dart';

final productsByCategoryProvider =
    FutureProvider.family<List<ProductEntity>, int>((ref, categoryId) async {
      final remoteDataSource = ref.read(productRemoteDataSourceProvider);
      return remoteDataSource.fetchProductsByCategory(categoryId);
    });
