import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../app/app_text.dart';

class EmptyData extends StatelessWidget {
  const EmptyData({super.key, this.onRefresh, this.message});

  final VoidCallback? onRefresh;
  final String? message;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Get.height - 200,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ...[
            (onRefresh != null && message == null)
                ? IconButton(onPressed: onRefresh, icon: Icon(Icons.refresh))
                : Container(),
            const SizedBox(height: 10),
            AppText(text: message ?? 'Không có dữ liệu', fontSize: 18),
          ],
        ],
      ),
    );
  }
}
