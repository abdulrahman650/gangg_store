import 'package:flutter/material.dart';
import 'package:gangg_store/core/theme/app_colors.dart';
import 'package:gangg_store/features/Branches/forgot_password/forgot_password.dart';
import 'package:gangg_store/features/Branches/register_screen/register_screen.dart';
import 'package:gap/gap.dart';

class SignIn extends StatelessWidget {
  const SignIn({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Gap(20),
            //دا اسم الموقع بتاعنا 
            Column(
              spacing: 10,
              children: [ 
                Text( 
                  'Gang Store',
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: AppColors.primary),
                ),
              ],
            ),
            Gap(20),
            //دول شويه كلام عادي
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Welcome back',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                Text(
                  'Enter your credentials to access your collection.',
                  style: TextStyle(fontSize: 15, color: Colors.grey),
                ),
              ],
            ),
            Gap(15),
            //هنا بقى دا البوكس الي بنكتب فيه البيانات
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
              Gap(15),
              Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Password             ",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),),
                TextButton(
                  onPressed: () {
                    // هنا لما يدوس انه نسى الباسورد يوديه على سكرينه تانيه 
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => ForgotPassword()),
                      (Route<dynamic> route) => false,
                    );
                  },
                  child: Text(
                  '                 Forgot Password?',
                  style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
            SizedBox(height: 25),
            ElevatedButton(
              onPressed: () {
                
              },
              style: ElevatedButton.styleFrom(
                elevation: 1,
                fixedSize: Size(500, 50),
                backgroundColor: AppColors.primary,
              ),

              child: Text('Login', style: TextStyle(color: AppColors.white),),
            ),
            SizedBox(height: 25),
            Row(
              children: [
                Expanded(child: Divider()),
                Text('     OR CONTINUE WITH     '),
                Expanded(child: Divider()),
              ],
            ),
            SizedBox(height: 25),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Don't have an account?"),
                TextButton(
                  onPressed: () {
                    //هنا لو مش عنده اكونت اصلا يعمل اكونت 
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => RegisterScreen()),
                      (Route<dynamic> route) => false,
                    );
                  },
                  child: Text(
                  'Register',
                    style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}