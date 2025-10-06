
import 'package:e_commerce_app/data/profile/datasources/address_mock_datasource.dart';
import 'package:e_commerce_app/data/profile/models/address_model.dart';
import 'package:e_commerce_app/data/profile/repositories/address_repository_impl.dart';
import 'package:e_commerce_app/domain/profile/usecases/add_address.dart';
import 'package:e_commerce_app/domain/profile/usecases/delete_address.dart';
import 'package:e_commerce_app/domain/profile/usecases/get_addresses.dart';
import 'package:e_commerce_app/domain/profile/usecases/update_address.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum AddressState { initial, loading, loaded, error }

class AddressNotifier extends StateNotifier<AddressState> {
  final GetAddresses getAddresses;
  final AddAddress addAddress;
  final UpdateAddress updateAddress;
  final DeleteAddress deleteAddress;

  List<Address> addresses = [];
  String? errorMessage;

  AddressNotifier({
    required this.getAddresses,
    required this.addAddress,
    required this.updateAddress,
    required this.deleteAddress,
  }) : super(AddressState.initial);

  Future<void> fetchAddresses() async {
    try {
      state = AddressState.loading;
      addresses = await getAddresses();
      state = AddressState.loaded;
    } catch (e) {
      errorMessage = e.toString();
      state = AddressState.error;
    }
  }

  Future<void> add(Address address) async {
    try {
      await addAddress(address);
      await fetchAddresses();
    } catch (e) {
      errorMessage = e.toString();
      state = AddressState.error;
    }
  }

  Future<void> update(Address address) async {
    try {
      await updateAddress(address);
      await fetchAddresses();
    } catch (e) {
      errorMessage = e.toString();
      state = AddressState.error;
    }
  }

  Future<void> delete(String addressId) async {
    try {
      await deleteAddress(addressId);
      await fetchAddresses();
    } catch (e) {
      errorMessage = e.toString();
      state = AddressState.error;
    }
  }
}

final addressNotifierProvider = StateNotifierProvider<AddressNotifier, AddressState>((ref) {
  final dataSource = AddressMockDataSource();
  final repository = AddressRepositoryImpl(dataSource);
  return AddressNotifier(
    getAddresses: GetAddresses(repository),
    addAddress: AddAddress(repository),
    updateAddress: UpdateAddress(repository),
    deleteAddress: DeleteAddress(repository),
  );
});
