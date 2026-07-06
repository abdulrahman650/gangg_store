import 'package:flutter/material.dart';
import 'package:gangg_store/core/theme/app_colors.dart';

class FirstScreen extends StatelessWidget {
  const FirstScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset('assets/icons/screen1.png'),
        Text(
          "Discover Premium Style",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 30,
              color :AppColors.black,
              fontWeight: FontWeight.bold),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 40),
          child: Text(
            "Curated collections of world-class fashion accessories designed for the modern connoisseur.",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 20,
                color : Colors.grey,
                fontWeight: FontWeight.w400,
                // fontWeight: FontWeight.bold
                ),
          ),
        )
      ],
    );
  }
}

// "No ads while \nlistening music"
// "Listening to music is very comfertable without any annoying adds"