

import 'package:flutter/material.dart';
import 'package:gangg_store/core/theme/app_colors.dart';
import 'package:gangg_store/core/utils/default_elevated_button.dart';

import '../../../../core/theme/theme_cubit.dart';
import '../../../category/presentation/widgets/category_item.dart';

class WishlistItem extends StatefulWidget {
  const WishlistItem({super.key});

  @override
  State<WishlistItem> createState() => _WishlistItemState();
}

class _WishlistItemState extends State<WishlistItem> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                const CategoryItem(
                  subtitle: "",
                  title: "",
                  imageAsset: 'assets/images/jewelry_category.png',
                  height: 190,
                  isWide: true,
                ),
                const Positioned(
                  top: 10,
                  right: 10,
                  child: Icon(Icons.favorite_border),
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Text(
                  "Midnight Chroma Watch",
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color:  context.isDark
                        ?  AppColors.white : AppColors.black ,
                  ),
                ),

                Spacer(),
                Text("\$1240", style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: AppColors.primary,
                )),
              ],
            ),
            Text(
              "Limited Edition",
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                color: AppColors.darkGray,
              )
            ),
            SizedBox(height: 10),
            DefaultElevatedButton(
              label: "move to card",
              onPressed: () {},
              backgroundColor: AppColors.primary,
            ),
          ],
        ),
      ),
    );
  }
}
