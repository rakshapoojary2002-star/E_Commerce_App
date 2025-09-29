import 'package:e_commerce_app/domain/cart/repositories/cart_repository.dart';

class UpdateCartUseCase {
  final CartRepository _repository;

  UpdateCartUseCase(this._repository);

  Future<void> execute(int itemId, int quantity) {
    return _repository.updateCart(itemId, quantity);
  }
}
