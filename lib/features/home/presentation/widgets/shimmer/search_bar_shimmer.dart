import 'package:flutter/material.dart';

import 'shimmer_box.dart';

class SearchBarShimmer extends StatelessWidget {
  const SearchBarShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return const ShimmerBox(
      width: double.infinity,
      height: 55,
      radius: 15,
    );
  }
}