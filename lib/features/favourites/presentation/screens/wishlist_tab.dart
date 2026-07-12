import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gangg_store/core/theme/app_colors.dart';

import '../widgets/wishlist_item.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,

        body: ListView(
          children: const [
            WishlistItem(),
            SizedBox(height: 10),
            WishlistItem(),
            SizedBox(height: 10),
            WishlistItem(),
          ],
        ),

      ),
    );
  }
}
