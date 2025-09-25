import 'package:e_commerce_app/data/categories/repositories/category_repository_impl.dart';
import 'package:e_commerce_app/domain/categories/entities/category_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/network/dio_client.dart';

final categoryRepositoryProvider = Provider(
  (ref) => CategoryRepositoryImpl(DioClient()),
);

final categoriesProvider = FutureProvider<List<CategoryEntity>>((ref) async {
  final repo = ref.watch(categoryRepositoryProvider);
  final categories = await repo.getCategories();
  print('Fetched categories: ${categories.length}');
  return categories;
});

final categoryByIdProvider = FutureProvider.family<CategoryEntity, int>((
  ref,
  id,
) async {
  final repo = ref.watch(categoryRepositoryProvider);
  return repo.getCategoryById(id);
});
