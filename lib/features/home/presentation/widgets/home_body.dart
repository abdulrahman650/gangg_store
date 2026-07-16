import 'package:flutter/material.dart';
import 'package:gangg_store/features/home/presentation/cubit/home_state.dart';

import 'home_header.dart';
import 'home_products_grid.dart';

class HomeBody extends StatefulWidget {
  final HomeSuccess state;

  const HomeBody({
    super.key,
    required this.state,
  });

  @override
  State<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _precacheImages();
    });
  }

  Future<void> _precacheImages() async {
    for (final product in widget.state.products.take(10)) {
      precacheImage(
        NetworkImage(product.imageUrl),
        context,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {},
      child: CustomScrollView(
        slivers: [

          SliverToBoxAdapter(
            child: HomeHeader(
              offers: widget.state.offers,
            ),
          ),

          HomeProductsGrid(
            products: widget.state.products,
          ),

          const SliverToBoxAdapter(
            child: SizedBox(height: 30),
          ),
        ],
      ),
    );
  }
}