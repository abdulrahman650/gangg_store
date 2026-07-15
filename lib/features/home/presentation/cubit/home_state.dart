import 'package:equatable/equatable.dart';
import 'package:gangg_store/features/home/data/model/offer_model.dart';
import 'package:gangg_store/features/home/data/model/product_model.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object?> get props => [];
}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeSuccess extends HomeState {
  final List<ProductModel> products;
  final List<OfferModel> offers;
  final bool hasMoreProducts;

  const HomeSuccess({
    required this.products,
    required this.offers,
    this.hasMoreProducts = false,
  });

  HomeSuccess copyWith({
    List<ProductModel>? products,
    List<OfferModel>? offers,
    bool? hasMoreProducts,
  }) {
    return HomeSuccess(
      products: products ?? this.products,
      offers: offers ?? this.offers,
      hasMoreProducts: hasMoreProducts ?? this.hasMoreProducts,
    );
  }

  @override
  List<Object?> get props => [products, offers, hasMoreProducts];
}

class HomeError extends HomeState {
  final String message;

  const HomeError(this.message);

  @override
  List<Object?> get props => [message];
}

class ProductDetailsLoading extends HomeState {}

class ProductDetailsSuccess extends HomeState {
  final ProductModel product;

  const ProductDetailsSuccess(this.product);

  @override
  List<Object?> get props => [product];
}

class ProductDetailsError extends HomeState {
  final String message;

  const ProductDetailsError(this.message);

  @override
  List<Object?> get props => [message];
}