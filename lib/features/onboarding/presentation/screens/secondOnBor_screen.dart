import 'package:flutter/material.dart';
import 'package:gangg_store/core/theme/app_colors.dart';

class SecondScreen extends StatelessWidget {
  const SecondScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [

        SizedBox(
          height: 320,
          child: Stack(
            children: [
              Positioned(
                top: 20,
                right: 30,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(22),
                  child: Image.asset(
                    "assets/icons/screen22.jpg",
                    width: 165,
                    height: 158,
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              Positioned(
                bottom: 20,
                left: 20,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(22),
                  child: Image.asset(
                    "assets/icons/screen2.png",
                    width: 220,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 30),

        Text(
          "Curated Collections",
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: AppColors.black,
          ),
        ),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
          child: Text(
            "Discover hand-picked pieces from the world's most iconic maisons.",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              color: Colors.grey,
            ),
          ),
        ),
      ],
    );
  }
}