class CartModel {
  final List<CartItemModel> items;

  CartModel({required this.items});

  factory CartModel.fromJson(dynamic json) {
    if (json is List) {
      return CartModel(
        items: json.map((item) => CartItemModel.fromJson(item)).toList(),
      );
    } else if (json is Map && json['items'] is List) {
      return CartModel(
        items: (json['items'] as List)
            .map((item) => CartItemModel.fromJson(item))
            .toList(),
      );
    } else if (json == null || (json is Map && json.isEmpty)) {
      return CartModel(items: []);
    } else {
      throw FormatException('Invalid JSON format for CartModel: $json');
    }
  }
}

class CartItemModel {
  final int id;
  final int productId;
  final int quantity;
  final String name;
  final double price;
  final String? imageUrl;

  CartItemModel({
    required this.id,
    required this.productId,
    required this.quantity,
    required this.name,
    required this.price,
    this.imageUrl,
  });

  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    return CartItemModel(
      id: json['id'],
      productId: json['product_id'],
      quantity: json['quantity'],
      name: json['products']['name'],
      price: json['price'].toDouble(),
      imageUrl: json['products']['image_url'],
    );
  }
}