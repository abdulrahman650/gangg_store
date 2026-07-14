

import 'package:gangg_store/core/network/api_consumer.dart';
import 'package:gangg_store/core/network/api_endpoints.dart';
import 'package:gangg_store/features/cart/data/model/get_cart_model.dart';
import 'package:gangg_store/features/cart/data/model/model.dart';
import 'package:gangg_store/features/cart/data/request/add_to_cart_request.dart';
import 'package:gangg_store/features/cart/data/request/decrement_cart_item.dart';

abstract class CartRemoteDataSource {
Future<CartModel>addToCart(
  AddToCartRequest request,
);

Future <CartModel>decrement(
  DecrementCartItem request 
);

Future<void>deleteCartItem({
  required String cartItemId,
});

Future<GetCartModel>getCart();

}

class CartRemoteDataSourceImpl implements CartRemoteDataSource{
  final ApiConsumer api;
  CartRemoteDataSourceImpl(this.api);
  @override
  Future<CartModel> addToCart(AddToCartRequest request)async {
  final response=await api.post(
    EndPoints.addToCart,
    data: request.toJson(),
  );

    return CartModel.fromJson(response);
  }

  @override
  Future<CartModel> decrement(DecrementCartItem request)async {
    final response=await api.post(
      EndPoints.decrementCartItem,
      data: request.toJson(),
    );
    return CartModel.fromJson(response);
    
  }

  @override
  Future<void> deleteCartItem({required String cartItemId})async {
   
    await api.delete(
      EndPoints.deleteCartItem(cartItemId),
    );
  }
  
  @override
  Future<GetCartModel> getCart()async {
    final response =await api.get(
      EndPoints.getCart
    );
    return GetCartModel.fromJson(response);
  }

}

