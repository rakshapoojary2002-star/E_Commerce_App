import 'package:e_commerce_app/domain/cart/repositories/cart_repository.dart';

class ClearCartUseCase {
  final CartRepository _repository;

  ClearCartUseCase(this._repository);

  Future<void> execute() {
    return _repository.clearCart();
  }
}
