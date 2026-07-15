// features/category/presentation/cubit/category_state.dart
import '../../data/model/model.dart';
import '../../data/model/product_model.dart';



abstract class CategoryState {}



class CategoryInitial extends CategoryState {}



class CategoryLoading extends CategoryState {}



class CategorySuccess extends CategoryState {


  final List<CategoryModel> categories;


  CategorySuccess(this.categories);


}



class CategoryFailure extends CategoryState {


  final String error;


  CategoryFailure(this.error);


}




class ProductsSuccess extends CategoryState {


  final List<ProductModel> products;


  ProductsSuccess(this.products);


}