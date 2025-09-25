import 'package:dio/dio.dart';
import 'package:e_commerce_app/domain/categories/entities/category_entity.dart';
import 'package:e_commerce_app/domain/categories/repositories/category_repository.dart';
import '../../../core/network/dio_client.dart';

import '../models/category_model.dart';

class CategoryRepositoryImpl implements CategoryRepository {
  final DioClient dioClient;

  CategoryRepositoryImpl(this.dioClient);

  @override
  Future<List<CategoryEntity>> getCategories() async {
    final response = await dioClient.dio.get('/api/v1/categories');
    final data = response.data['data'] as List;
    return data.map((json) => CategoryModel.fromJson(json)).toList();
  }

  @override
  Future<CategoryEntity> getCategoryById(String id) async {
    final response = await dioClient.dio.get('/api/v1/categories/$id');
    return CategoryModel.fromJson(response.data['data']);
  }
}
