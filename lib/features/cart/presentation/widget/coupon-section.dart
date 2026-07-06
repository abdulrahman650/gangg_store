import 'package:flutter/material.dart';
import 'package:gangg_store/core/theme/app_colors.dart';
import 'package:gangg_store/core/utils/default_text_form_field.dart';


class CouponSection extends StatelessWidget {
  const CouponSection({
    super.key,
    this.controller,
    required this.onApply,
  });

  final TextEditingController? controller;
  final VoidCallback onApply;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      height: 56,
      decoration: BoxDecoration(
        border: Border.all(color: theme.primaryColor),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Expanded(
            child: Theme(
              data: theme.copyWith(
                inputDecorationTheme: theme.inputDecorationTheme.copyWith(
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 18,
                  ),
                ),
              ),
              child: DefaultTextFormField(
                hintText: "Enter coupon code",
                controller: controller,
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(4),
            child: SizedBox(
              width: 110,
              height: double.infinity,
              child: ElevatedButton(

                onPressed: onApply,
                style: theme.elevatedButtonTheme.style?.copyWith(
                  backgroundColor:WidgetStateProperty.all(AppColors.primary)
                ),
                child: Text(
                  "Apply",
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: AppColors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}