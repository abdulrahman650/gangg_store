import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gangg_store/core/theme/app_colors.dart';

import '../widgets/cart_item.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
       final textTheme = Theme.of(context).textTheme;
    final text = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
      leading: SizedBox(height:16 ,
      width: 16,
        child: SvgPicture.asset('assets/icons/arrowBack.svg'),)
      ,title: Text('Gang Store',
      style: textTheme.headlineLarge?.copyWith(color:AppColors.primary ),),
      actions: [],
      ),

    );
  
  }
}
