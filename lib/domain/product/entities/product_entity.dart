class ProductEntity {
  final int id;
  final String name;
  final String description;
  final double price;
  final String imageUrl;
  final double? originalPrice;
  final int? categoryId;
  final String? sku;
  final int? stockQuantity;
  final List<String>? images;
  final bool? isActive;
  final bool? isFeatured;
  final double? weight;
  final String? unit;
  final String? brand;

  ProductEntity({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    this.originalPrice,
    this.categoryId,
    this.sku,
    this.stockQuantity,
    this.images,
    this.isActive,
    this.isFeatured,
    this.weight,
    this.unit,
    this.brand,
  });

  factory ProductEntity.fromJson(Map<String, dynamic> json) {
    return ProductEntity(
      id: json['id'],
      name: json['name'],
      description: json['description'] ?? '',
      price: (json['price'] as num).toDouble(),
      imageUrl: json['image_url'] ?? '',
      originalPrice: (json['original_price'] as num?)?.toDouble(),
      categoryId: json['category_id'],
      sku: json['sku'],
      stockQuantity: json['stock_quantity'],
      images: json['images'] != null ? List<String>.from(json['images']) : null,
      isActive: json['is_active'],
      isFeatured: json['is_featured'],
      weight: (json['weight'] as num?)?.toDouble(),
      unit: json['unit'],
      brand: json['brand'],
    );
  }
}
