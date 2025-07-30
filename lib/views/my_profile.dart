import 'package:flutter/material.dart';
import 'package:habito/constants/app_colors.dart';
import 'package:habito/constants/app_texts.dart';
import 'package:habito/constants/app_text_styles.dart';

class MyProfile extends StatelessWidget {
  const MyProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 200,
                child: Image.asset(
                  'assets/images/LogoHabitO.jpeg',
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(height: 32),
              // Titel
              Text(
                AppTexts.myProfile,
                style: AppTextStyles.headlineMedium,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
