class ProductModel {
  final String id;
  final String productCode;
  final String name;
  final String? description;
  final String? arabicName;
  final String? arabicDescription;
  final String coverPictureUrl;
  final List<String> productPictures; // <-- غيرت من nullable لـ non-nullable
  final double price;
  final int stock;
  final double weight;
  final String color;
  final double rating;
  final int reviewsCount;
  final double discountPercentage;
  final String sellerId;
  final List<String> categories; // <-- غيرت من nullable لـ non-nullable

  ProductModel({
    required this.id,
    required this.productCode,
    required this.name,
    this.description,
    this.arabicName,
    this.arabicDescription,
    required this.coverPictureUrl,
    this.productPictures = const [], // <-- default empty list
    required this.price,
    required this.stock,
    required this.weight,
    required this.color,
    required this.rating,
    required this.reviewsCount,
    required this.discountPercentage,
    required this.sellerId,
    this.categories = const [], // <-- default empty list
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'] as String,
      productCode: json['productCode'] as String,
      name: json['name'] as String,
      description: json['description'] as String?,
      arabicName: json['arabicName'] as String? ?? json['nameArabic'] as String?,
      arabicDescription: json['arabicDescription'] as String? ?? json['descriptionArabic'] as String?,
      coverPictureUrl: json['coverPictureUrl'] as String,
      productPictures: (json['productPictures'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      price: (json['price'] as num).toDouble(),
      stock: json['stock'] as int,
      weight: (json['weight'] as num).toDouble(),
      color: json['color'] as String,
      rating: (json['rating'] as num).toDouble(),
      reviewsCount: json['reviewsCount'] as int,
      discountPercentage: (json['discountPercentage'] as num).toDouble(),
      sellerId: json['sellerId'] as String,
      categories: (json['categories'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'productCode': productCode,
      'name': name,
      'description': description,
      'arabicName': arabicName,
      'arabicDescription': arabicDescription,
      'coverPictureUrl': coverPictureUrl,
      'productPictures': productPictures,
      'price': price,
      'stock': stock,
      'weight': weight,
      'color': color,
      'rating': rating,
      'reviewsCount': reviewsCount,
      'discountPercentage': discountPercentage,
      'sellerId': sellerId,
      'categories': categories,
    };
  }

  double get discountedPrice {
    return price * (1 - discountPercentage / 100);
  }

  String get formattedPrice => '\$${price.toStringAsFixed(2)}';
  String get formattedDiscountedPrice => '\$${discountedPrice.toStringAsFixed(2)}';
}