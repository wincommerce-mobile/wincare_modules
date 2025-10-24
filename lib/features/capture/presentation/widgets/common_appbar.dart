import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../app/app_colors.dart';
import '../../../../app/app_text.dart';

PreferredSizeWidget commonAppBar(
  String title, {
  List<Widget>? actions,
  bool hideLeading = false,
}) {
  return AppBar(
    backgroundColor: AppColors.appbar,
    elevation: 0,
    leading: (hideLeading)
        ? null
        : IconButton(
            icon: const Icon(Icons.arrow_back_outlined, color: AppColors.white),
            onPressed: () => Get.back(),
          ),
    title: AppText(
      text: title,
      color: AppColors.white,
      fontSize: 16,
      fontWeight: FontWeight.w700,
    ),
    centerTitle: true,
    actions: actions,
  );
}
