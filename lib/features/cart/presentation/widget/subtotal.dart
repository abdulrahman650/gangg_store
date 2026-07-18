import 'package:flutter/material.dart';
import 'package:gangg_store/core/theme/app_colors.dart';

import '../../../../core/theme/theme_cubit.dart';

class Subtotal extends StatelessWidget {
  final double subtotal;
  final double total;
  const Subtotal({super.key, required this.subtotal, required this.total});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(

        color: context.isDark
            ? AppColors.darkGray
            : AppColors.lightGray,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        children: [

          _priceRow(
            title: "Subtotal",
            value: "\$${subtotal.toStringAsFixed(2)}",
            textTheme: textTheme,
          ),

          const SizedBox(height: 15),

          _priceRow(
            title: "Shipping",
            value: "\$50.00",
            textTheme: textTheme,
          ),

          const SizedBox(height: 18),

          Divider(
            color: Colors.grey.shade400,
          ),

          const SizedBox(height: 18),

          Row(
            children: [

              Text(
                "Total",
                style: textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),

              const Spacer(),

              Text(
                "\$${total.toStringAsFixed(2)}",
                style: textTheme.titleLarge?.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _priceRow({
    required String title,
    required String value,
    required TextTheme textTheme,
  }) {
    return Row(
      children: [

        Text(
          title,
          style: textTheme.bodyLarge,
        ),

        const Spacer(),

        Text(
          value,
          style: textTheme.bodyLarge?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}