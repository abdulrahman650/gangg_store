import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gangg_store/core/services/service_locators.dart';
import 'package:gangg_store/features/cart/presentation/cubit/cart_cubit.dart';
import '../../../home/data/model/product_model.dart';
import '../../data/repos/product_details_repository.dart';
import 'product_details_state.dart';
import 'package:gangg_store/features/reviews/data/repos/review_repository.dart';

class ProductDetailsCubit extends Cubit<ProductDetailsState> {
  final ProductDetailsRepository _repository;
  final ReviewRepository _reviewRepository;

  ProductDetailsCubit(
      this._repository,
      this._reviewRepository,
      ) : super(ProductDetailsInitial());

  Future<void> fetchProductDetails(String id) async {
    emit(ProductDetailsLoading());
    try {
      final product = await _repository.getProductDetails(id);

      final products = await _repository.getProducts();

      final similarProducts = products.where((e) {
        if (e.id == product.id) return false;

        if (product.categories.isEmpty) return true;

        return e.categories.any(
              (category) => product.categories.contains(category),
        );
      }).toList();

      final reviews = await _reviewRepository.getReviews(
        productId: product.id,
        page: 1,
        pageSize: 10,
      );

      emit(
        ProductDetailsLoaded(
          product: product,
          similarProducts: similarProducts,
          reviews: reviews,
        ),
      );
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
    if (state is ProductDetailsLoaded) {
      final current = state as ProductDetailsLoaded;
      emit(current.copyWith(isFavorite: !current.isFavorite));
    }
  }

  void addToCart() {
    if (state is ProductDetailsLoaded) {
      final current = state as ProductDetailsLoaded;

      final cartCubit = getIt<CartCubit>();

      cartCubit.addToCart(
        productId: current.product.id,
        quantity: current.quantity,
      );
    }
  }

  Future<void> setProductDirectly(ProductModel product) async {

    final products = await _repository.getProducts();

    final similarProducts = products.where((e) {
      if (e.id == product.id) return false;

      if (product.categories.isEmpty) return true;

      return e.categories.any(
            (category) => product.categories.contains(category),
      );
    }).toList();

    final reviews = await _reviewRepository.getReviews(
      productId: product.id,
      page: 1,
      pageSize: 10,
    );

    emit(
      ProductDetailsLoaded(
        product: product,
        similarProducts: similarProducts,
        reviews: reviews,
      ),
    );
  }
}