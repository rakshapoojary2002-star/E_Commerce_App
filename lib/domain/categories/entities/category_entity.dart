class CategoryEntity {
  final int id;
  final String name;
  final String? description;
  final String? imageUrl; // Make sure this exists

  const CategoryEntity({
    required this.id,
    required this.name,
    this.description,
    this.imageUrl,
  });
}
