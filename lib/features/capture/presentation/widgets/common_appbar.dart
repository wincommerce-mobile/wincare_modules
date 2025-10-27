import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wincare_modules/app/app_icon.dart';

import '../../../../app/app_colors.dart';

PreferredSizeWidget commonAppBar(
  String title, {
  List<Widget>? actions,
  required VoidCallback onBack,
}) {
  return AppBar(
    backgroundColor: AppColors.appbar,
    elevation: 0,
    leading: SizedBox(
      width: 40,
      height: 40,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: InkWell(onTap: onBack, child: AppIcon.icBack.widget()),
      ),
    ),
    title: Padding(
      padding: const EdgeInsets.all(8.0),
      child: AutoSizeText(
        title,
        maxFontSize: 21,
        minFontSize: 16,
        maxLines: 2,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontFamily: 'Roboto',
          fontWeight: FontWeight.bold,
          color: AppColors.white,
        ),
      ),
    ),
    centerTitle: true,
    actions: actions,
  );
}

/*
AutoSizeText(
                                                  item.major,
                                                  maxFontSize: 117,
                                                  minFontSize: 14,
                                                  maxLines: 1,
                                                  textAlign: TextAlign.end,
                                                  style: TextStyle(
                                                    fontSize: 117,
                                                    fontFamily: 'Roboto',
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                )
*/
