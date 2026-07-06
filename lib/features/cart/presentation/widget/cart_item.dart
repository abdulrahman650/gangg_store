import 'package:flutter/material.dart';
import 'package:gangg_store/core/theme/app_colors.dart';

// ignore: must_be_immutable
class CartItem extends StatefulWidget {

   CartItem({
    super.key,

  });

  @override
  State<CartItem> createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  int counter=0;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(margin: EdgeInsets.all(10),
    
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.simony,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
         SizedBox(
      width: 90,
      height: 90,
      child: Image.network(
        'https://www.pngarts.com/files/4/Women-Bag-PNG-Photo.png'
        ,fit: BoxFit.cover,
      ),
    ),
         SizedBox(width: 20,)
          ,Column(
            children: [
              Text('Signature Tote'
            ,style:textTheme.titleSmall?.copyWith(
              color: AppColors.black
            ),
              ),
              SizedBox(height: 5,),
              Text('Charcoal / Large',
              style: textTheme.bodySmall?.copyWith(
                color: AppColors.gray
              ),),SizedBox(height: 10,)
              ,
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10)
                  ,   color: AppColors.gray,
                ),
                
                child: Row(
                  children: [
                    IconButton(onPressed: (){
                   counter++;
                   setState(() {
                     
                   });
                    }, icon:Icon(Icons.add))
                   , Text(counter.toString()),
                   
                   IconButton(onPressed: (){
                   counter--;
                   setState(() {
                     
                   });
                    }, icon:Icon(Icons.remove))
                  ],
                ),
              )
            ],
          ),Spacer()
    ,          Column(
      children: [
    IconButton(onPressed: (){},
     icon:Icon(Icons.delete) )
     ,SizedBox(height: 20,)
       , Text('\$450.00')
      ],
    )
        ],
        
      ),
    );
  }
}