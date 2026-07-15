// features/home/presentation/screens/home_screen.dart
import 'package:flutter/material.dart';
import 'package:gangg_store/core/theme/app_colors.dart';
import 'package:gangg_store/features/home/presentation/widgets/category.dart';
import 'package:gangg_store/features/home/presentation/widgets/create_account_bar.dart';
import 'package:gangg_store/features/home/presentation/widgets/discount_card.dart';
import 'package:gangg_store/features/home/presentation/widgets/product_card.dart';

import '../../../../core/services/cache_helper.dart';
import '../../../../core/services/cache_keys.dart';
import '../../../../core/utils/default_text_form_field.dart';


class HomeScreen extends StatefulWidget {

  final bool openProducts;


  const HomeScreen({
    super.key,
    this.openProducts = false,
  });


  @override
  State<HomeScreen> createState() => _HomeScreenState();

}



class _HomeScreenState extends State<HomeScreen> {


  final ScrollController controller =
  ScrollController();



  final products = [

    {'title': 'Obsidian Navigator XL', 'price': '\$1,250.00'},
    {'title': 'Heritage Forest Tote', 'price': '\$2,400.00'},
    {'title': 'Midnight Chrono', 'price': '\$850.00'},
    {'title': 'Classic Leather Satchel', 'price': '\$1,100.00'},
    {'title': 'Obsidian Navigator XL', 'price': '\$1,250.00'},
    {'title': 'Heritage Forest Tote', 'price': '\$2,400.00'},

  ];



  @override
  void initState() {

    super.initState();


    if(widget.openProducts){

      Future.delayed(
        const Duration(milliseconds:300),
            (){

          controller.animateTo(
            650,
            duration:
            const Duration(milliseconds:500),
            curve: Curves.easeInOut,
          );

        },
      );

    }

  }



  @override
  void dispose() {

    controller.dispose();

    super.dispose();

  }




  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor:
      Theme.of(context).scaffoldBackgroundColor,


      body: SafeArea(

        child: CustomScrollView(

          controller: controller,


          slivers: [



            SliverToBoxAdapter(

              child: Padding(

                padding:
                const EdgeInsets.symmetric(
                  horizontal:16,
                ),


                child: Column(

                  crossAxisAlignment:
                  CrossAxisAlignment.start,


                  children: [


                    const SizedBox(height:10),



                    Container(

                      padding:
                      const EdgeInsets.symmetric(
                        horizontal:12,
                      ),


                      decoration: BoxDecoration(

                        color:AppColors.gray,

                        borderRadius:
                        BorderRadius.circular(15),

                      ),


                      child:

                      DefaultTextFormField(

                        hintText:
                        'Search for Gang accessories...',


                        prefixIconImageName:
                        'search',


                        fillColor:
                        AppColors.gray.withOpacity(.5),

                        onChanged:(value){},

                      ),

                    ),




                    const SizedBox(height:20),




                    if(CacheHelper.getData(CacheKeys.isGuest)==true)

                      const CreateAccountBar(),



                    const SizedBox(height:25),




                    Category(),




                    const SizedBox(height:20),




                    DiscountCard(),




                    const SizedBox(height:25),




                    const Text(

                      'Featured Products',

                      style:TextStyle(

                        fontSize:18,

                        fontWeight:
                        FontWeight.bold,

                      ),

                    ),




                    const SizedBox(height:15),



                  ],

                ),

              ),

            ),




            SliverPadding(

              padding:
              const EdgeInsets.symmetric(
                horizontal:16,
              ),


              sliver:

              SliverGrid(

                gridDelegate:
                const SliverGridDelegateWithFixedCrossAxisCount(

                  crossAxisCount:2,

                  mainAxisSpacing:16,

                  crossAxisSpacing:16,

                  childAspectRatio:.65,

                ),


                delegate:

                SliverChildBuilderDelegate(

                      (context,index){

                    final p =
                    products[index % products.length];


                    return ProductCard(

                      title:p['title']!,

                      price:p['price']!,

                    );

                  },


                  childCount:
                  products.length,


                ),

              ),

            ),



            const SliverToBoxAdapter(

              child:SizedBox(height:30),

            ),



          ],

        ),

      ),

    );

  }

}