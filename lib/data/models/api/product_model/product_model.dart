class ProductModel {
  final int id;
  final int categoryId;
  final String name;
  final int price;
  final String imageUrl;
  final String description;

  ProductModel({
    required this.id,
    required this.categoryId,
    required this.name,
    required this.price,
    required this.imageUrl,
    required this.description,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json["id"] ?? 0,
      categoryId: json["category_id"] ?? 0,
      name: json["name"] ?? "",
      price: json["price"] ?? 0,
      imageUrl: json["image_url"] ?? "",
      description: json["description"] ?? "",
    );
  }
}

