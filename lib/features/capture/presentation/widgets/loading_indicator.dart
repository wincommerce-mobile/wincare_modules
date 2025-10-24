import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../app/app_colors.dart';


/// Show loading indicator
void showLoadingIndicator({
  Duration duration = const Duration(milliseconds: 100),
}) {
  Future.delayed(duration, () async {
    Get.generalDialog(
      pageBuilder: (_, __, ___) {
        return const LoadingIndicatorWidget();
      },
      transitionDuration: Duration(),
    );
  });
}

/// Hide loading indicator
void hideLoadingIndicator() {
  Future.delayed(const Duration(milliseconds: 100), () async {
    Get.back();
  });
}

class LoadingIndicatorWidget extends StatelessWidget {
  const LoadingIndicatorWidget({this.sigma = 3.0, super.key});

  final double sigma;

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: sigma, sigmaY: sigma),
      child: Container(
        color: Colors.transparent,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            SizedBox(
              height: 55,
              width: 55,
              child: CircularProgressIndicator(
                backgroundColor: AppColors.white.withValues(alpha: .15),
                color: AppColors.white,
                strokeCap: StrokeCap.round,
                strokeWidth: 5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
