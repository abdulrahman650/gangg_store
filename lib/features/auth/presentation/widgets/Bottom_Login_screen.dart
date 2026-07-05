import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/theme_cubit.dart';
import '../../../../core/widgets/section_switch_theme.dart';
import '../screens/register_screen.dart';
class BottomRegisterScreen extends StatelessWidget {
  const BottomRegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      children: [
        const SizedBox(height: 24),
        // Don't have an account? Register
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Don't have an account? ",
              style: textTheme.titleSmall?.copyWith(
                // color: AppColors.black,
              ),
            ),
            GestureDetector(
              onTap: () {},
              // {
              //   Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //       builder: (_) => const RegisterView(),
              //     ),
              //   );
              // },
              child: Text(
                'Register',
                style: textTheme.titleSmall?.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        // Continue as Guest
        GestureDetector(
          onTap: () {
            // TODO: Continue as Guest
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Continue as Guest',
                style: textTheme.titleSmall?.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(width: 4),
              Icon(
                Icons.arrow_forward,
                color: AppColors.primary,
                size: 16,
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),


      ],
    );
  }
}
