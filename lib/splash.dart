import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/home.dart';
import 'package:flutter_application_1/signup.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: LayoutBuilder(
        builder: (context, constraints) {
          final screenWidth = constraints.maxWidth;
          final screenHeight = constraints.maxHeight;

          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: screenWidth * 0.7, // 70% of screen width
                height: screenHeight * 0.5, // 50% of screen height
                child: LottieBuilder.asset(
                  "assets/lottie/Animation - 1721506131364.json",
                  fit: BoxFit.contain,
                ),
              ),
            ],
          );
        },
      ),
      nextScreen: const SignupPage(),
      splashIconSize: double.infinity, // Take full available size
      backgroundColor: Colors.blueAccent,
    );
  }
}
