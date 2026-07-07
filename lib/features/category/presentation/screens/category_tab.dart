import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
class CategoryTab extends StatelessWidget {
  const CategoryTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Category Tab",  style: TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.bold,
          color: AppColors.primary,
        ),),
      ),
    );
  }
}
