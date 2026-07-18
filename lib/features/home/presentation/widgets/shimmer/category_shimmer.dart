import 'package:flutter/material.dart';

import 'shimmer_box.dart';

class CategoryShimmer extends StatelessWidget {
  const CategoryShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 90,
      child: ListView.separated(
        physics: const NeverScrollableScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: 5,
        separatorBuilder: (_, __) => const SizedBox(width: 15),
        itemBuilder: (_, __) {
          return Column(
            children: const [
              ShimmerBox(
                width: 60,
                height: 60,
                radius: 30,
              ),
              SizedBox(height: 8),
              ShimmerBox(
                width: 50,
                height: 12,
              ),
            ],
          );
        },
      ),
    );
  }
}