
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/theme/app_colors.dart';
class GoogleButton extends StatelessWidget {
  const GoogleButton({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return   OutlinedButton(
      onPressed: () {
        // TODO: Google Sign In
      },
      style: OutlinedButton.styleFrom(
        fixedSize: Size(MediaQuery.sizeOf(context).width, 48),
        side: BorderSide(color: AppColors.primary),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        backgroundColor: AppColors.white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            'assets/icons/google.svg',
            width: 20,
            height: 20,
          ),
          const SizedBox(width: 12),
          Text(
            'Google Login',
            style: textTheme.titleMedium?.copyWith(
              color: AppColors.black,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
