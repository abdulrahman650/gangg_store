

import 'package:flutter/material.dart';
import 'package:gangg_store/core/theme/app_colors.dart';

class CounterItems extends StatelessWidget {
  const CounterItems({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        InkWell(
          onTap: () {
          },
          child: Container(
            // color: AppColors.white,
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: AppColors.white,
              border: Border.all(color: AppColors.gray),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Icon(Icons.remove, size: 16, color: AppColors.black),
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.0),
          child: Text(
            '1',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
        InkWell(
          onTap: () {
          },
          child: Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: AppColors.white,
              border: Border.all(color: AppColors.gray),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Icon(Icons.add, size: 16, color: AppColors.black),
          ),
        ),
      ],
    );
  }
}
