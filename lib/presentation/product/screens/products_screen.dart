import 'package:e_commerce_app/presentation/widgets/product_list_shimmer.dart';
import 'package:e_commerce_app/presentation/product/screens/product_detail_screen.dart';
import 'package:e_commerce_app/domain/product/entities/product_entity.dart';
import 'package:e_commerce_app/presentation/product/providers/products_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ProductsScreen extends ConsumerWidget {
  final int categoryId;
  final String categoryName;

  const ProductsScreen({
    super.key,
    required this.categoryId,
    required this.categoryName,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productsAsync = ref.watch(productsByCategoryProvider(categoryId));
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(categoryName, style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: theme.colorScheme.surface,
        elevation: 0,
      ),
      body: productsAsync.when(
        data: (products) {
          if (products.isEmpty) {
            return const Center(child: Text("No products available"));
          }

          return ListView.separated(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
            itemCount: products.length,
            separatorBuilder: (context, index) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final ProductEntity product = products[index];
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          ProductDetailScreen(productId: product.id),
                    ),
                  );
                },
                child: Card(
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 120,
                        height: 120,
                        child: CachedNetworkImage(
                          imageUrl: product.imageUrl ?? '',
                          fit: BoxFit.cover,
                          placeholder: (context, url) =>
                              Container(color: Colors.grey.shade200),
                          errorWidget: (context, url, error) => Container(
                            color: Colors.grey.shade200,
                            child: const Icon(
                              Icons.image_not_supported,
                              size: 40,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                product.name,
                                style: theme.textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 8),
                              Text(
                                "\$${product.price.toStringAsFixed(2)}",
                                style: theme.textTheme.titleLarge?.copyWith(
                                  color: theme.colorScheme.primary,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
        loading: () => const ProductListShimmer(),
        error: (error, _) => Center(child: Text("Error: $error")),
      ),
    );
  }
}
