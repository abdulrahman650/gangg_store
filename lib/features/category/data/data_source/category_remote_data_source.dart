// features/category/data/datasource/category_remote_data_source.dart
import '../model/model.dart';
import '../model/product_model.dart';


abstract class CategoryRemoteDataSource {


  Future<List<CategoryModel>> getCategories();



  Future<List<ProductModel>> getProducts({
    String? category,
  });


}