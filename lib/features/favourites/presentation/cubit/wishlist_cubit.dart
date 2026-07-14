import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gangg_store/features/home/data/model/product_model.dart';
import 'wishlist_state.dart';

class WishlistCubit extends Cubit<WishlistState> {
  final Map<String, bool> _favorites = {};
  final List<ProductModel> _favoriteProducts = [];

  WishlistCubit() : super(WishlistInitial());

  void initializeFromProducts(List<ProductModel> products) {
    _favorites.clear();

    for (final product in products) {
      _favorites[product.id] = false;
    }

    emit(WishlistSuccess(List.from(_favoriteProducts)));
  }

  void toggleFavorite(ProductModel product) {
    final isFavorite = _favorites[product.id] ?? false;

    _favorites[product.id] = !isFavorite;

    if (!isFavorite) {
      if (!_favoriteProducts.any((p) => p.id == product.id)) {
        _favoriteProducts.add(product);
      }
    } else {
      _favoriteProducts.removeWhere((p) => p.id == product.id);
    }

    emit(FavoriteToggled(product.id, !isFavorite));
    emit(WishlistSuccess(List.from(_favoriteProducts)));
  }

  bool isFavorite(String productId) {
    return _favorites[productId] ?? false;
  }

  List<ProductModel> getFavorites() {
    return List.unmodifiable(_favoriteProducts);
  }

  void addFavorite(ProductModel product) {
    final isFavorite = _favorites[product.id] ?? false;

    if (!isFavorite) {
      _favorites[product.id] = true;

      if (!_favoriteProducts.any((p) => p.id == product.id)) {
        _favoriteProducts.add(product);
      }

      emit(WishlistSuccess(List.from(_favoriteProducts)));
    }
  }

  void removeFavorite(String productId) {
    final isFavorite = _favorites[productId] ?? false;

    if (isFavorite) {
      _favorites[productId] = false;
      _favoriteProducts.removeWhere((p) => p.id == productId);

      emit(WishlistSuccess(List.from(_favoriteProducts)));
    }
  }
}