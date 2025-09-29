
import 'package:e_commerce_app/domain/cart/repositories/cart_repository.dart';

class GetCartItemCountUseCase {
  final CartRepository _repository;

  GetCartItemCountUseCase(this._repository);

  Future<int> execute() {
    return _repository.getCartItemCount();
  }
}
