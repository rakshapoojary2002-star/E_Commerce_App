import 'package:e_commerce_app/domain/categories/entities/category_entity.dart';
import 'package:e_commerce_app/domain/product/entities/Product.dart';
import 'package:e_commerce_app/presentation/products/providers/featuredProductsProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../categories/providers/category_provider.dart';

class HomeTab extends ConsumerWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categoriesAsync = ref.watch(categoriesProvider);
    final featuredProductsAsync = ref.watch(featuredProductsProvider(6));

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Shop by Category',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          ref.refresh(categoriesProvider);
          ref.refresh(featuredProductsProvider(6));
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Featured Products Carousel
              featuredProductsAsync.when(
                data: (products) {
                  if (products.isEmpty) return const SizedBox.shrink();
                  return SizedBox(
                    height: 220,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.all(16),
                      itemCount: products.length,
                      itemBuilder: (context, index) {
                        final ProductEntity product = products[index];
                        return Container(
                          width: 150,
                          margin: const EdgeInsets.only(right: 12),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.05),
                                blurRadius: 8,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Expanded(
                                child: ClipRRect(
                                  borderRadius: const BorderRadius.vertical(
                                    top: Radius.circular(16),
                                  ),
                                  child: CachedNetworkImage(
                                    imageUrl: product.imageUrl,
                                    fit: BoxFit.cover,
                                    placeholder:
                                        (context, url) => const Center(
                                          child: CircularProgressIndicator(),
                                        ),
                                    errorWidget:
                                        (context, url, error) => Container(
                                          color: Colors.grey.shade200,
                                          child: const Icon(
                                            Icons.shopping_bag,
                                            size: 48,
                                          ),
                                        ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      product.name,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    Text(
                                      "\$${product.price.toStringAsFixed(2)}",
                                      style: const TextStyle(
                                        color: Colors.green,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  );
                },
                loading: () => const Center(child: CircularProgressIndicator()),
                error:
                    (error, _) =>
                        Center(child: Text("Featured Products Error: $error")),
              ),

              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Text(
                  "Categories",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),

              // Categories Grid
              categoriesAsync.when(
                data:
                    (categories) => Padding(
                      padding: const EdgeInsets.all(16),
                      child: GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: categories.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 16,
                              mainAxisSpacing: 16,
                              childAspectRatio: 0.75,
                            ),
                        itemBuilder: (context, index) {
                          final CategoryEntity category = categories[index];
                          return GestureDetector(
                            onTap: () {
                              // TODO: Navigate to Products Screen for this category
                              // Navigator.push(context, MaterialPageRoute(
                              //   builder: (_) => ProductsScreen(categoryId: category.id),
                              // ));
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                gradient: LinearGradient(
                                  colors: [
                                    Colors.orange.shade50,
                                    Colors.orange.shade100,
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.06),
                                    blurRadius: 10,
                                    offset: const Offset(0, 5),
                                  ),
                                ],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Expanded(
                                    child: ClipRRect(
                                      borderRadius: const BorderRadius.vertical(
                                        top: Radius.circular(20),
                                      ),
                                      child:
                                          category.imageUrl != null
                                              ? CachedNetworkImage(
                                                imageUrl: category.imageUrl!,
                                                fit: BoxFit.cover,
                                                placeholder:
                                                    (context, url) => Container(
                                                      color:
                                                          Colors.grey.shade200,
                                                    ),
                                                errorWidget:
                                                    (context, url, error) =>
                                                        Container(
                                                          color:
                                                              Colors
                                                                  .grey
                                                                  .shade200,
                                                          child: const Icon(
                                                            Icons.category,
                                                            size: 48,
                                                          ),
                                                        ),
                                              )
                                              : Container(
                                                color: Colors.grey.shade200,
                                                child: const Icon(
                                                  Icons.category,
                                                  size: 48,
                                                ),
                                              ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(12),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          category.name,
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        if (category.description != null &&
                                            category.description!.isNotEmpty)
                                          Padding(
                                            padding: const EdgeInsets.only(
                                              top: 4,
                                            ),
                                            child: Text(
                                              category.description!,
                                              style: TextStyle(
                                                fontSize: 13,
                                                color: Colors.grey.shade700,
                                              ),
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                loading: () => const Center(child: CircularProgressIndicator()),
                error:
                    (error, _) => Center(
                      child: Text(
                        "Categories Error: $error",
                        textAlign: TextAlign.center,
                      ),
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
