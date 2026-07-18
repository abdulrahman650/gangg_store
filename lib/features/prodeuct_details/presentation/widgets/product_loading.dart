import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ProductLoading extends StatelessWidget {
  const ProductLoading({super.key});


  Widget shimmerBox({
    double? height,
    double? width,
    double radius = 12,
  }) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: const Color(0xffF4F4F4),
        borderRadius: BorderRadius.circular(radius),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,

      body: Shimmer.fromColors(
        baseColor: const Color(0xffEEEEEE),
        highlightColor: const Color(0xffFAFAFA),

        child: ListView(
          padding: const EdgeInsets.all(16),

          children: [

            // image
            shimmerBox(
              height: 320,
              width: double.infinity,
              radius: 24,
            ),


            const SizedBox(height: 18),


            // category + rating
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                shimmerBox(
                  height: 14,
                  width: 100,
                ),


                shimmerBox(
                  height: 14,
                  width: 70,
                ),

              ],
            ),



            const SizedBox(height: 18),



            // title
            shimmerBox(
              height: 26,
              width: double.infinity,
              radius: 8,
            ),


            const SizedBox(height: 10),


            shimmerBox(
              height: 26,
              width: 220,
              radius: 8,
            ),



            const SizedBox(height: 20),



            // price
            shimmerBox(
              height: 28,
              width: 120,
              radius: 8,
            ),



            const SizedBox(height: 25),



            // description title
            shimmerBox(
              height: 18,
              width: 120,
            ),


            const SizedBox(height: 12),


            // description
            shimmerBox(
              height: 14,
              width: double.infinity,
            ),

            const SizedBox(height: 8),


            shimmerBox(
              height: 14,
              width: double.infinity,
            ),

            const SizedBox(height: 8),


            shimmerBox(
              height: 14,
              width: 250,
            ),



            const SizedBox(height: 25),



            // stock
            Align(
              alignment: Alignment.centerRight,
              child: shimmerBox(
                height: 18,
                width: 90,
              ),
            ),



            const SizedBox(height: 20),



            // quantity card
            shimmerBox(
              height: 100,
              width: double.infinity,
              radius: 18,
            ),



            const SizedBox(height: 25),



            // reviews section

            shimmerBox(
              height: 22,
              width: 150,
            ),


            const SizedBox(height: 15),



            Row(
              children: [

                Expanded(
                  child: shimmerBox(
                    height: 90,
                    radius: 16,
                  ),
                ),


                const SizedBox(width: 12),


                Expanded(
                  child: shimmerBox(
                    height: 90,
                    radius: 16,
                  ),
                ),

              ],
            ),



            const SizedBox(height: 30),



            // similar title

            shimmerBox(
              height: 20,
              width: 170,
            ),


            const SizedBox(height: 15),



            SizedBox(
              height: 220,

              child: Row(
                children: [

                  Expanded(
                    child: shimmerBox(
                      height: 220,
                      radius: 18,
                    ),
                  ),


                  const SizedBox(width: 12),


                  Expanded(
                    child: shimmerBox(
                      height: 220,
                      radius: 18,
                    ),
                  ),


                ],
              ),
            ),


          ],
        ),
      ),
    );
  }
}