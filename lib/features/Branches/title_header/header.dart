import 'package:flutter/material.dart';
import 'package:gangg_store/core/theme/app_colors.dart';

class Header extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showBackButton;
//عملت هنا العنوان بتاع الموقع علشان انادي عليه في الاسكرينات الي عاوزاه ومفضلش اكتب كتير
  const Header({
    super.key,
    this.title = 'Gang Store', 
    this.showBackButton = true, 
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      centerTitle: true, 
      leading: showBackButton
          ? IconButton(
              icon: Icon(Icons.arrow_back, color: AppColors.primary), 
              onPressed: () => Navigator.pop(context),
            )
          : null,
      title: Text(
        title,
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: AppColors.primary, 
        ),
      ),
    );
  }
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}