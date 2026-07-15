import 'package:gangg_store/features/cart/data/model/cart_item_model.dart';

class GetCartModel {
  final String cartId;
  final List<CartItemModel>cartItems;

  GetCartModel({
    
   required this.cartId,
   required this.cartItems});

   
   factory GetCartModel.fromJson(Map<String, dynamic> json) {
  return GetCartModel(
    cartId: json["cartId"],
    cartItems: (json["cartItems"] as List)
        .map((item) => CartItemModel.fromJson(item as Map<String, dynamic>))
        .toList(),
  );
}
}