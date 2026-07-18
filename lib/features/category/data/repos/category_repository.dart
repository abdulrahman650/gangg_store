// features/category/data/repos/repo.dart
import '../data_source/category_remote_data_source.dart';
import '../model/model.dart';
import '../model/product_model.dart';



abstract class CategoryRepository {


  Future<List<CategoryModel>> getCategories();



  Future<List<ProductModel>> getProducts({

    String? category,

  });


}





class CategoryRepositoryImpl
    implements CategoryRepository {



  final CategoryRemoteDataSource remoteDataSource;



  CategoryRepositoryImpl(
      this.remoteDataSource,
      );




  @override
  Future<List<CategoryModel>> getCategories() async {


    return await remoteDataSource.getCategories();


  }






  @override
  Future<List<ProductModel>> getProducts({

    String? category,

  }) async {


    return await remoteDataSource.getProducts(

      category: category,

    );


  }



}