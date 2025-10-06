
import 'package:e_commerce_app/presentation/profile/providers/address_provider.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce_app/presentation/profile/screens/add_address_screen.dart';
import 'package:e_commerce_app/presentation/profile/screens/edit_address_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SavedAddressesScreen extends ConsumerStatefulWidget {
  const SavedAddressesScreen({super.key});

  @override
  _SavedAddressesScreenState createState() => _SavedAddressesScreenState();
}

class _SavedAddressesScreenState extends ConsumerState<SavedAddressesScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => ref.read(addressNotifierProvider.notifier).fetchAddresses());
  }

  @override
  Widget build(BuildContext context) {
    final addressState = ref.watch(addressNotifierProvider);
    final addresses = ref.watch(addressNotifierProvider.notifier).addresses;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Saved Addresses'),
      ),
      body: Builder(
        builder: (context) {
          if (addressState == AddressState.loading) {
            return const Center(child: CircularProgressIndicator());
          } else if (addressState == AddressState.error) {
            return Center(child: Text(ref.watch(addressNotifierProvider.notifier).errorMessage ?? 'An error occurred'));
          } else if (addresses.isEmpty) {
            return const Center(child: Text('No saved addresses found.'));
          } else {
            return ListView.builder(
              itemCount: addresses.length,
              itemBuilder: (context, index) {
                final address = addresses[index];
                return ListTile(
                  title: Text(address.street),
                  subtitle: Text('${address.city}, ${address.state} ${address.zipCode}'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (address.isDefault)
                        const Icon(Icons.check_circle, color: Colors.green),
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EditAddressScreen(address: address),
                            ),
                          );
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const Text('Delete Address'),
                              content: const Text(
                                  'Are you sure you want to delete this address?'),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: const Text('Cancel'),
                                ),
                                TextButton(
                                  onPressed: () {
                                    ref
                                        .read(addressNotifierProvider.notifier)
                                        .delete(address.id);
                                    Navigator.pop(context);
                                  },
                                  child: const Text('Delete'),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddAddressScreen(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
