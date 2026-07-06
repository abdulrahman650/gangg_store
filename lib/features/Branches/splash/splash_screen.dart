import 'package:flutter/material.dart';
import 'package:gangg_store/core/theme/app_colors.dart';
import 'package:gangg_store/features/branches/onboarding/onboarding_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );

    _animationController.forward();

    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const OnboardingScreen()),
        );
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, 
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 50.0), 
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center, 
              children: [
                const Spacer(), 
                
                Image.asset(
                  "assets/icons/gangstorelogo.jpg",
                  height: 150,
                  width: 150,
                ),
                const SizedBox(height: 10), 
                Text(
                  "Gang Store",
                  style: TextStyle(
                    color: AppColors.primary,
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
                const SizedBox(height: 2), 
                Text(
                  "Your Smart Shopping Destination",
                  textAlign: TextAlign.center, 
                  style: TextStyle(
                    color: AppColors.gray,
                    fontWeight: FontWeight.bold,
                    fontSize: 16, 
                  ),
                ),
                
                const Spacer(), 
                
                AnimatedBuilder(
                  animation: _animationController,
                  builder: (context, child) {
                    return SizedBox(
                      width: 150, 
                      height: 4,   
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10), 
                        child: LinearProgressIndicator(
                          value: _animationController.value, 
                          backgroundColor: const Color(0xFFF5EFEF), 
                          valueColor: AlwaysStoppedAnimation<Color>(
                            AppColors.primary, 
                          ),
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 10), 
                const Text(
                  "ENTERING STORE",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                    letterSpacing: 2, 
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}