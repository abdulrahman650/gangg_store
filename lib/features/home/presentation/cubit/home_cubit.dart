import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/model/offers_response_model.dart';
import '../../data/model/products_response_model.dart';
import '../../data/repos/home_repository.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final HomeRepository _homeRepository;

  HomeCubit(this._homeRepository) : super(HomeInitial());

  Future<void> fetchHomeData() async {
    emit(HomeLoading());

    try {
      final results = await Future.wait<dynamic>([
        _homeRepository.getProducts(),
        _homeRepository.getOffers(),
      ]);

      final productsResponse = results[0] as ProductsResponseModel;
      final offersResponse = results[1] as OffersResponseModel;

      emit(
        HomeSuccess(
          products: productsResponse.items,
          offers: offersResponse.items,
          hasMoreProducts: productsResponse.hasNextPage,
        ),
      );
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