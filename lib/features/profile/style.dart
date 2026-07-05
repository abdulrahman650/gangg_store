import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';

class ProfileStyles {
  static const Color pageBg = AppColors.backgroundWhite;
  static const Color brown = AppColors.primary;
  static const Color black = AppColors.black;
  static const Color redLogout = AppColors.red;

  static Color get lightBorder => AppColors.primary.withOpacity(0.25);

  static TextStyle appTitle(BuildContext context) {
    final text = Theme.of(context).textTheme;

    return text.titleLarge!.copyWith(
      fontSize: 22,
      fontWeight: FontWeight.w700,
      color: AppColors.primary,
    );
  }

  static TextStyle name(BuildContext context) {
    final text = Theme.of(context).textTheme;

    return text.headlineSmall!.copyWith(
      fontSize: 24,
      fontWeight: FontWeight.bold,
      color: AppColors.black,
    );
  }

  static TextStyle label(BuildContext context) {
    final text = Theme.of(context).textTheme;

    return text.titleSmall!.copyWith(
      fontSize: 12,
      fontWeight: FontWeight.w500,
      color: AppColors.primary,
    );
  }

  static TextStyle fieldText(BuildContext context) {
    final text = Theme.of(context).textTheme;

    return text.titleMedium!.copyWith(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: AppColors.black,
    );
  }

  static TextStyle buttonText(BuildContext context) {
    final text = Theme.of(context).textTheme;

    return text.titleMedium!.copyWith(
      fontSize: 16,
      fontWeight: FontWeight.bold,
      color: AppColors.white,
    );
  }

  static TextStyle logoutText(BuildContext context) {
    final text = Theme.of(context).textTheme;

    return text.titleMedium!.copyWith(
      fontSize: 16,
      fontWeight: FontWeight.bold,
      color: AppColors.red,
    );
  }

  static TextStyle navText(BuildContext context) {
    final text = Theme.of(context).textTheme;

    return text.titleSmall!.copyWith(
      fontSize: 11,
      fontWeight: FontWeight.w400,
      color: AppColors.primary,
    );
  }
}