import 'package:flutter/material.dart';

import '../../../../app/app_colors.dart';
import '../../../../app/app_text.dart';

class ImageLabel extends StatelessWidget {
  const ImageLabel({
    super.key,
    required this.label,
    this.textSize = 12,
  });

  final String label;
  final double textSize;

  @override
  Widget build(BuildContext context) {
    return label.isNotEmpty
        ? Container(
            decoration: BoxDecoration(
              color: AppColors.color3A73FF,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8),
                bottomLeft: Radius.circular(8),
                bottomRight: Radius.circular(2),
              ),
            ),
            padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
            child: AppText(
              text: label,
              color: AppColors.white,
              fontWeight: FontWeight.w500,
              fontSize: textSize,
            ),
          )
        : Container();
  }
}
