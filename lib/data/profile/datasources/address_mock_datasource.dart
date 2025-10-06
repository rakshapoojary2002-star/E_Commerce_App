
import '../models/address_model.dart';

class AddressMockDataSource {
  final List<Address> _addresses = [
    Address(
      id: '1',
      street: '123 Main St',
      city: 'Anytown',
      state: 'CA',
      zipCode: '12345',
      isDefault: true,
    ),
    Address(
      id: '2',
      street: '456 Oak Ave',
      city: 'Someville',
      state: 'NY',
      zipCode: '54321',
    ),
  ];

  Future<List<Address>> getAddresses() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return _addresses;
  }

  Future<Address> addAddress(Address address) async {
    await Future.delayed(const Duration(milliseconds: 300));
    final newAddress = address.copyWith(id: DateTime.now().toIso8601String());
    _addresses.add(newAddress);
    return newAddress;
  }

  Future<Address> updateAddress(Address address) async {
    await Future.delayed(const Duration(milliseconds: 300));
    final index = _addresses.indexWhere((a) => a.id == address.id);
    if (index != -1) {
      _addresses[index] = address;
      return address;
    } else {
      throw Exception('Address not found');
    }
  }

  Future<void> deleteAddress(String addressId) async {
    await Future.delayed(const Duration(milliseconds: 300));
    _addresses.removeWhere((a) => a.id == addressId);
  }
}
