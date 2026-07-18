
import 'package:gangg_store/features/cart/data/model/get_cart_model.dart';

abstract class CartState {
  const CartState();
}

class CartInitial extends CartState {
  const CartInitial();
}


class CartLoading extends CartState {
  const CartLoading();
}


class GetCartSuccess extends CartState {
  final GetCartModel cart;

  const GetCartSuccess(this.cart);
}

class GetCartFailure extends CartState {
  final String message;

  const GetCartFailure(this.message);
}


class CartActionLoading extends CartState {
  final String cartItemId;

  const CartActionLoading(this.cartItemId);
}

class CartActionSuccess extends CartState {
  final GetCartModel cart;

  const CartActionSuccess(this.cart);
}

class CartActionFailure extends CartState {
  final String message;

  const CartActionFailure(this.message);
}

class AddToCartLoading extends CartState {
  const AddToCartLoading();
}