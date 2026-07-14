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

  Future<void> getCart() async {
    emit(const CartLoading());

    try {
      final response = await repositry.getCart();

      _cart = response;

      emit(GetCartSuccess(_cart!));
    } catch (e) {
      emit(GetCartFailure(e.toString()));
    }
  }

  Future<void> addToCart({
    required String productId,
    required int quantity,
  }) async {
    emit(const CartLoading());

    try {
      await repositry.addToCart(
        AddToCartRequest(
          productId: productId,
          quantity: quantity,
        ),
      );

      await getCart();

      emit(const AddToCartSuccess());
    } catch (e) {
      emit(GetCartFailure(e.toString()));
    }
  }

  Future<void> decrement({
    required String cartItemId,
    required String quantity,
  }) async {
    emit(const CartLoading());

    try {
      await repositry.decrement(
        DecrementCartItem(
          cartItemId: cartItemId,
          quantity: quantity,
        ),
      );

      await getCart();

      emit(const DecrementSuccess());
    } catch (e) {
      emit(const DecrementFailure());
    }
  }

  Future<void> deleteCartItem({
    required String cartItemId,
  }) async {
    emit(const CartLoading());

    try {
      await repositry.deleteCartItem(cartItemId);

      await getCart();

      emit(const DeleteSuccess());
    } catch (e) {
      emit(const DeleteFailure());
    }
  }

  Future<void> updateQuantity({
    required String cartItemId,
    required int quantity,
  }) async {
    try {
      await repositry.updateCartItem(
        UpdateCartRequest(
          id: cartItemId,
          quantity: quantity,
        ),
      );

      if (_cart == null) return;

      final index =
      _cart!.cartItems.indexWhere((e) => e.itemId == cartItemId);

      if (index == -1) return;

      final oldItem = _cart!.cartItems[index];

      _cart!.cartItems[index] = oldItem.copyWith(
        quantity: quantity,
        totalPrice: oldItem.finalPricePerUnit * quantity,
      );

      emit(GetCartSuccess(_cart!));
    } catch (e) {
      emit(UpdateQuantityFailure(e.toString()));
    }
  }
}