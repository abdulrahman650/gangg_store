// features/category/data/model/product_model.dart
class ProductModel {


  final String id;

  final String name;

  final String image;

  final double price;

  final List<String> categories;



  ProductModel({

    required this.id,

    required this.name,

    required this.image,

    required this.price,

    required this.categories,

  });





  factory ProductModel.fromJson(
      Map<String,dynamic> json
      ){

    return ProductModel(

      id: json['id'] ?? '',


      name: json['name'] ?? '',


      image:
      json['coverPictureUrl'] ?? '',



      price:
      (json['price'] ?? 0).toDouble(),



      categories:

      List<String>.from(

        json['categories'] ?? [],

      ),


    );


  }



}