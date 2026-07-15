import 'package:equatable/equatable.dart';
import 'package:gangg_store/features/home/data/model/product_model.dart';
import 'package:gangg_store/features/reviews/data/model/review_response_model.dart';

abstract class ProductDetailsState extends Equatable {
  const ProductDetailsState();

  @override
  List<Object?> get props => [];

}

class ProductDetailsInitial extends ProductDetailsState {}

class ProductDetailsLoading extends ProductDetailsState {}

class ProductDetailsLoaded extends ProductDetailsState {
  final ProductModel product;
  final List<ProductModel> similarProducts;
  final ReviewsResponseModel? reviews;

  final int quantity;
  final bool isFavorite;

  const ProductDetailsLoaded({
    required this.product,
    required this.similarProducts,
    this.reviews,
    this.quantity = 1,
    this.isFavorite = false,
  });

  ProductDetailsLoaded copyWith({
    ProductModel? product,
    List<ProductModel>? similarProducts,
    ReviewsResponseModel? reviews,
    int? quantity,
    bool? isFavorite,
  }) {
    return ProductDetailsLoaded(
      product: product ?? this.product,
      similarProducts: similarProducts ?? this.similarProducts,
      reviews: reviews ?? this.reviews,
      quantity: quantity ?? this.quantity,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }

  double get totalPrice {
    final price = product.discountPercentage > 0
        ? product.discountedPrice
        : product.price;

    return price * quantity;
  }

  String get formattedTotalPrice =>
      '\$${totalPrice.toStringAsFixed(2)}';

  @override
  List<Object?> get props => [
    product,
    similarProducts,
    reviews,
    quantity,
    isFavorite,
  ];
}
class ProductDetailsError extends ProductDetailsState {
  final String message;

  const ProductDetailsError(this.message);

  @override
  List<Object?> get props => [message];
}