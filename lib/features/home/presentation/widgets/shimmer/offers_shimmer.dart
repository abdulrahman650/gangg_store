import 'package:flutter/material.dart';

import 'shimmer_box.dart';

class OfferShimmer extends StatelessWidget {
  const OfferShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return const ShimmerBox(
      width: double.infinity,
      height: 170,
      radius: 20,
    );
  }
}