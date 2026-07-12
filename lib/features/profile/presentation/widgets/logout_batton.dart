
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/theme/app_colors.dart';
import '../cubit/profile_cubit.dart';
class LogoutButton extends StatelessWidget {
  const LogoutButton({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return   OutlinedButton(
      onPressed: () {
        context.read<ProfileCubit>().logout();
      },
      style: OutlinedButton.styleFrom(
        fixedSize: Size(MediaQuery.sizeOf(context).width, 48),
        side: BorderSide(color: AppColors.red,width: 2),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        backgroundColor: AppColors.backgroundWhite,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            'assets/icons/logoutred.svg',
            width: 20,
            height: 20,
          ),
          const SizedBox(width: 12),
          Text(
            'Logout',
            style: textTheme.titleMedium?.copyWith(
              color: AppColors.red,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
