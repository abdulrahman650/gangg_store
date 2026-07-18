
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gangg_store/features/cart/data/model/get_cart_model.dart';
import 'package:gangg_store/features/cart/data/repos/cart_repositry.dart';
import 'package:gangg_store/features/cart/data/request/add_to_cart_request.dart';
import 'package:gangg_store/features/cart/data/request/decrement_cart_item.dart';
import 'package:gangg_store/features/cart/data/request/updateCartRequest.dart';
import 'package:gangg_store/features/cart/presentation/cubit/cart_state.dart';

class CartCubit extends Cubit<CartState> {
  final CartRepositry repositry;

  GetCartModel? _cart;

  CartCubit({
    required this.repositry,
  }) : super(const CartInitial());

  GetCartModel? get cart => _cart;

  Future<void> getCart() async {
    emit(const CartLoading());

    try {
      _cart = await repositry.getCart();
      emit(GetCartSuccess(_cart!));
    } catch (e) {
      emit(GetCartFailure(e.toString()));
    }
  }

  Future<void> addToCart({
    required String productId,
    required int quantity,
  }) async {
    try {
      emit(const AddToCartLoading());

      await repositry.addToCart(
        AddToCartRequest(
          productId: productId,
          quantity: quantity,
        ),
      );

      _cart = await repositry.getCart();

      emit(CartActionSuccess(_cart!));
    } catch (e) {
      emit(CartActionFailure(e.toString()));
    }
  }

  Future<void> updateQuantity({
    required String cartItemId,
    required int quantity,
  }) async {
    if (_cart == null) return;

    emit(CartActionLoading(cartItemId));

    try {
      await repositry.updateCartItem(
        UpdateCartRequest(
          id: cartItemId,
          quantity: quantity,
        ),
      );

      _cart = await repositry.getCart();

      emit(CartActionSuccess(_cart!));
    } catch (e) {
      emit(CartActionFailure(e.toString()));
      emit(GetCartSuccess(_cart!));
    }
  }

  Future<void> decrement({
    required String cartItemId,
    required String quantity,
  }) async {
    if (_cart == null) return;

    emit(CartActionLoading(cartItemId));

    try {
      await repositry.decrement(
        DecrementCartItem(
          cartItemId: cartItemId,
          quantity: quantity,
        ),
      );

      _cart = await repositry.getCart();

      emit(CartActionSuccess(_cart!));
    } catch (e) {
      emit(CartActionFailure(e.toString()));
      emit(GetCartSuccess(_cart!));
    }
  }

  Future<void> deleteCartItem({
    required String cartItemId,
  }) async {
    try {
      emit(CartActionLoading(cartItemId));

      await repositry.deleteCartItem(cartItemId);

      if (_cart != null) {
        _cart!.cartItems.removeWhere(
              (e) => e.itemId == cartItemId,
        );

        emit(CartActionSuccess(_cart!));
        emit(GetCartSuccess(_cart!));
      }

      try {
        _cart = await repositry.getCart();
        emit(GetCartSuccess(_cart!));
      } catch (_) {}
    } catch (e) {
      emit(CartActionFailure(e.toString()));
    }
  }

  void clearCart() {
    if (_cart == null) return;

    _cart!.cartItems.clear();

    emit(GetCartSuccess(_cart!));
  }
}