import 'package:equatable/equatable.dart';
import 'package:gangg_store/features/home/data/model/product_model.dart';

abstract class SearchState extends Equatable {
  const SearchState();

  @override
  List<Object?> get props => [];
}

class SearchInitial extends SearchState {}

class SearchLoading extends SearchState {}

class SearchLoaded extends SearchState {
  final List<ProductModel> allProducts;
  final List<ProductModel> filteredProducts;
  final String query;

  const SearchLoaded({
    required this.allProducts,
    required this.filteredProducts,
    required this.query,
  });

  @override
  List<Object?> get props => [
    allProducts,
    filteredProducts,
    query,
  ];
}

class SearchError extends SearchState {
  final String message;

  const SearchError(this.message);

  @override
  List<Object?> get props => [message];
}