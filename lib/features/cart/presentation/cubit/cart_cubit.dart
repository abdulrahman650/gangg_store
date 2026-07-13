import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gangg_store/features/cart/data/repos/cart_repositry.dart';
import 'package:gangg_store/features/cart/data/request/add_to_cart_request.dart';
import 'package:gangg_store/features/cart/data/request/decrement_cart_item.dart';
import 'package:gangg_store/features/cart/presentation/cubit/cart_state.dart';

class CartCubit extends Cubit<CartState> {
  final CartRepositry repositry;
  CartCubit({required this.repositry}) : super(const CartInitial());

Future<void>getCart()async{
  emit(CartLoading());

  try {
    final response=  await repositry.getCart();
     emit(GetCartSuccess(response));
  }on Exception catch (e) {
    emit(GetCartFailure(e.toString()));
  }
 
}

Future<void>addToCart({
  required String productId,
  required int quantity,
})async{
  emit( CartLoading());
  try {
    await repositry.addToCart(
    AddToCartRequest(productId: productId, quantity: quantity));
     await getCart();
  }on Exception catch (e) {
    emit(GetCartFailure(e.toString()));
  }




}

Future<void>decrement({
  required String cartItemId,
  required String quantity,

  
})async{
  emit(CartLoading());
try{
      await repositry.decrement(
   DecrementCartItem(cartItemId: cartItemId,
   quantity:quantity));
     await getCart();
  } on Exception catch (e) {
    emit(DecrementFailure());
  }
  
 
}
Future<void>deleteCartItem({
  required String cartItemId,
})
async {
  emit(CartLoading());

  try {
    await repositry.deleteCartItem(cartItemId);
    await getCart();

    
  }on Exception catch (e) {

    emit(DeleteFailure());
  }


}}