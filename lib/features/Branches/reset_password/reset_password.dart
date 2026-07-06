import 'package:flutter/material.dart';
import 'package:gangg_store/core/theme/app_colors.dart';
import 'package:gangg_store/features/Branches/title_header/header.dart';
import 'package:gangg_store/features/branches/forgot_password/forgot_password.dart';
import 'package:gangg_store/features/branches/register_screen/register_screen.dart';
import 'package:gap/gap.dart';

class ResetPassword extends StatelessWidget {
  const ResetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const Header(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Gap(60),

            Image.asset('assets/icons/Background+Shadow.png'),
            Gap(30),

            //دول شويه كلام عادي
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Reset Password',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                Text(
                  'Create a new, strong password to secure your account.',
                  style: TextStyle(fontSize: 15, color: Colors.grey),
                ),
              ],
            ),
            Gap(15),
            //هنا بقى دا البوكس الي بنكتب فيه البيانات
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("New Password",
                   style: TextStyle(fontSize: 14,
                    fontWeight: FontWeight.bold),),
                              TextField(
                    decoration: InputDecoration(
                      hintText: 'Enter your new password',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ],
              ),
              Gap(15),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Confirm New Password",
                   style: TextStyle(fontSize: 14,
                    fontWeight: FontWeight.bold),),
                              TextField(
                    decoration: InputDecoration(
                      hintText: 'Confirm your new password',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ],
              ),
              
            SizedBox(height: 25),
            ElevatedButton(
              onPressed: () {
                
              },
              style: ElevatedButton.styleFrom(
                elevation: 1,
                fixedSize: Size(500, 50),
                backgroundColor: AppColors.primary,
              ),

              child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Reset Password',
                      style: TextStyle(
                        color: AppColors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Gap(8),
                    Icon(
                      Icons.arrow_forward,
                      color: AppColors.white,
                      size: 22,
                    ),
                  ],
                ),
            
            ),
            Gap(20),
           TextButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ForgotPassword(),
                    ),
                  );
                },
                child: const Text(
                  'Back to Sign in',
                  style: TextStyle(
                    color: AppColors.primary,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}