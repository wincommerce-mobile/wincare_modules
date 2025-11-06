import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wincare_modules/app/app_text.dart';
import 'package:wincare_modules/app/environments/environment_banner.dart';
import 'package:wincare_modules/features/capture/domain/entities/capture/image_template_entity.dart';
import 'package:wincare_modules/features/capture/presentation/zone_item_page.dart';

import '../../../app/app_colors.dart';
import '../../../app/app_enum.dart';
import '../../../app/app_icon.dart';
import '../../../app/app_pages.dart';
import 'capture_controller.dart';
import 'widgets/common_appbar.dart';
import 'widgets/common_dialog.dart';

class CaptureMainPage extends StatefulWidget {
  const CaptureMainPage({super.key});

  @override
  State<CaptureMainPage> createState() => _CaptureMainPageState();
}

class _CaptureMainPageState extends State<CaptureMainPage> {
  final _controller = Get.find<CaptureController>();

  List<ImageTemplateEntity> get _zones => _controller.imageZones;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _controller.setupChannelHandler();
    });
  }

  @override
  Widget build(BuildContext context) {
    return EnvironmentBanner(
      child: Obx(
        () => Scaffold(
          appBar: commonAppBar(
            'CHẤM ẢNH CHƯƠNG TRÌNH',
            onBack: () {
              showWarningDialog(
                context: context,
                message: 'Vui lòng xác nhận kết quả',
              );
            },
            actions: [
              InkWell(
                child: AppIcon.icHistory.widget(),
                onTap: () {
                  Get.toNamed(AppRoutes.history);
                },
              ),
              SizedBox(width: 12),
            ],
          ),
          body: Column(
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.only(top: 12, left: 16, right: 16, bottom: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(_zones.length, (index) {
                    return InkWell(
                      onTap: () {
                        _controller.onPageChanged(index);
                      },
                      child: Container(
                        height: 32,
                        width: 114,
                        margin: EdgeInsets.only(right: 10),
                        decoration: BoxDecoration(
                          color: _zones[index].selected
                              ? AppColors.color41A4FF
                              : AppColors.white,
                          border: Border.all(
                            width: 1,
                            color: _zones[index].selected
                                ? AppColors.color41A4FF
                                : AppColors.red,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        alignment: Alignment.center,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            AppText(
                              text: _zones[index].zoneName ?? '',
                              fontSize: 16,
                              color: _zones[index].selected
                                  ? AppColors.white
                                  : AppColors.black4D,
                              fontWeight: FontWeight.w500,
                            ),
                            if (_zones[index].type == TemplateType.require) ...[
                              SizedBox(width: 6),
                              AppText(
                                text: '*',
                                fontSize: 16,
                                color: AppColors.red,
                                fontWeight: FontWeight.w500,
                              ),
                            ],
                          ],
                        ),
                      ),
                    );
                  }),
                ),
              ),
              Expanded(
                child: PageView.builder(
                  itemCount: _zones.length,
                  controller: _controller.pageController,
                  physics: NeverScrollableScrollPhysics(),
                  onPageChanged: (page) {
                    _controller.onPageChanged(page);
                  },
                  itemBuilder: (context, index) {
                    final imageZone = _zones[index];
                    return ZoneItemPage(
                      imageZone: imageZone,
                      key: ValueKey(imageZone.planogramId),
                      onTakePicTure: () {
                        _controller.onTakePicTure(index);
                      },
                      onDeleteImage: (imageIndex) {
                        _controller.onDeletePicTure(index, imageIndex);
                      },
                      onGetImagePoint: (result){
                        _controller.onUpdateResult(index, result);
                      },
                      zoneController: _controller.zoneControllers[index],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
/*
TODO list
1. Detect to handle back button
2. Api load hình mẫu theo zone
3. Api load hình trưng bày theo zone
4. Api upload image (cần biết nó thuộc zone nào)
5. Api load hình trưng bày theo zone
*/