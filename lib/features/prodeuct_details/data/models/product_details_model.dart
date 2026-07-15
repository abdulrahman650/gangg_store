import 'package:gangg_store/features/home/data/model/product_model.dart';

class ProductDetailsModel extends ProductModel {
  // productPictures و categories موجودين في ProductModel بالفعل
  // مش محتاجين نعرفهم تاني هنا

  ProductDetailsModel({
    required super.id,
    required super.productCode,
    required super.name,
    super.description,
    super.arabicName,
    super.arabicDescription,
    required super.coverPictureUrl,
    super.productPictures,
    required super.price,
    required super.stock,
    required super.weight,
    required super.color,
    required super.rating,
    required super.reviewsCount,
    required super.discountPercentage,
    required super.sellerId,
    super.categories,
  });

  factory ProductDetailsModel.fromJson(Map<String, dynamic> json) {
    return ProductDetailsModel(
      id: json['id'] as String,
      productCode: json['productCode'] as String,
      name: json['name'] as String,
      description: json['description'] as String?,
      arabicName: json['nameArabic'] as String?,
      arabicDescription: json['descriptionArabic'] as String?,
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
}