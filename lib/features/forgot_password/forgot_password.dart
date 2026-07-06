import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gangg_store/core/theme/app_colors.dart';
import 'package:gangg_store/features/otp/otp.dart';
import 'package:gangg_store/features/signin_and_guest/sign_in_screen.dart';
import 'package:gangg_store/features/title_header/header.dart';
import 'package:gap/gap.dart';

class ForgotPassword extends StatelessWidget {
  const ForgotPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const Header(),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30), 
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset('assets/icons/rePassword.svg', width: 150, height: 150), 
              Gap(10),
              Text("Forgot Password?",
                  style: TextStyle(
                   fontSize: 28,
                  color: AppColors.black,
                  fontWeight: FontWeight.w600)),
                  Gap(10),
                  Text("Don't worry! It happens. Please enter the address associated with your account.",
                  style: TextStyle(
                   fontSize: 15.2,
                   color: Colors.grey,
                   fontWeight: FontWeight.w500)
              ),
              Gap(30),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Email Address",
                   style: TextStyle(fontSize: 14,
                    fontWeight: FontWeight.bold),),
                              TextField(
                    decoration: InputDecoration(
                      hintText: 'name@example.com',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ],
              ),
               Gap(40),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const Otp()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary, 
                    minimumSize: const Size(double.infinity, 55), 
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                child: const Text(
                  'Send Code',
                  style: TextStyle(
                    color: AppColors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              
              const SizedBox(height: 20),
              
              ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const SignIn()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey.shade200,
                  minimumSize: const Size(double.infinity, 55), 
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                child: const Text(
                  'Back to Login',
                  style: TextStyle(
                    color: AppColors.primary,
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