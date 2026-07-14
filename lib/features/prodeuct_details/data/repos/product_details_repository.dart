import 'package:gangg_store/features/home/data/model/product_model.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../../core/network/api_consumer.dart';
import '../../../../core/network/api_endpoints.dart';

abstract class ProductDetailsRepository {
  Future<ProductModel> getProductDetails(String id);
}

class ProductDetailsRepositoryImpl implements ProductDetailsRepository {
  final ApiConsumer apiConsumer;

  ProductDetailsRepositoryImpl(this.apiConsumer);

  @override
  Future<ProductModel> getProductDetails(String id) async {
    try {
      final response = await apiConsumer.get(EndPoints.productById(id));
      return ProductModel.fromJson(response);
    } on RemoteException {
      rethrow;
    }
  }
}