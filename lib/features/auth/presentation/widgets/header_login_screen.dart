import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
class HeaderLoginScreen extends StatelessWidget {
  const HeaderLoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      children: [
        const SizedBox(height: 60),
        // Logo
        Text(
          'Gang Store',
          style: textTheme.headlineSmall?.copyWith(
            color: AppColors.primary,
            fontWeight: FontWeight.bold,
            fontSize: 28,
          ),
        ),
        const SizedBox(height: 32),
        // Welcome Back
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Welcome Back',
              style: textTheme.headlineSmall?.copyWith(
                // color: AppColors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Enter your credentials to access your collection.',
              style: textTheme.titleSmall?.copyWith(
                color: AppColors.darkGray,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
        const SizedBox(height: 32),
      ],
    );
  }
}
