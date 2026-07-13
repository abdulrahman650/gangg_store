import 'package:gangg_store/features/cart/data/model/get_cart_model.dart';

abstract class CartState {
  const CartState();
}

class GetCartSuccess extends CartState{
  final GetCartModel cart;
 const GetCartSuccess(this.cart);
}

class GetCartFailure extends CartState{
  final String message;
 const GetCartFailure(this.message);
}

class CartInitial extends CartState{
  const CartInitial();
}

class CartLoading extends CartState{
  const CartLoading();
}

class AddToCartSuccess extends CartState{
  const AddToCartSuccess();
}

class AddToCartFailure extends CartState{
  const AddToCartFailure();
}

class DecrementSuccess extends CartState{
  const DecrementSuccess();
}

class DecrementFailure extends CartState{
  const DecrementFailure();
}

class DeleteSuccess extends CartState{
   const DeleteSuccess();
}

class DeleteFailure extends CartState{
  const DeleteFailure();
}
