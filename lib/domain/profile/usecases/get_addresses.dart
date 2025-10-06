
import 'package:e_commerce_app/data/profile/models/address_model.dart';
import 'package:e_commerce_app/domain/profile/repositories/address_repository.dart';

class GetAddresses {
  final AddressRepository repository;

  GetAddresses(this.repository);

  Future<List<Address>> call() {
    return repository.getAddresses();
  }
}
