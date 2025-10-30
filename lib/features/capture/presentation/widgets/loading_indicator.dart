import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../app/app_colors.dart';
import '../../../../app/app_icon.dart';

/// Show loading indicator
void showLoadingIndicator({
  Duration duration = const Duration(milliseconds: 100),
}) {
  Future.delayed(duration, () async {
    Get.generalDialog(
      barrierColor: Colors.transparent,
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
  const LoadingIndicatorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Stack(
            children: [
              Align(
                alignment: Alignment.center,
                child: SizedBox(
                  height: 70,
                  width: 70,
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: AppIcon.icLoading.widget(fit: BoxFit.cover),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: SizedBox(
                  height: 70,
                  width: 70,
                  child: CircularProgressIndicator(
                    backgroundColor: AppColors.white.withValues(alpha: .15),
                    color: AppColors.colorFF0000,
                    strokeCap: StrokeCap.round,
                    strokeWidth: 5,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
