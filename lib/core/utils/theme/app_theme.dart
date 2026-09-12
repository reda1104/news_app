import 'package:flutter/material.dart';
import 'package:news_app/core/utils/theme/app_colors.dart';

class AppTheme {
  static ThemeData get mainTheme {
    return ThemeData(
      primaryColor: AppColors.primaryColor,
      brightness: Brightness.light,
    );
  }
}
