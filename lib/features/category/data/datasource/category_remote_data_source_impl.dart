// features/category/data/datasource/category_remote_data_source_impl.dart
import '../../../../core/network/api_consumer.dart';
import '../../../../core/network/api_endpoints.dart';

import '../model/model.dart';
import '../model/product_model.dart';

import 'category_remote_data_source.dart';



class CategoryRemoteDataSourceImpl
    implements CategoryRemoteDataSource {



  final ApiConsumer apiConsumer;



  CategoryRemoteDataSourceImpl(
    this.apiConsumer,
  );



  @override
  Future<List<CategoryModel>> getCategories() async {


    final dynamic response =
        await apiConsumer.get(
          EndPoints.categories,
        );



    List<dynamic> categoriesData = [];



    if(response is List){


      if(response.isEmpty){

        return [];

      }



      final firstItem = response.first;



      if(firstItem is Map &&
          firstItem['categories'] is List){


        categoriesData =
        firstItem['categories'];

      }

      else{

        categoriesData = response;

      }


    }



    else if(response is Map){


      final data =
          response['categories'] ??
          response['data'];



      if(data is List){

        categoriesData = data;

      }


    }



    else{


      throw const FormatException(
        'Invalid categories response',
      );


    }




    return categoriesData.map<CategoryModel>(

        (item)=>CategoryModel.fromJson(
          Map<String,dynamic>.from(item),
        )

    ).toList();


  }






  @override
  Future<List<ProductModel>> getProducts({

    String? category,

  }) async {



    final dynamic response =
        await apiConsumer.get(
          EndPoints.products,
        );



    final List data =
        response['items'];



    List<ProductModel> products =
    data.map(

          (e)=>ProductModel.fromJson(e),

    ).toList();





    if(category == null ||
        category == 'All'){


      return products;


    }






    return products.where(

          (product)=>
          product.categories.contains(category),

    ).toList();



  }



}