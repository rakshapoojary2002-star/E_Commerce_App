
import 'package:e_commerce_app/data/profile/datasources/address_mock_datasource.dart';
import 'package:e_commerce_app/data/profile/models/address_model.dart';
import 'package:e_commerce_app/domain/profile/repositories/address_repository.dart';

class AddressRepositoryImpl implements AddressRepository {
  final AddressMockDataSource dataSource;

  AddressRepositoryImpl(this.dataSource);

  @override
  Future<List<Address>> getAddresses() {
    return dataSource.getAddresses();
  }

  @override
  Future<Address> addAddress(Address address) {
    return dataSource.addAddress(address);
  }

  @override
  Future<Address> updateAddress(Address address) {
    return dataSource.updateAddress(address);
  }

  @override
  Future<void> deleteAddress(String addressId) {
    return dataSource.deleteAddress(addressId);
  }
}
