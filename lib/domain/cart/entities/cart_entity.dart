class Cart {
  final List<CartItem> items;

  Cart({required this.items});
}

class CartItem {
  final int id;
  final int productId;
  final int quantity;
  final String name;
  final double price;
  final String? imageUrl;

  CartItem({
    required this.id,
    required this.productId,
    required this.quantity,
    required this.name,
    required this.price,
    this.imageUrl,
  });
}