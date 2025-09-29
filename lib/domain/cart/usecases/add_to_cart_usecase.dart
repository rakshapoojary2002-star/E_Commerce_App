import 'package:e_commerce_app/domain/cart/repositories/cart_repository.dart';

class AddToCartUseCase {
  final CartRepository _repository;

  AddToCartUseCase(this._repository);

  Future<void> execute(int productId, int quantity) {
    return _repository.addToCart(productId, quantity);
  }
}
