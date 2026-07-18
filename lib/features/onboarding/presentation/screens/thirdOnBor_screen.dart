import 'package:flutter/material.dart';
import 'package:gangg_store/core/theme/app_colors.dart';
import 'package:gap/gap.dart';

class ThirdScreen extends StatelessWidget {
  const ThirdScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Gang Store",
          style: TextStyle(
            fontSize: 36,
            fontWeight: FontWeight.bold,
            color: AppColors.primary,
          ),
        ),
        Gap(60),
        Image.asset("assets/icons/screen3.png"),
        Gap(60),
        Text(
          "Fast & Secure Delivery",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color : AppColors.black),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 40),
          child: Text(
            "Experience the pinnacle of service with real-time tracking and white-glove handling for your premium accessories.",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w400,
              color : Colors.grey,),
          ),
        ),
      ],
    );
  }
}