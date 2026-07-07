import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';

class ProfileTab extends StatelessWidget {
  const ProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Profile Tab",  style: TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.bold,
          color: AppColors.primary,
        ),),
      ),
    );
  }
}
