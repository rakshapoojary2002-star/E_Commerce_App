
import 'package:e_commerce_app/data/profile/models/address_model.dart';
import 'package:e_commerce_app/domain/profile/repositories/address_repository.dart';

class AddAddress {
  final AddressRepository repository;

  AddAddress(this.repository);

  Future<Address> call(Address address) {
    return repository.addAddress(address);
  }
}
