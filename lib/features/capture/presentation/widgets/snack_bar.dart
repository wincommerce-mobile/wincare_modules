import 'package:flutter/material.dart';

import '../../../../app/app_colors.dart';
import '../../../../app/app_text.dart';
import '../../../../app/global.dart';

Future<void> showSnackBar({
  required String description,
  Duration duration = const Duration(milliseconds: 2000),
}) async {
  final context = navigatorKey.currentContext;
  if (context != null) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    final snackBar = SnackBar(
      padding: EdgeInsets.symmetric(vertical: 25, horizontal: 16),
      content: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Icon(
            Icons.warning_amber_rounded,
            size: 20,
            color: AppColors.beigeShade30,
          ),
          SizedBox(width: 7),
          Expanded(
            child: AppText(
              text: description,
              color: AppColors.beigeShade30,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
      duration: duration,
      backgroundColor: AppColors.beigeTint90,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}

Future<void> showSuccessSnackBar({
  required String description,
  Duration duration = const Duration(milliseconds: 2000),
}) async {
  final context = navigatorKey.currentContext;
  if (context != null) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    final snackBar = SnackBar(
      padding: EdgeInsets.symmetric(vertical: 25, horizontal: 16),
      content: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Icon(Icons.check_circle_outline, size: 20, color: AppColors.green00),
          SizedBox(width: 7),
          Expanded(
            child: AppText(
              text: description,
              color: AppColors.green00,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
      duration: duration,
      backgroundColor: AppColors.white,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
