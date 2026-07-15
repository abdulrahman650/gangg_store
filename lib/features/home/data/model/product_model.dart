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


  // Fallback values
  static const String fallbackImageUrl =
      'https://images.unsplash.com/photo-1523275335684-37898b6baf30?w=600';
  static const String fallbackName = 'Luxury Product';
  static const double fallbackPrice = 0.0;

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
      id: json['id'] as String? ?? '',
      productCode: json['productCode'] as String? ?? '',
      name: json['name'] as String? ?? '',
      description: json['description'] as String?,
      arabicName: json['arabicName'] as String? ?? json['nameArabic'] as String?,
      arabicDescription: json['arabicDescription'] as String? ?? json['descriptionArabic'] as String?,
      coverPictureUrl: json['coverPictureUrl'] as String? ?? fallbackImageUrl,
      productPictures: (json['productPictures'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
          [],
      price: (json['price'] as num?)?.toDouble() ?? fallbackPrice,
      stock: json['stock'] as int? ?? 0,
      weight: (json['weight'] as num?)?.toDouble() ?? 0.0,
      color: json['color'] as String? ?? 'Unknown',
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      reviewsCount: json['reviewsCount'] as int? ?? 0,
      discountPercentage: (json['discountPercentage'] as num?)?.toDouble() ?? 0.0,
      sellerId: json['sellerId'] as String? ?? '',
      categories: (json['categories'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
          [],
    );
  }
  /// Safe display name - validates bad names
  String get displayName {
    final trimmed = name.trim();
    // Reject short/bad names
    if (trimmed.length < 3 ||
        trimmed == 's' ||
        trimmed == 'd' ||
        trimmed.toLowerCase() == 'test' ||
        trimmed.toLowerCase() == 'new' ||
        RegExp(r'^[a-z]$').hasMatch(trimmed)) {
      return fallbackName;
    }
    return trimmed;
  }

  /// Safe price display
  String get displayPrice {
    if (price <= 0 || price.isNaN) return '\$0.00';
    return '\$${price.toStringAsFixed(2)}';
  }

  /// Safe discounted price display
  String get displayDiscountedPrice {
    if (price <= 0 || discountPercentage <= 0) return displayPrice;
    final discounted = price * (1 - discountPercentage / 100);
    return '\$${discounted.toStringAsFixed(2)}';
  }

  double get discountedPrice {
    if (price <= 0) return 0;
    return price * (1 - discountPercentage / 100);
  }

  String get formattedPrice => displayPrice;
  String get formattedDiscountedPrice => displayDiscountedPrice;
  String get imageUrl => coverPictureUrl.isNotEmpty ? coverPictureUrl : fallbackImageUrl;
}