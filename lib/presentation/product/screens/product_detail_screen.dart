import 'package:e_commerce_app/core/utils/utils.dart';
import 'package:e_commerce_app/domain/cart/entities/cart_entity.dart';
import 'package:e_commerce_app/presentation/cart/providers/cart_providers.dart';
import 'package:e_commerce_app/presentation/cart/screens/single_item_checkout_screen.dart';
import 'package:e_commerce_app/presentation/product/widgets/product_detail_shimmer_loading.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce_app/presentation/product/providers/product_detail_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductDetailScreen extends ConsumerStatefulWidget {
  final int productId;

  const ProductDetailScreen({super.key, required this.productId});

  @override
  ConsumerState<ProductDetailScreen> createState() =>
      _ProductDetailScreenState();
}

class _ProductDetailScreenState extends ConsumerState<ProductDetailScreen> {
  int _quantity = 1;
  bool _isProcessingPayment = false;

  @override
  Widget build(BuildContext context) {
    final productAsync = ref.watch(productDetailProvider(widget.productId));
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Product Details"),
        centerTitle: true,
        backgroundColor: theme.colorScheme.surface,
        elevation: 0,
      ),
      body: productAsync.when(
        data: (product) {
          return Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Hero Image
                      Hero(
                        tag: 'product-image-${product.id}',
                        child: CachedNetworkImage(
                          imageUrl: product.imageUrl ?? '',
                          fit: BoxFit.cover,
                          height: 300,
                          placeholder:
                              (context, url) => Container(
                                color:
                                    Theme.of(
                                      context,
                                    ).colorScheme.surfaceContainerHigh,
                                height: 300,
                              ),
                          errorWidget:
                              (context, url, error) => Container(
                                color:
                                    Theme.of(
                                      context,
                                    ).colorScheme.surfaceContainerHigh,
                                height: 300,
                                child: const Icon(
                                  Icons.image_not_supported,
                                  size: 48,
                                ),
                              ),
                        ),
                      ),

                      // Details Section
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Name
                            Text(
                              product.name,
                              style: theme.textTheme.headlineSmall?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            // ✅ Brand
                            if (product.brand != null &&
                                product.brand!.isNotEmpty) ...[
                              const SizedBox(height: 4),
                              Text(
                                "by ${product.brand}",
                                style: theme.textTheme.bodyMedium?.copyWith(
                                  color:
                                      Theme.of(
                                        context,
                                      ).colorScheme.onSurfaceVariant,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                            ],

                            const SizedBox(height: 8),

                            // Price
                            Text(
                              "\$${product.price.toStringAsFixed(2)}",
                              style: theme.textTheme.headlineMedium?.copyWith(
                                color: theme.colorScheme.primary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            const SizedBox(height: 16),

                            // Stock & Ratings
                            Row(
                              children: [
                                Icon(
                                  Icons.star,
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                  size: 20,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  "4.5 (200 reviews)",
                                  style: theme.textTheme.bodyMedium,
                                ),
                                const Spacer(),
                                Text(
                                  product.stockQuantity != null &&
                                          product.stockQuantity! > 0
                                      ? "In Stock"
                                      : "Out of Stock",
                                  style: TextStyle(
                                    color:
                                        product.stockQuantity != null &&
                                                product.stockQuantity! > 0
                                            ? Theme.of(
                                              context,
                                            ).colorScheme.tertiary
                                            : Theme.of(
                                              context,
                                            ).colorScheme.error,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 20),

                            // Quantity Selector
                            Row(
                              children: [
                                const Text(
                                  "Quantity:",
                                  style: TextStyle(fontSize: 16),
                                ),
                                const SizedBox(width: 12),
                                Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color:
                                          Theme.of(context).colorScheme.outline,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      IconButton(
                                        icon: const Icon(Icons.remove),
                                        onPressed: () {
                                          if (_quantity > 1) {
                                            setState(() {
                                              _quantity--;
                                            });
                                          }
                                        },
                                      ),
                                      Text(
                                        "$_quantity",
                                        style: const TextStyle(fontSize: 16),
                                      ),
                                      IconButton(
                                        icon: const Icon(Icons.add),
                                        onPressed: () {
                                          setState(() {
                                            _quantity++;
                                          });
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 20),

                            // Description
                            const Text(
                              "Description",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              product.description ??
                                  "No description available.",
                              style: theme.textTheme.bodyMedium?.copyWith(
                                height: 1.4,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Sticky Bottom Buttons
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: theme.colorScheme.surface,
                  boxShadow: [
                    BoxShadow(
                      color: Theme.of(
                        context,
                      ).colorScheme.shadow.withOpacity(0.05),
                      blurRadius: 8,
                      offset: const Offset(0, -2),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () {
                          ref
                              .read(cartNotifierProvider.notifier)
                              .addToCart(product.id, _quantity);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                "Added to Cart",
                                style: TextStyle(
                                  color:
                                      Theme.of(context).colorScheme.onPrimary,
                                  fontSize: 14.sp,
                                ),
                              ),
                              backgroundColor:
                                  Theme.of(context).colorScheme.primary,
                              behavior: SnackBarBehavior.floating,
                              margin: EdgeInsets.all(12.w),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16.r),
                              ),
                              duration: const Duration(seconds: 2),
                            ),
                          );
                        },
                        icon: const Icon(Icons.add_shopping_cart),
                        label: const Text("Add to Cart"),
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          textStyle: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          final item = CartItem(
                            id: product.id,
                            productId: product.id,
                            name: product.name,
                            price: product.price,
                            quantity: _quantity,
                            imageUrl: product.imageUrl,
                          );
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder:
                                  (context) =>
                                      SingleItemCheckoutScreen(item: item),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              Theme.of(context).colorScheme.primary,
                          foregroundColor:
                              Theme.of(context).colorScheme.onPrimary,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          textStyle: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        child:
                            _isProcessingPayment
                                ? SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    valueColor: AlwaysStoppedAnimation(
                                      theme.colorScheme.onPrimary,
                                    ),
                                  ),
                                )
                                : const Text("Buy Now"),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
        loading: () => const ProductDetailShimmerLoading(),
        error: (error, _) => Center(child: Text('Error: $error')),
      ),
    );
  }
}
