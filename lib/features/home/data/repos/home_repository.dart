import 'package:gangg_store/core/errors/exceptions.dart';
import 'package:gangg_store/features/home/data/model/offers_response_model.dart';
import 'package:gangg_store/features/home/data/model/product_model.dart';
import 'package:gangg_store/features/home/data/model/products_response_model.dart';
import '../../../../core/network/api_consumer.dart';
import '../../../../core/network/api_endpoints.dart';

abstract class HomeRepository {
  Future<ProductsResponseModel> getProducts();
  Future<ProductModel> getProductById(String id);
  Future<OffersResponseModel> getOffers();
}

class HomeRepositoryImpl implements HomeRepository {
  final ApiConsumer apiConsumer;

  HomeRepositoryImpl(this.apiConsumer);

  @override
  Future<ProductsResponseModel> getProducts() async {
    try {
      final response = await apiConsumer.get(EndPoints.products);
      return ProductsResponseModel.fromJson(response);
    } on RemoteException {
      rethrow;
    }
  }

  @override
  Future<ProductModel> getProductById(String id) async {
    try {
      final response = await apiConsumer.get(EndPoints.productById(id));
      return ProductModel.fromJson(response);
    } on RemoteException {
      rethrow;
    }
  }

  @override
  Future<OffersResponseModel> getOffers() async {
    try {
      final response = await apiConsumer.get(EndPoints.offers);
      return OffersResponseModel.fromJson(response);
    } on RemoteException {
      rethrow;
    }
  }
}