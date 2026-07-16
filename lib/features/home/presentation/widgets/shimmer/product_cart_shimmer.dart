import 'package:flutter/material.dart';

import 'shimmer_box.dart';

class ProductCardShimmer extends StatelessWidget {
  const ProductCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [

        ShimmerBox(
          width: double.infinity,
          height: 150,
          radius: 15,
        ),

        SizedBox(height: 10),

        ShimmerBox(
          width: double.infinity,
          height: 15,
        ),

        SizedBox(height: 8),

        ShimmerBox(
          width: 90,
          height: 15,
        ),

        SizedBox(height: 10),

        ShimmerBox(
          width: 60,
          height: 18,
        ),
      ],
    );
  }
}