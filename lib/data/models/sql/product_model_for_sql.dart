class ProductModelFields {
  static const String id = "_id";
  static const String productId = "productId";
  static const String count = "count";
  static const String name = "name";
  static const String price = "price";
  static const String imageUrl = "image_url";
  static const String cartId = "cart_id";

  static const String productsTableName = "products";
}

class ProductModelSql {
  int? id;
  final int productId;
  final int count;
  final String name;
  final int price;
  final String imageUrl;
  final int cartId;

  ProductModelSql({
    this.id,
    required this.productId,
    required this.count,
    required this.name,
    required this.price,
    required this.imageUrl,
    required this.cartId
  });

  ProductModelSql copyWith(
      {int? id,
      int? productId,
      int? count,
      String? name,
      int? price,
      String? imageUrl,
      int? cartId
      }) {
    return ProductModelSql(
      id: id ?? this.id,
      productId: productId ?? this.productId,
      count: count ?? this.count,
      name: name ?? this.name,
      price: price ?? this.price,
      imageUrl: imageUrl ?? this.imageUrl,
      cartId: cartId ?? this.cartId
    );
  }

  factory ProductModelSql.fromJson(Map<String, dynamic> json){
    return ProductModelSql(
        id: json[ProductModelFields.id] ?? 0,
        productId: json[ProductModelFields.productId] ?? 0,
        count: json[ProductModelFields.count] ?? 0,
        name: json[ProductModelFields.name] ?? "",
        price: json[ProductModelFields.price] ?? 0,
        imageUrl: json[ProductModelFields.imageUrl] ?? "",
      cartId: json[ProductModelFields.cartId] ?? 0
    );
  }

  Map<String, dynamic> toJson(){
    return {
      ProductModelFields.productId:productId,
      ProductModelFields.count:count,
      ProductModelFields.name:name,
      ProductModelFields.price:price,
      ProductModelFields.imageUrl:imageUrl,
      ProductModelFields.cartId:cartId
    };
  }

  @override
  String toString() {
    return """
    ${ProductModelFields.id}: $id,
    ${ProductModelFields.productId}:$productId,
    ${ProductModelFields.count}:$count,
    ${ProductModelFields.name}:$name,
    ${ProductModelFields.price}:$price,
    ${ProductModelFields.imageUrl}:$imageUrl
    ${ProductModelFields.cartId}:$cartId
    """;
  }

}
