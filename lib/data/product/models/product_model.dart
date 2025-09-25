import 'package:e_commerce_app/domain/product/entities/Product.dart';

class ProductModel extends ProductEntity {
  const ProductModel({
    required String id,
    required String name,
    required String imageUrl,
    required double price,
  }) : super(id: id, name: name, imageUrl: imageUrl, price: price);

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      imageUrl: json['imageUrl'] ?? json['image_url'] ?? '',
      price: (json['price'] ?? 0).toDouble(),
    );
  }
}
