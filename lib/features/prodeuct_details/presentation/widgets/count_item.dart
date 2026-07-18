import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gangg_store/core/theme/app_colors.dart';
import '../cubit/product_details_cubit.dart';
import '../cubit/product_details_state.dart';

class CounterItems extends StatelessWidget {
  const CounterItems({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductDetailsCubit, ProductDetailsState>(
      builder: (context, state) {
        final quantity =
        state is ProductDetailsLoaded ? state.quantity : 1;

        final maxStock =
        state is ProductDetailsLoaded ? state.product.stock : 1;

        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _CounterButton(
              icon: Icons.remove,
              enabled: quantity > 1,
              onTap: quantity > 1
                  ? () => context
                  .read<ProductDetailsCubit>()
                  .decrementQuantity()
                  : null,
            ),

            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 50,
              alignment: Alignment.center,
              child: Text(
                "$quantity",
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            _CounterButton(
              icon: Icons.add,
              enabled: quantity < maxStock,
              onTap: quantity < maxStock
                  ? () => context
                  .read<ProductDetailsCubit>()
                  .incrementQuantity()
                  : null,
            ),
          ],
        );
      },
    );
  }
}

class _CounterButton extends StatelessWidget {
  final IconData icon;
  final bool enabled;
  final VoidCallback? onTap;

  const _CounterButton({
    required this.icon,
    required this.enabled,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: enabled
          ? AppColors.primary.withOpacity(.08)
          : AppColors.gray.withOpacity(.25),
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: SizedBox(
          width: 36,
          height: 36,
          child: Icon(
            icon,
            size: 18,
            color: enabled
                ? AppColors.primary
                : AppColors.darkGray,
          ),
        ),
      ),
    );
  }
}