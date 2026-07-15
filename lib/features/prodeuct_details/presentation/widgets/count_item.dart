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
        if (state is! ProductDetailsLoaded) {
          return Row(
            children: [
              _buildButton(context, Icons.remove, null),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.0),
                child: Text(
                  '1',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
              _buildButton(context, Icons.add, null),
            ],
          );
        }

        final quantity = state.quantity;
        final maxStock = state.product.stock;

        return Row(
          children: [
            _buildButton(
              context,
              Icons.remove,
              quantity > 1 ? () => context.read<ProductDetailsCubit>().decrementQuantity() : null,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Text(
                '$quantity',
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            _buildButton(
              context,
              Icons.add,
              quantity < maxStock ? () => context.read<ProductDetailsCubit>().incrementQuantity() : null,
            ),
          ],
        );
      },
    );
  }

  Widget _buildButton(BuildContext context, IconData icon, VoidCallback? onTap) {
    final isEnabled = onTap != null;

    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: isEnabled ? AppColors.white : AppColors.gray,
          border: Border.all(color: isEnabled ? AppColors.gray : AppColors.darkGray),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Icon(
          icon,
          size: 16,
          color: isEnabled ? AppColors.black : AppColors.darkGray,
        ),
      ),
    );
  }
}