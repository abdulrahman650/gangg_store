import 'package:flutter/material.dart';
import 'package:gangg_store/core/theme/app_colors.dart';

import 'guest_screen.dart';

class FirstScreen extends StatelessWidget {
  const FirstScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Column(
      children: [

        Stack(
          children: [
            SizedBox(
              width: double.infinity,
              child: Image.asset(
                'assets/icons/screen1.png',
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 35,
                right: 20,
              ),
              child: Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const SignInAndGuestScreen(),
                      ),
                    );
                  },
                  child: const Text(
                    "Skip",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),

        const SizedBox(height: 30),

        Text(
          "Discover Premium Style",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 30,
            color: AppColors.black,
            fontWeight: FontWeight.bold,
          ),
        ),

        Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 40,
          ),
          child: Text(
            "Curated collections of world-class fashion accessories designed for the modern connoisseur.",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              color: Colors.grey,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ],
    );;
  }
}

// "No ads while \nlistening music"
// "Listening to music is very comfertable without any annoying adds"