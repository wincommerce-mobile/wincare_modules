import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wincare_modules/app/app_colors.dart';
import 'package:wincare_modules/app/app_icon.dart';
import 'package:wincare_modules/app/app_text.dart';
import 'package:wincare_modules/features/capture/presentation/widgets/custom_border_button.dart';
import 'package:wincare_modules/features/capture/presentation/widgets/custom_button.dart';

void showConfirmDialog({
  required BuildContext context,
  required String message,
  required VoidCallback onConfirm,
}) {
  showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        backgroundColor: AppColors.white,
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AppText(
                    text: 'Xác nhận',
                    fontSize: 16,
                    color: AppColors.color333333,
                    fontWeight: FontWeight.w500,
                  ),
                  const SizedBox(height: 24),
                  DottedBorder(
                    options: RoundedRectDottedBorderOptions(
                      dashPattern: [6, 5],
                      strokeWidth: 1,
                      radius: Radius.circular(4),
                      color: AppColors.colorC2C2C2,
                      padding: EdgeInsets.symmetric(
                        horizontal: 4,
                        vertical: 12,
                      ),
                    ),
                    child: Container(
                      width: double.infinity,
                      alignment: Alignment.center,
                      child: AppText(
                        text: message,
                        fontSize: 16,
                        textAlign: TextAlign.center,
                        color: AppColors.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  Row(
                    children: [
                      Expanded(
                        child: CustomBorderButton(
                          title: 'Không',
                          height: 42,
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          borderColor: AppColors.red,
                          textColor: AppColors.red,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: CustomButton(
                          text: 'Có',
                          height: 42,
                          onPressed: () {
                            onConfirm();
                            Navigator.of(context).pop();
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
            Positioned(
              top: -6,
              right: -6,
              child: IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: Icon(Icons.close),
              ),
            ),
          ],
        ),
      );
    },
  );
}

void showWarningDialog({
  required BuildContext context,
  required String message,
}) {
  showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        backgroundColor: AppColors.white,
        child: Stack(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
              width: double.infinity,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  AppIcon.icWarning.widget(),
                  const SizedBox(height: 24),
                  AppText(
                    text: message,
                    fontSize: 16,
                    textAlign: TextAlign.center,
                    color: AppColors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ],
              ),
            ),
            Positioned(
              top: -6,
              right: -6,
              child: IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: Icon(Icons.close),
              ),
            ),
          ],
        ),
      );
    },
  );
}

void showInformDialog({
  required BuildContext context,
  required String message,
}) {
  showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        backgroundColor: AppColors.white,
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AppIcon.icImageInfo.widget(width: 50, height: 50),
                  const SizedBox(height: 24),
                  DottedBorder(
                    options: RoundedRectDottedBorderOptions(
                      dashPattern: [6, 5],
                      strokeWidth: 1,
                      radius: Radius.circular(4),
                      color: AppColors.colorC2C2C2,
                      padding: EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 12,
                      ),
                    ),
                    child: AppText(
                      text: message,
                      fontSize: 16,
                      textAlign: TextAlign.start,
                      color: AppColors.black,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: -6,
              right: -6,
              child: IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: Icon(Icons.close),
              ),
            ),
          ],
        ),
      );
    },
  );
}

void showCupertinoActionSheet({
  required BuildContext context,
  required VoidCallback onUpdateImage,
  required VoidCallback onDeleteImage,
}) {
  showCupertinoModalPopup<void>(
    context: context,
    builder: (BuildContext context) => CupertinoActionSheet(
      title: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: AppText(
          text: 'Chọn thao tác',
          fontSize: 15,
          color: AppColors.black.withValues(alpha: .6),
          fontWeight: FontWeight.w400,
        ),
      ),
      actions: <CupertinoActionSheetAction>[
        CupertinoActionSheetAction(
          onPressed: () {
            Navigator.pop(context);
            onUpdateImage();
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AppIcon.icUpdateImage.widget(),
              const SizedBox(width: 8),
              AppText(
                text: 'Đổi ảnh',
                fontSize: 13,
                color: AppColors.black,
                fontWeight: FontWeight.w400,
              ),
            ],
          ),
        ),
        CupertinoActionSheetAction(
          onPressed: () {
            Navigator.pop(context);
            onDeleteImage();
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AppIcon.icDelete.widget(),
              const SizedBox(width: 8),
              AppText(
                text: 'Xoá ảnh',
                fontSize: 13,
                color: AppColors.black,
                fontWeight: FontWeight.w400,
              ),
            ],
          ),
        ),
      ],
      cancelButton: CupertinoActionSheetAction(
        onPressed: () => Navigator.pop(context),
        isDefaultAction: true,
        child: AppText(
          text: 'Đóng',
          fontSize: 13,
          color: AppColors.black,
          fontWeight: FontWeight.w400,
        ),
      ),
    ),
  );
}
