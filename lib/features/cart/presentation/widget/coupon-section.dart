import 'package:flutter/material.dart';
import 'package:gangg_store/core/theme/app_colors.dart';

class CouponSection extends StatelessWidget {
  final VoidCallback onApply;

  const CouponSection({
    super.key,
    required this.onApply,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Row(
      children: [
        Expanded(
          child: TextField(
            decoration: InputDecoration(
              hintText: "Coupon Code",
              hintStyle: textTheme.bodyMedium?.copyWith(
                color: AppColors.darkGray,
              ),
              filled: true,
              fillColor: AppColors.lightGray,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 18,
                vertical: 16,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: BorderSide.none,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: BorderSide(
                  color: AppColors.primary,
                ),
              ),
            ),
          ),
        ),

        const SizedBox(width: 12),

        SizedBox(
          height: 55,
          child: ElevatedButton(
            onPressed: onApply,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              elevation: 0,
              padding: const EdgeInsets.symmetric(horizontal: 24),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
            child: Text(
              "Apply",
              style: textTheme.titleMedium?.copyWith(
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}