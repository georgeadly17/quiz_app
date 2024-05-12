import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:quiz_app/pages/category_page.dart';
import 'package:quiz_app/pages/home_page.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Center(
        child: Lottie.asset("assets/animation/splach_screen.json"),
      ),
      nextScreen: const CategoryPage(),
      duration: 4000,
      backgroundColor: Colors.white,
      splashIconSize: 200,
    );
  }
}