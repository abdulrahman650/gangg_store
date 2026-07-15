import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/model/product_model.dart';
import '../../data/repos/category_repository.dart';
import 'category_stata.dart';
class CategoryCubit extends Cubit<CategoryState>{



  final CategoryRepository repository;



  CategoryCubit(
      this.repository,
      ) : super(CategoryInitial());





  Future<void> getCategories() async {


    emit(CategoryLoading());



    try{


      final categories =
      await repository.getCategories();



      emit(
        CategorySuccess(categories),
      );


    }catch(e){


      emit(
        CategoryFailure(
          e.toString(),
        ),
      );


    }


  }





  Future<void> getProducts({

    String? category,

  }) async {


    emit(CategoryLoading());



    try{


      final products =
      await repository.getProducts(
        category: category,
      );



      emit(
        ProductsSuccess(products),
      );


    }catch(e){


      emit(
        CategoryFailure(
          e.toString(),
        ),
      );


    }


  }



}