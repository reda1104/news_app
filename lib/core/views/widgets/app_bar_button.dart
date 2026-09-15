import 'package:flutter/material.dart';
import 'package:news_app/core/utils/theme/app_colors.dart';

class AppBarButton extends StatelessWidget {
  final IconData iconData;
  final VoidCallback onPressed;
  const AppBarButton({
    super.key,
    required this.iconData,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // Handle back button press
      },
      child: DecoratedBox(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: AppColors.grey2,
        ),
        child: IconButton(
          icon: Icon(iconData, color: AppColors.black),
          onPressed: onPressed,
        ),
      ),
    );
  }
}
