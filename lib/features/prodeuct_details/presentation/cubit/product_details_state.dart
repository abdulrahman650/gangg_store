import 'package:equatable/equatable.dart';
import 'package:gangg_store/features/home/data/model/product_model.dart';

abstract class ProductDetailsState extends Equatable {
  const ProductDetailsState();

  @override
  List<Object?> get props => [];
}

class ProductDetailsInitial extends ProductDetailsState {}

class ProductDetailsLoading extends ProductDetailsState {}

class ProductDetailsLoaded extends ProductDetailsState {
  final ProductModel product; // <-- غيرت من ProductDetailsModel لـ ProductModel
  final int quantity;

  const ProductDetailsLoaded({
    required this.product,
    this.quantity = 1,
  });

  ProductDetailsLoaded copyWith({
    ProductModel? product,
    int? quantity,
  }) {
    return ProductDetailsLoaded(
      product: product ?? this.product,
      quantity: quantity ?? this.quantity,
    );
  }

  double get totalPrice {
    final price = product.discountPercentage > 0
        ? product.discountedPrice
        : product.price;
    return price * quantity;
  }

  String get formattedTotalPrice => '\$${totalPrice.toStringAsFixed(2)}';

  @override
  List<Object?> get props => [product, quantity];
}

class ProductDetailsError extends ProductDetailsState {
  final String message;

  const ProductDetailsError(this.message);

  @override
  List<Object?> get props => [message];
}