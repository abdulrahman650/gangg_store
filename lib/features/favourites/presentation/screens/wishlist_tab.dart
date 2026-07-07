import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';

class WishListTab extends StatelessWidget {
  const WishListTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Wishlist Tab",  style: TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.bold,
          color: AppColors.primary,
        ),),
      ),
    );
  }
}
