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

  bool get _allowBack => _controller.allowBack;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _controller.setupChannelHandler();
      //TODO - update when build module
      //await _controller.loadWithDummy();
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
              if (!_allowBack) {
                showWarningDialog(
                  context: context,
                  message: 'Vui lòng xác nhận kết quả',
                );
              } else {
                _controller.triggerNativeBack();
              }
            },
            actions: [
              SizedBox(
                width: 40,
                height: 40,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    child: AppIcon.icHistory.widget(),
                    onTap: () {
                      Get.toNamed(AppRoutes.history);
                    },
                  ),
                ),
              ),
            ],
          ),
          body: Column(
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.only(
                  top: 12,
                  left: 16,
                  right: 16,
                  bottom: 8,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(_zones.length, (index) {
                    return GestureDetector(
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
                      onDeleteImage: (imageIndex) async {
                        await _controller.onDeletePicTure(index, imageIndex);
                      },
                      onGetImagePoint: (result) {
                        _controller.onUpdateResult(index, result);
                      },
                      onUpdateFinalResult: (finalResult) {
                        _controller.onUpdateFinalResult(index, finalResult);
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
