import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:habito/constants/app_colors.dart';
import 'package:habito/constants/app_texts.dart';

class Intro extends StatelessWidget {
  const Intro({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundSoft,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Center(
            child: Column(
              children: [
                const SizedBox(height: 40),
                Image.asset('assets/images/LogoHabitO.jpeg', height: 120),
                const SizedBox(height: 40),
                const Text(
                  AppTexts.introHeadline,
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: AppColors.background,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                const Text(
                  AppTexts.introParagraph,
                  style: TextStyle(fontSize: 16, color: AppColors.background),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 60),
                ElevatedButton(
                  onPressed: () {
                    context.goNamed('home');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.background,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 40,
                      vertical: 14,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    elevation: 6,
                    shadowColor: AppColors.black,
                  ),
                  child: const Text(
                    AppTexts.introButton,
                    style: TextStyle(color: AppColors.white, fontSize: 16),
                  ),
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
