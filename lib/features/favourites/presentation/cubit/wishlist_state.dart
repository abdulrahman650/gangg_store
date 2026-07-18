import 'package:equatable/equatable.dart';
import 'package:gangg_store/features/home/data/model/product_model.dart';

abstract class WishlistState extends Equatable {
  const WishlistState();

  @override
  List<Object?> get props => [];
}

class WishlistInitial extends WishlistState {}

class WishlistLoading extends WishlistState {}

class WishlistSuccess extends WishlistState {
  final List<ProductModel> favorites;

  const WishlistSuccess(this.favorites);

  @override
  List<Object?> get props => [favorites];
}

class WishlistError extends WishlistState {
  final String message;

  const WishlistError(this.message);

  @override
  List<Object?> get props => [message];
}

class FavoriteToggled extends WishlistState {
  final String productId;
  final bool isFavorite;

  const FavoriteToggled(this.productId, this.isFavorite);

  @override
  List<Object?> get props => [productId, isFavorite];
}
