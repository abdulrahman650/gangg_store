import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
class BottomRegisterScreen extends StatelessWidget {
  const BottomRegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      children: [
        // Terms
        Center(
          child: Text(
            'By creating an account, you agree to\nGang Store\'s Terms of Service and\nPrivacy Policy',
            style: textTheme.titleSmall?.copyWith(
              color: AppColors.darkGray,
              fontSize: 12,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(height: 24),
        // Already have an account? Login
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Already have an account? ',
              style: textTheme.titleSmall?.copyWith(

              ),
            ),
            GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Text(
                'Login',
                style: textTheme.titleSmall?.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),
      ],
    );
  }
}
