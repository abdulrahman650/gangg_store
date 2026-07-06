import 'package:flutter/material.dart';
import 'package:gangg_store/core/theme/app_colors.dart';
import 'package:gangg_store/features/signin_and_guest/sign_in_screen.dart';
import 'package:gangg_store/features/title_header/header.dart';
import 'package:gap/gap.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const Header(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Create Account ',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                Gap(10),
                Text('join the elite world of premium accessories', 
                style: TextStyle(fontSize: 16, color: Colors.grey)),
              ],
            ),
            Gap(15),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Full Name",
                   style: TextStyle(fontSize: 14,
                    fontWeight: FontWeight.bold),),
                              TextField(
                    decoration: InputDecoration(
                      hintText: 'John Doe',
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
            Gap(25),
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
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Already have an account?"),
                TextButton(
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => const SignIn()),
                      (Route<dynamic> route) => false,
                    );
                  },
                  child: Text(
                  'login',
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