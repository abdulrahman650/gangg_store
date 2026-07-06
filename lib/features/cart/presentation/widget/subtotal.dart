import 'package:flutter/material.dart';

class Subtotal extends StatelessWidget {
  const Subtotal({super.key});

  @override
  Widget build(BuildContext context) {
        final textTheme = Theme.of(context).textTheme;
    return Row(
            children: [
              Text('Subtotal',style: textTheme.bodySmall,),
              Spacer(),
              Text(
                '\$950.00'
              )
            ],
          );
  }
}