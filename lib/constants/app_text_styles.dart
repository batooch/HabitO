import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTextStyles {
  static const TextStyle headlineLarge = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    color: AppColors.primaryGreen,
  );

  static const TextStyle headlineMedium = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: AppColors.primaryGreen,
  );

  static const TextStyle bodyLarge = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: AppColors.primaryGreen,
    height: 1.5,
  );

  static const TextStyle bodyMedium = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColors.primaryGreen,
    height: 1.5,
  );

  static const TextStyle bodySmall = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: AppColors.primaryGreen,
  );

  static const TextStyle labelSmall = TextStyle(
    fontSize: 8,
    fontWeight: FontWeight.w500,
    color: AppColors.primaryGreen,
  );
  static const TextStyle link = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColors.primaryGreen,
    decoration: TextDecoration.underline,
  );
  static const TextStyle suggestionText = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w500,
    color: AppColors.primaryGreen,
  );
}
