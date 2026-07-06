import 'package:flutter/material.dart';
import 'package:gangg_store/core/theme/app_colors.dart';

class SecondScreen extends StatelessWidget {
  const SecondScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset("assets/icons/screen22.jpg"),
        Text(
          "Curated Collections",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: AppColors.black),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 40),
          child: Text(
            "Discover hand-picked pieces from the world's most iconic maisons.",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 20,
                color : Colors.grey,
                fontWeight: FontWeight.w400,
                ),
          ),
        ),
      ],
    );
  }
}