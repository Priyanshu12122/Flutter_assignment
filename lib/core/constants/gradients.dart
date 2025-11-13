import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppGradients {
  static const header = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      AppColors.pinkLight,
      AppColors.pinkMid,
      AppColors.pinkDark
    ],
  );

  static const quoteSheet = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [AppColors.pinkMid, AppColors.pinkDark],
  );

  static const categoryIcon = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [AppColors.darkGreen, AppColors.lightGreen],
  );

  static const categoryText = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [AppColors.lightGreen, AppColors.darkGreen],
  );

  static const Gradient kDashInGradient = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [
      Color(0x00ece6e6),
      Color(0xFF0F6C33),
    ],
  );

  static const Gradient kDashOutGradient = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [
      Color(0xFF0F6C33),
      Color(0x00ece6e6),
    ],
  );

  static const Gradient kTextGradient = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [
      AppColors.darkGreen,
      AppColors.lightGreen,
    ],
  );
}
