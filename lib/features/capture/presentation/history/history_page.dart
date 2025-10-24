import 'package:flutter/material.dart';
import 'package:wincare_modules/app/app_colors.dart';
import 'package:wincare_modules/app/app_text.dart';
import 'package:wincare_modules/features/capture/presentation/widgets/common_appbar.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBar('LỊCH SỬ THAY ĐỔI'),
      backgroundColor: AppColors.white,
      body: ListView.separated(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        itemCount: 5,
        separatorBuilder: (context, index){
          return Divider(
            height: 24,
            thickness: .5,
          );
        },
        itemBuilder: (context, index) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  AppText(
                    text: 'Ngày 10/10/2022 10:10:63: ',
                    fontSize: 14,
                  ),
                  AppText(text: 'Không đạt',fontSize: 14, fontWeight: FontWeight.w400),
                ],
              ),
              AppText(
                text: 'Ghi chú: Hình bị mờ, không nhận diện được số mặt',
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
              AppText(
                text: 'Thao tác: Nguyễn Văn A',
                fontSize: 10,
                fontWeight: FontWeight.w400,
              ),
            ],
          );
        },
      ),
    );
  }
}
