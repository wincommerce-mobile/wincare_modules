import 'package:flutter/material.dart';

import '../../../../app/app_colors.dart';
import '../../../../app/app_text.dart';

class CustomBorderButton extends StatelessWidget {
  const CustomBorderButton({
    super.key,
    required this.title,
    required this.onPressed,
    required this.borderColor,
    this.icon,
    this.height = 35,
    this.bgColor = AppColors.white,
    required this.textColor,
  });

  final String title;
  final VoidCallback onPressed;
  final Color borderColor;
  final Color bgColor;
  final double? height;
  final Widget? icon;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.white,
          foregroundColor: bgColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: BorderSide(color: borderColor, width: 1.0),
          ),
          elevation: 0,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) ...[icon!, SizedBox(width: 8)],
            Container(
              child: AppText(
                text: title,
                fontSize: 13,
                color: textColor,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
