import 'package:e_commerce_app/domain/product/entities/Product.dart';

abstract class ProductRepository {
  Future<List<ProductEntity>> getFeaturedProducts({int limit = 6});
}
