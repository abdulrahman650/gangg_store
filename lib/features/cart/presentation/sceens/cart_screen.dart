import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gangg_store/core/theme/app_colors.dart';
import 'package:gangg_store/core/utils/default_elevated_button.dart';
import 'package:gangg_store/core/utils/default_text_form_field.dart';
import 'package:gangg_store/features/cart/presentation/widget/coupon-section.dart';
import 'package:gangg_store/features/cart/presentation/widget/subtotal.dart';

import '../widget/cart_item.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
       final textTheme = Theme.of(context).textTheme;
    final text = Theme.of(context).textTheme;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
        leading: SizedBox(height:16 ,
        width: 16,
          child: SvgPicture.asset('assets/icons/arrowBack.svg'),)
        ,title: Text('Gang Store',
        style: textTheme.headlineLarge?.copyWith(color:AppColors.primary ),),
        actions: [SvgPicture.asset('assets/icons/bag.svg'),SizedBox(width: 15,)],
        ),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Shopping Bag',style: textTheme.headlineMedium?.copyWith(
                  color: AppColors.black
                ),),
                SizedBox(height: 10
                ,),
                Text('3 items in your cart',style: textTheme.bodyMedium?.copyWith(
                  color: AppColors.backgroundDark
                ),),
                ListView.builder(shrinkWrap: true,
                  itemCount: 3,
                  itemBuilder: (context, index) {
                  return CartItem();

                },),
                Row(

    children: [

      Expanded(

        child: 

       CouponSection(onApply: () {
         
       },))

    ],

  ),SizedBox(height: 20
  ,),
  Container(decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(10)
   , color:AppColors.simony,
  ),
    
    child: 
    Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
         ListView.builder(
  shrinkWrap: true,
  physics: const NeverScrollableScrollPhysics(), // عشان ما يتعارضش مع الـ SingleChildScrollView
  itemCount: 3,
  itemBuilder:(context, index) {
    return Subtotal();
  },
),
          SizedBox(height: 10,),
          Divider(),
          Row(
            children: [
              Text('Total',style: textTheme.bodyLarge,),
              Spacer(),
              Text(
                '\$950.00'
              )
            ],
          )

        ],
      ),
    ),
  ),DefaultElevatedButton(foregroundColor: AppColors.white,
    backgroundColor: AppColors.primary,
    label: 'Proceed to Checkout', onPressed: (){
      /*Navigator.of(context).push(
        MaterialPageRoute(builder: (context){
          return checkoutScreen()
        })*/
      
    })
              ],
            ),
          ),
        ),
      
      ),
    );
  
  }
}
