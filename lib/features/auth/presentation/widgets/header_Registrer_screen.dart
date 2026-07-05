import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
class HeaderRegisterScreen extends StatelessWidget {
  const HeaderRegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      children: [
        // Create Account
        Text(
          'Create Account',
          style: textTheme.headlineSmall?.copyWith(

            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Join the elite world of premium accessories.',
          style: textTheme.titleMedium?.copyWith(
            color: AppColors.darkGray,
          ),
        ),
        const SizedBox(height: 32),
      ],
    );
  }
}
