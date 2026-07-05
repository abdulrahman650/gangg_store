
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gangg_store/features/search/cubit/search_state.dart';



class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(SearchInitial());
  // // SearchCubit(this._getProducts) : super(SearchInitial());
  //
  // // final GetProducts _getProducts;
  //
  // Future<void> searchProducts(String query) async {
  //   final trimmedQuery = query.trim();
  //
  //   if (trimmedQuery.isEmpty) {
  //     emit(SearchInitial());
  //     return;
  //   }
  //
  //   emit(SearchLoading());
  //
  //   final result = await _getProducts();
  //   result.fold(
  //     (failure) => emit(SearchError(failure.message)),
  //     (products) {
  //       // Apply client-side filtering and sorting for prefix matching
  //       final filteredProducts = _filterAndSortProducts(products, trimmedQuery);
  //
  //       if (filteredProducts.isEmpty) {
  //         emit(SearchEmpty());
  //       } else {
  //         emit(SearchSuccess(filteredProducts));
  //       }
  //     },
  //   );
  // }
  //
  // List<Product> _filterAndSortProducts(List<Product> products, String query) {
  //   final lowerQuery = query.toLowerCase();
  //
  //   // Separate products into prefix matches and contains matches
  //   final prefixMatches = <Product>[];
  //   final containsMatches = <Product>[];
  //
  //   for (final product in products) {
  //     final productName = product.title.toLowerCase();
  //
  //     if (productName.startsWith(lowerQuery)) {
  //       prefixMatches.add(product);
  //     } else if (productName.contains(lowerQuery)) {
  //       containsMatches.add(product);
  //     }
  //   }
  //
  //   // Sort prefix matches alphabetically
  //   prefixMatches.sort((a, b) => a.title.toLowerCase().compareTo(b.title.toLowerCase()));
  //
  //   // Sort contains matches alphabetically
  //   containsMatches.sort((a, b) => a.title.toLowerCase().compareTo(b.title.toLowerCase()));
  //
  //   // Return prefix matches first, then contains matches
  //   return [...prefixMatches, ...containsMatches];
  // }
  //
  // void clearSearch() {
  //   emit(SearchInitial());
  // }
}
