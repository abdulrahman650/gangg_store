import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/repos/product_details_repository.dart';
import 'product_details_state.dart';

class ProductDetailsCubit extends Cubit<ProductDetailsState> {
  final ProductDetailsRepository _repository;

  ProductDetailsCubit(this._repository) : super(ProductDetailsInitial());

  Future<void> fetchProductDetails(String id) async {
    emit(ProductDetailsLoading());
    try {
      final product = await _repository.getProductDetails(id);
      emit(ProductDetailsLoaded(product: product));
    } catch (e) {
      emit(ProductDetailsError(e.toString()));
    }
  }

  void incrementQuantity() {
    if (state is ProductDetailsLoaded) {
      final current = state as ProductDetailsLoaded;
      if (current.quantity < current.product.stock) {
        emit(current.copyWith(quantity: current.quantity + 1));
      }
    }
  }

  void decrementQuantity() {
    if (state is ProductDetailsLoaded) {
      final current = state as ProductDetailsLoaded;
      if (current.quantity > 1) {
        emit(current.copyWith(quantity: current.quantity - 1));
      }
    }
  }

  void toggleFavorite() {
    // TODO: Implement favorite toggle
  }

  void addToCart() {
    // TODO: Implement add to cart
  }
}