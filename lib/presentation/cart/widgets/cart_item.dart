import 'package:e_commerce_app/domain/cart/entities/cart_entity.dart';
import 'package:e_commerce_app/presentation/cart/providers/cart_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CartItemWidget extends ConsumerWidget {
  final CartItem item;

  const CartItemWidget({super.key, required this.item});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    return Card(
      child: ListTile(
        title: Text(item.name),
        trailing: Consumer(
          builder: (context, ref, _) {
            final cart = ref.watch(cartNotifierProvider).asData?.value;
            final currentItem = cart?.items.firstWhere((i) => i.productId == item.productId) ?? item;

            return Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Decrease
                IconButton(
                  icon: const Icon(Icons.remove),
                  onPressed: () => ref.read(cartNotifierProvider.notifier)
                      .updateCart(currentItem.productId, currentItem.quantity - 1),
                ),
                Text(currentItem.quantity.toString()),
                // Increase
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () => ref.read(cartNotifierProvider.notifier)
                      .updateCart(currentItem.productId, currentItem.quantity + 1),
                ),
                // Delete
                IconButton(
                  icon: const Icon(Icons.delete_outline, color: Colors.redAccent),
                  onPressed: () {
                    final removedItem = currentItem;
                    ref.read(cartNotifierProvider.notifier)
                        .removeFromCart(currentItem.productId);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: const Text('Item removed from cart'),
                        action: SnackBarAction(
                          label: 'Undo',
                          onPressed: () => ref.read(cartNotifierProvider.notifier)
                              .undoRemoveFromCart(removedItem),
                        ),
                      ),
                    );
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
