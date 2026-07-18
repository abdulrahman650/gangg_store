import 'package:flutter/material.dart';

import 'category_shimmer.dart';
import 'offers_shimmer.dart';
import 'product_grid_shimmer.dart';
import 'search_bar_shimmer.dart';
import 'shimmer_box.dart';

class HomeLoadingShimmer extends StatelessWidget {
  const HomeLoadingShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [

          SearchBarShimmer(),

          SizedBox(height: 20),

          ShimmerBox(
            width: double.infinity,
            height: 70,
            radius: 15,
          ),

          SizedBox(height: 20),

          CategoryShimmer(),

          SizedBox(height: 20),

          OfferShimmer(),

          SizedBox(height: 25),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [

              ShimmerBox(
                width: 140,
                height: 20,
              ),

              ShimmerBox(
                width: 70,
                height: 20,
              ),
            ],
          ),

          SizedBox(height: 20),

          ProductGridShimmer(),
        ],
      ),
    );
  }
}