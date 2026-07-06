import 'package:flutter/material.dart';
import 'package:gangg_store/core/theme/app_colors.dart';
import 'package:gangg_store/features/Branches/onboarding/Screens/firstscreen.dart';
import 'package:gangg_store/features/Branches/onboarding/Screens/secondscreen.dart';
import 'package:gangg_store/features/Branches/onboarding/Screens/thirdscreen.dart';
import 'package:gangg_store/features/Branches/signin_and_guest/sign_in_and_guest_screen.dart';

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
      backgroundColor: Colors.white, 
      body: SafeArea(
        child: Column(
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
            
            // النقط تتغير على حسب انا واقف على اي سكرينه
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
                    //لما اضغط على اخر زر في الاسكرينه 3 يوديني على سكرينه التسجيل ولا الجيست
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const SignInAndGuestScreen()),
                    );
                  } else {
                    //هنا عادي بيزود واحد لما ادوس على الزر
                      index + 1;
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