import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gangg_store/features/home/data/model/product_model.dart';

import '../../../home/data/repos/home_repository.dart';
import 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  final HomeRepository repository;

  SearchCubit(this.repository) : super(SearchInitial());

  List<ProductModel> _allProducts = [];

  Timer? _debounce;

  Future<void> loadProducts() async {
    emit(SearchLoading());

    try {
      final response = await repository.getProducts();

      _allProducts = response.items;

      emit(
        SearchLoaded(
          allProducts: _allProducts,
          filteredProducts: const [],
          query: '',
        ),
      );
    } catch (e) {
      emit(SearchError(e.toString()));
    }
  }

  void onSearchChanged(String value) {
    _debounce?.cancel();

    _debounce = Timer(const Duration(milliseconds: 300), () {
      search(value);
    });
  }

  void search(String query) {
    if (state is! SearchLoaded) return;

    if (query.trim().isEmpty) {
      emit(
        SearchLoaded(
          allProducts: _allProducts,
          filteredProducts: const [],
          query: '',
        ),
      );
      return;
    }

    final results = _allProducts.where((product) {
      return product.displayName
          .toLowerCase()
          .startsWith(query.toLowerCase());
    }).toList();

    emit(
      SearchLoaded(
        allProducts: _allProducts,
        filteredProducts: results,
        query: query,
      ),
    );
  }

  void clearSearch() {
    emit(
      SearchLoaded(
        allProducts: _allProducts,
        filteredProducts: const [],
        query: '',
      ),
    );
  }

  @override
  Future<void> close() {
    _debounce?.cancel();
    return super.close();
  }
}