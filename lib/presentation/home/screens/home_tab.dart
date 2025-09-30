import 'package:e_commerce_app/presentation/cart/widgets/cart_icon.dart';
import 'package:e_commerce_app/presentation/profile/widgets/shimmer_loading.dart';
import 'package:e_commerce_app/domain/categories/entities/category_entity.dart';
import 'package:e_commerce_app/presentation/product/screens/products_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../categories/providers/category_provider.dart';

class HomeTab extends ConsumerWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categoriesAsync = ref.watch(categoriesProvider);

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surface,
        scrolledUnderElevation: 0,
        shadowColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        title: const Text('Shop by Category'),
        centerTitle: true,
        elevation: 0,
        actions: const [CartIcon()],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          ref.refresh(categoriesProvider);
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder:
                                      (_) => ProductsScreen(
                                        categoryId: category.id,
                                        categoryName: category.name,
                                      ),
                                ),
                              );
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                gradient: LinearGradient(
                                  colors: [
                                    Theme.of(
                                      context,
                                    ).colorScheme.primaryContainer,
                                    Theme.of(context).colorScheme.primary,
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.shadow.withOpacity(0.1),
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
                                      child: CachedNetworkImage(
                                        imageUrl: category.imageUrl ?? '',
                                        fit: BoxFit.cover,
                                        placeholder:
                                            (context, url) => Container(
                                              color:
                                                  Theme.of(
                                                    context,
                                                  ).colorScheme.surfaceVariant,
                                            ),
                                        errorWidget:
                                            (context, url, error) => Container(
                                              color:
                                                  Theme.of(
                                                    context,
                                                  ).colorScheme.surfaceVariant,
                                              child: const Icon(
                                                Icons.image_not_supported,
                                                size: 48,
                                              ),
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
                                          style: Theme.of(
                                            context,
                                          ).textTheme.titleMedium?.copyWith(
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
                                              style:
                                                  Theme.of(
                                                    context,
                                                  ).textTheme.bodyMedium,
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
                loading:
                    () => const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: ShimmerLoading(),
                    ),
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
