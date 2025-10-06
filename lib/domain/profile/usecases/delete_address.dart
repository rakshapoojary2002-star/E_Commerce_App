
import 'package:e_commerce_app/domain/profile/repositories/address_repository.dart';

class DeleteAddress {
  final AddressRepository repository;

  DeleteAddress(this.repository);

  Future<void> call(String addressId) {
    return repository.deleteAddress(addressId);
  }
}
