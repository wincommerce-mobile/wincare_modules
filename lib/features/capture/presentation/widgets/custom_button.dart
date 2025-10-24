import 'package:flutter/material.dart';

import '../../../../app/app_colors.dart';
import '../../../../app/app_text.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final double? height;
  final Widget? icon;
  final Color? bgColor;
  final VoidCallback? onPressed;

  const CustomButton({
    super.key,
    required this.text,
    this.icon,
    this.height,
    this.bgColor,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height ?? 35,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: bgColor ?? AppColors.red,
          // deep red
          foregroundColor: AppColors.white,
          // text color
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8), // border radius
          ),
        ),
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) ...[icon!, SizedBox(width: 8)],
            AppText(text: text, color: AppColors.white, fontSize: 16),
          ],
        ),
      ),
    );
  }
}
