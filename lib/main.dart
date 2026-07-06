import 'package:flutter/material.dart';
import 'package:gangg_store/core/theme/app_colors.dart';
import 'package:gangg_store/features/branches/splash/splash_screen.dart';
import 'core/utils/default_elevated_button.dart';

import 'package:gangg_store/features/home/presentation/screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const SplashScreen (),
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.light,
    );
  }
}
