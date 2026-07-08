import 'package:flutter/material.dart';
import 'package:gangg_store/core/theme/app_colors.dart';
import 'package:gangg_store/features/onboarding/presentation/screens/secondOnBor_screen.dart';
import 'package:gangg_store/features/onboarding/presentation/screens/thirdOnBor_screen.dart';

import '../../../../core/theme/theme_cubit.dart';
import 'firstOnBor_screen.dart';
import 'guest_screen.dart';


class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  int index = 0;
  @override
  void dispose() {
    _controller.dispose();//بنوقفه علشان المساحه وميستهلكش على الفاضي
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:  context.isDark
          ?  Theme.of(context).scaffoldBackgroundColor : AppColors.backgroundWhite ,
      body: Column(
        children: [
          Expanded(
            child: PageView(

              onPageChanged: (value) {
                setState(() {
                  index = value;
                });
              },
              controller: _controller,
              // عرفت ال3 سكرينات بتوعي ويتعرضوا بالترتيب
              children: const [
                FirstScreen(),
                SecondScreen(),
                ThirdScreen(),
              ],
            ),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomIndicator(active: index == 0),
              const SizedBox(width: 5),
              CustomIndicator(active: index == 1),
              const SizedBox(width: 5),
              CustomIndicator(active: index == 2),
            ],
          ),

          Padding(
            padding: const EdgeInsets.all(30),
            child: InkWell(
              onTap: () {
                if (index == 2) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const SignInAndGuestScreen(),
                    ),
                  );
                } else {
                  _controller.nextPage(
                    duration: const Duration(milliseconds: 350),
                    curve: Curves.easeInOut,
                  );
                }
              },
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 15),
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Text(
                  // يتغير الكلام في الاسكرينه الأخيرة
                  index == 2 ? "GET STARTED" : "Next",
                  textAlign: TextAlign.center, // لتوسط النص داخل الزر
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: AppColors.white,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

// النقط بتاعت التنقل
class CustomIndicator extends StatelessWidget {
  final bool active;
  const CustomIndicator({super.key, required this.active});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: active ? AppColors.primary : Colors.grey.shade400,
      ),
      width: active ? 30 : 10,
      height: 10,
    );
  }
}