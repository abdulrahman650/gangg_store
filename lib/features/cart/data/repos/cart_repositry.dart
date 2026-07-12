import 'package:gangg_store/features/cart/data/datasource/Cart_Remote_Data_Source.dart';
import 'package:gangg_store/features/cart/data/model/get_cart_model.dart';
import 'package:gangg_store/features/cart/data/model/model.dart';
import 'package:gangg_store/features/cart/data/request/add_to_cart_request.dart';
import 'package:gangg_store/features/cart/data/request/decrement_cart_item.dart';

abstract class CartRepositry {

  Future<CartModel>addToCart(AddToCartRequest request);
  Future<CartModel>decrement(DecrementCartItem request);
  Future<GetCartModel>getCart();
  Future<void>deleteCartItem(String cartItemId);
  
}


class CartRepositryImpl implements CartRepositry{
  late final CartRemoteDataSource remoteDataSource;
  @override
  Future<CartModel> addToCart(AddToCartRequest request) {
  
   return remoteDataSource.addToCart(request);
  }

  @override
  Future<CartModel> decrement(DecrementCartItem request) {
  
   return remoteDataSource.decrement(request);
  }

  @override
  Future<void> deleteCartItem(String cartItemId) {
    
    return remoteDataSource.deleteCartItem(cartItemId: cartItemId);
  }
  
  @override
  Future<GetCartModel> getCart() {
    return remoteDataSource.getCart();
    
  }

}
