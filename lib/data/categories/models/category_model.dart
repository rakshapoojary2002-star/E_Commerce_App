import 'package:e_commerce_app/domain/categories/entities/category_entity.dart';

class CategoryModel extends CategoryEntity {
  // Base URL for relative images
  static const String baseUrl = 'https://tcommmerce.vercel.app';

  const CategoryModel({
    required String id,
    required String name,
    String? description,
    String? imageUrl,
  }) : super(id: id, name: name, description: description, imageUrl: imageUrl);

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    String? imageUrl = json['imageUrl'] ?? json['image_url'];

    // Fix relative URLs
    if (imageUrl != null && !imageUrl.startsWith('http')) {
      imageUrl = '$baseUrl$imageUrl';
    }

    return CategoryModel(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      description: json['description'],
      imageUrl: imageUrl,
    );
  }
}
