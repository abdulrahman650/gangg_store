import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gangg_store/core/theme/app_colors.dart';
import 'package:gap/gap.dart';

import '../../../auth/presentation/screens/register_screen.dart';
//صفحه الاسبلاش التانيه
class SignInAndGuestScreen extends StatelessWidget {
  const SignInAndGuestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset('assets/icons/fullLogo.svg', width: 150, height: 150),
              Gap(10),
              Text("Gang Store",
                  style: TextStyle(
                      fontSize: 28,
                      color: AppColors.black,
                      fontWeight: FontWeight.w600)),
              Gap(10),
              Text("PREMIUM ESSENTIALS",
                  style: TextStyle(
                      fontSize: 16,
                      color: AppColors.primary,
                      fontWeight: FontWeight.w500)
              ),
              Gap(40),
              ElevatedButton(
                onPressed: () {
                  //لما ندوس على التسجيل يودينا على سكرينه تسجيل الدخول
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const RegisterView ()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  minimumSize: const Size(200, 55),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                child: const Text(
                  'Sign In',
                  style: TextStyle(
                    color: AppColors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              Gap(20),

              ElevatedButton(
                onPressed: () {
                  // Continue as guest
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey.shade200,
                  foregroundColor: AppColors.primary,
                  minimumSize: const Size(200, 55),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  elevation: 0,
                ),
                child: const Text(
                  'Continue as Guest',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}