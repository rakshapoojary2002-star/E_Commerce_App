import 'package:e_commerce_app/presentation/cart/providers/cart_provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce_app/presentation/product/providers/product_detail_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductDetailScreen extends ConsumerWidget {
  final int productId;

  const ProductDetailScreen({super.key, required this.productId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productAsync = ref.watch(productDetailProvider(productId));
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Product Details", style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: theme.colorScheme.surface,
        elevation: 0,
      ),
      body: productAsync.when(
        data: (product) {
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Hero(
                  tag: 'product-image-${product.id}',
                  child: CachedNetworkImage(
                    imageUrl: product.imageUrl ?? '',
                    fit: BoxFit.cover,
                    height: 300,
                    placeholder: (context, url) =>
                        Container(color: Colors.grey.shade200, height: 300),
                    errorWidget: (context, url, error) => Container(
                      color: Colors.grey.shade200,
                      height: 300,
                      child: const Icon(
                        Icons.image_not_supported,
                        size: 48,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.name,
                        style: theme.textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        "\$${product.price.toStringAsFixed(2)}",
                        style: theme.textTheme.headlineSmall?.copyWith(
                          color: theme.colorScheme.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton.icon(
                        onPressed: () {
                          ref.read(cartProvider.notifier).addToCart(product.id, 1);
                        },
                        icon: const Icon(Icons.shopping_cart_checkout),
                        label: const Text('Add to Cart'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: theme.colorScheme.primary,
                          foregroundColor: theme.colorScheme.onPrimary,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          textStyle: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(child: Text('Error: $error')),
      ),
    );
  }
}