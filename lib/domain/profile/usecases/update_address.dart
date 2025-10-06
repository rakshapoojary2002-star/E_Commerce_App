
import 'package:e_commerce_app/data/profile/models/address_model.dart';
import 'package:e_commerce_app/domain/profile/repositories/address_repository.dart';

class UpdateAddress {
  final AddressRepository repository;

  UpdateAddress(this.repository);

  Future<Address> call(Address address) {
    return repository.updateAddress(address);
  }
}
