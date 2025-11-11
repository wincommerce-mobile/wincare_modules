import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wincare_modules/app/app_colors.dart';
import 'package:wincare_modules/app/app_extensions.dart';
import 'package:wincare_modules/app/app_text.dart';
import 'package:wincare_modules/features/capture/presentation/history/history_controller.dart';
import 'package:wincare_modules/features/capture/presentation/widgets/common_appbar.dart';

import '../../domain/entities/history/capture_history_entity.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  final _controller = Get.find<HistoryController>();

  List<ImageGarnitureHistoryEntity> get _imageGarnitureHistories =>
      _controller.imageGarnitureHistories;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBar('LỊCH SỬ THAY ĐỔI', onBack: () => Get.back()),
      backgroundColor: AppColors.white,
      body: Obx(
        () => ListView.separated(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          itemCount: _imageGarnitureHistories.length,
          separatorBuilder: (context, index) {
            return Divider(height: 24, thickness: .5);
          },
          itemBuilder: (context, index) {
            final history = _imageGarnitureHistories[index];
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    AppText(
                      text:
                          'Ngày ${history.createdDate?.toDisplayDateTime()}: ',
                      fontSize: 14,
                    ),
                    Expanded(
                      child: AppText(
                        text: history.statusName ?? '',
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
                AppText(
                  text: 'Ghi chú: ${history.note}',
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
                AppText(
                  text: 'Thao tác: ${history.createdByName}',
                  fontSize: 10,
                  fontWeight: FontWeight.w400,
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
