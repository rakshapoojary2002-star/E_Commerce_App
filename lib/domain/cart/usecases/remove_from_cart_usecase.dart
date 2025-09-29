import 'package:e_commerce_app/domain/cart/repositories/cart_repository.dart';

class RemoveFromCartUseCase {
  final CartRepository _repository;

  RemoveFromCartUseCase(this._repository);

  Future<void> execute(int itemId) {
    return _repository.removeFromCart(itemId);
  }
}
