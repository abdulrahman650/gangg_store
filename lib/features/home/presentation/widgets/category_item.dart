import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gangg_store/core/theme/app_colors.dart';

class CategoryItem extends StatelessWidget {
   CategoryItem({super.key, required this.IconImageName, required this.label});

  String? IconImageName;
  final String label;

  @override
  Widget build(BuildContext context,) {
    return Padding(
      padding: const EdgeInsets.only(right: 16.0),
      child: Column(
        children: [
          InkWell(
            onTap: () {},
            child: Container(
             height: 55,
              child: CircleAvatar(

                  backgroundColor: AppColors.gray,
                  radius: 36,
                  child:
              IconImageName == null
                  ? null
                  : SvgPicture.asset(
                'assets/icons/${IconImageName}.svg',
                colorFilter: ColorFilter.mode(
                  Theme.of(context).brightness == Brightness.dark ? AppColors.darkGray : AppColors.darkGray,
                  BlendMode.srcIn,
                ),)               ),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              color: AppColors.darkGray,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
