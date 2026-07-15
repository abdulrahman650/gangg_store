import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/repos/home_repository.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final HomeRepository _homeRepository;

  HomeCubit(this._homeRepository) : super(HomeInitial());

  Future<void> fetchHomeData() async {
    emit(HomeLoading());
    try {
      final productsResponse = await _homeRepository.getProducts();
      final offersResponse = await _homeRepository.getOffers();

      emit(HomeSuccess(
        products: productsResponse.items,
        offers: offersResponse.items,
        hasMoreProducts: productsResponse.hasNextPage,
      ));
    } catch (e) {
      emit(HomeError(e.toString()));
    }
  }

  Future<void> refreshHomeData() async {
    await fetchHomeData();
  }

  Future<void> fetchProductDetails(String productId) async {
    emit(ProductDetailsLoading());
    try {
      final product = await _homeRepository.getProductById(productId);
      emit(ProductDetailsSuccess(product));
    } catch (e) {
      emit(ProductDetailsError(e.toString()));
    }
  }
}