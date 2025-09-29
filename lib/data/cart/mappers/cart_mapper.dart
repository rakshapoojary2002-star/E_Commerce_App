import 'package:e_commerce_app/data/cart/models/cart_model.dart';
import 'package:e_commerce_app/domain/cart/entities/cart_entity.dart';

class CartMapper {
  static Cart fromModel(CartModel model) {
    return Cart(
      items: model.items.map((item) => fromItemModel(item)).toList(),
    );
  }

  static CartItem fromItemModel(CartItemModel model) {
    return CartItem(
      id: model.id,
      productId: model.productId,
      quantity: model.quantity,
      name: model.name,
      price: model.price,
      imageUrl: model.imageUrl,
    );
  }
}
