import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gangg_store/core/theme/app_colors.dart';
import '../cubit/product_details_cubit.dart';
import '../cubit/product_details_state.dart';
import 'count_item.dart';

class QuantityAndPrice extends StatelessWidget {
  const QuantityAndPrice({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductDetailsCubit, ProductDetailsState>(
      builder: (context, state) {
        if (state is! ProductDetailsLoaded) {
          return Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 18,
              vertical: 16,
            ),
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(
                color: AppColors.gray.withOpacity(.25),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(.05),
                  blurRadius: 12,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "QUANTITY",
                        style: TextStyle(
                          color: AppColors.darkGray,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 1,
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(height: 14),
                      const CounterItems(),
                    ],
                  ),
                ),

                Container(
                  width: 1,
                  height: 55,
                  color: AppColors.gray.withOpacity(.3),
                ),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const Text(
                        "TOTAL PRICE",
                        style: TextStyle(
                          color: AppColors.darkGray,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 1,
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(height: 14),
                      Text(
                        state is ProductDetailsLoaded
                            ? state.formattedTotalPrice
                            : "\$0.00",
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }

        return Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 18,
            vertical: 16,
          ),
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: AppColors.gray.withOpacity(.25),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(.05),
                blurRadius: 12,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "QUANTITY",
                      style: TextStyle(
                        color: AppColors.darkGray,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 1,
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(height: 14),
                    const CounterItems(),
                  ],
                ),
              ),

              Container(
                width: 1,
                height: 55,
                color: AppColors.gray.withOpacity(.3),
              ),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Text(
                      "TOTAL PRICE",
                      style: TextStyle(
                        color: AppColors.darkGray,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 1,
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(height: 14),
                    Text(
                      state.formattedTotalPrice,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}