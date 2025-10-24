import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wincare_modules/app/app_icon.dart';
import 'package:wincare_modules/app/app_pages.dart';
import 'package:wincare_modules/app/app_text.dart';
import 'package:wincare_modules/features/capture/presentation/capture_controller.dart';
import 'package:wincare_modules/features/capture/presentation/widgets/common_appbar.dart';
import 'package:wincare_modules/features/capture/presentation/widgets/common_dialog.dart';
import 'package:wincare_modules/features/capture/presentation/widgets/custom_border_button.dart';
import 'package:wincare_modules/features/capture/presentation/widgets/custom_button.dart';
import 'package:wincare_modules/features/capture/presentation/widgets/custom_slider_image.dart';

import '../../../app/app_colors.dart';
import 'widgets/custom_network_image.dart';
import 'widgets/custom_switch.dart';
import 'widgets/diagonal_stripes_shimmer.dart';
import 'widgets/image_viewer_bottomsheet.dart';

class CapturePage extends StatefulWidget {
  const CapturePage({super.key});

  @override
  State<CapturePage> createState() => _CapturePageState();
}

class _CapturePageState extends State<CapturePage> {
  final _controller = Get.find<CaptureController>();

  bool get _allowMultiImage => _controller.allowMultiImage.value;

  bool get _showVerifyImageButton =>
      (_singleImage != null || _images.isNotEmpty);

  List<String> get _banners => _controller.banners;

  List<String> get _images => _controller.images;

  String? get _singleImage => _controller.singleImage.value;

  List<String> get _reasons => _controller.reasons;

  String? get _selectedReason => _controller.selectedReason.value;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: commonAppBar(
          'CHẤM ẢNH CHƯƠNG TRÌNH',
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
        body: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              _buildSlider(),
              const SizedBox(height: 24),
              _buildImages(),
              const SizedBox(height: 24),
              _buildCapture(),
              const SizedBox(height: 24),
              _buildResult(),
              const SizedBox(height: 24),
            ],
          ),
        ),
        bottomNavigationBar: Container(
          padding: EdgeInsets.symmetric(horizontal: 16),
          margin: EdgeInsets.only(bottom: 24),
          child: _buildAction(),
        ),
      ),
    );
  }

  /// Sample images
  Widget _buildSlider() {
    final width = Get.width - 30;
    final height = width / 2;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(
          text: 'Hình ảnh mẫu',
          fontSize: 14,
          fontWeight: FontWeight.w700,
        ),
        const SizedBox(height: 8),
        CustomSliderImage(
          images: _banners,
          width: width,
          height: height,
          onViewImage: (index) {
            _openImageViewerBottomSheet(
              context: context,
              title: "Hình ảnh trưng bày",
              photos: _banners,
              initPage: index,
            );
          },
          key: ValueKey('sample'),
        ),
      ],
    );
  }

  /// Images
  Widget _buildImages() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            AppText(
              text: 'Hình trưng bày',
              fontSize: 14,
              fontWeight: FontWeight.w700,
            ),
            Spacer(),
            CustomSwitch(
              value: _allowMultiImage,
              onChanged: (val) {
                _controller.toggleSwitch(val);
              },
            ),
          ],
        ),
        const SizedBox(height: 8),
        _imageByType(),
      ],
    );
  }

  Widget _emptyImage() {
    return InkWell(
      onTap: _controller.takePicture,
      child: SizedBox(
        width: Get.width,
        height: 255,
        child: AppIcon.captureImage.widget(fit: BoxFit.fill),
      ),
    );
  }

  Widget _buildSingleImage() {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(16.0),
          child: CustomNetworkImage(
            url: _singleImage ?? '',
            fit: BoxFit.cover,
            width: Get.width,
            height: 255,
          ),
        ),
        Positioned(
          top: 6,
          right: 6,
          child: InkWell(
            child: AppIcon.icMoreAction.widget(),
            onTap: () {
              showCupertinoActionSheet(
                context: context,
                onUpdateImage: () {
                  _controller.takePicture();
                },
                onDeleteImage: () {
                  showConfirmDialog(
                    context: context,
                    message: 'Bạn chắc chắn xóa hình?',
                    onConfirm: () {
                      _controller.onDeleteSingleImage();
                    },
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildMultiImages() {
    final width = Get.width - 30;
    final height = 255.0;
    return CustomSliderImage(
      images: _images,
      width: width,
      height: height,
      key: ValueKey('multiImages'),
      onViewImage: (index) {
        _openImageViewerBottomSheet(
          context: context,
          title: "Hình ảnh trưng bày",
          photos: _images,
          initPage: index,
        );
      },
      onImageAction: (index) {
        showCupertinoActionSheet(
          context: context,
          onUpdateImage: () {
            _controller.onUpdateImageInList(index);
          },
          onDeleteImage: () {
            showConfirmDialog(
              context: context,
              message: 'Bạn chắc chắn xóa hình?',
              onConfirm: () {
                _controller.onDeleteImageInList(index);
              },
            );
          },
        );
      },
      showImageAddress: true,
    );
  }

  Widget _imageByType() {
    if (_allowMultiImage) {
      return _images.isEmpty ? _emptyImage() : _buildMultiImages();
    } else {
      return _singleImage == null ? _emptyImage() : _buildSingleImage();
    }
  }

  /// Capture / Get point
  Widget _buildCapture() {
    return Row(
      children: [
        Expanded(
          child: CustomBorderButton(
            title: 'Chụp hình mới',
            onPressed: _controller.takePicture,
            icon: AppIcon.icCamera.widget(),
            borderColor: AppColors.color3A73FF,
            textColor: AppColors.color3A73FF,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: _showVerifyImageButton
              ? CustomButton(text: 'Chấm hình', onPressed: () {})
              : Container(),
        ),
      ],
    );
  }

  /// Image result from api
  Widget _buildResult() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(
          text: 'Kết quả trưng bày',
          fontSize: 14,
          fontWeight: FontWeight.w700,
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Column(
            children: [
              Row(
                children: [
                  AppText(text: 'Kết quả: ', fontSize: 14, fontWeight: FontWeight.w400,),
                  AppText(text: 'Chờ kết quả chấm', fontSize: 14, color: AppColors.colorE7B400,),
                ],
              ),
              Row(
                children: [
                  AppText(text: 'Người: ', fontSize: 14, fontWeight: FontWeight.w400,),
                  AppText(text: 'Nguyễn Văn A', fontSize: 14, color: AppColors.black,),
                ],
              ),
              Row(
                children: [
                  AppText(text: 'Ngày: ', fontSize: 14, fontWeight: FontWeight.w400,),
                  AppText(text: '15/10/2025 11:30', fontSize: 14, color: AppColors.black,),
                ],
              ),
              const SizedBox(height: 8),
              DiagonalStripesShimmer(
                height: 27,
                width: Get.width,
                stripeWidth: 12,
              ),
            ],
          ),
        ),
      ],
    );
  }

  /// Confirm / Feedback
  Widget _buildAction() {
    return Row(
      children: [
        Expanded(
          child: CustomButton(
            text: 'Xác nhận',
            onPressed: () {
              showConfirmDialog(
                context: context,
                message: 'Bạn chắc chắn xác nhận kết quả?',
                onConfirm: () {},
              );
            },
            height: 48,
            bgColor: AppColors.color3A73FF,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: CustomButton(
            text: 'Khiếu nại',
            onPressed: () {
              showDropdownReasonDialog();
            },
            height: 48,
            bgColor: AppColors.red,
          ),
        ),
      ],
    );
  }

  /// Feedback
  void showDropdownReasonDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return Obx(
          () => Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            backgroundColor: AppColors.white,
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      AppText(
                        text: 'Lý do khiếu nại',
                        fontSize: 16,
                        color: AppColors.black,
                        fontWeight: FontWeight.w500,
                      ),
                      const SizedBox(height: 24),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppText(
                            text: 'Chọn lý do',
                            fontSize: 13,
                            color: AppColors.black,
                            fontWeight: FontWeight.w500,
                          ),
                          const SizedBox(height: 10),
                          DropdownButtonFormField<String>(
                            value: _selectedReason,
                            dropdownColor: AppColors.white,
                            icon: Icon(
                              Icons.keyboard_arrow_down,
                              color: AppColors.color666666,
                            ),
                            style: TextStyle(
                              fontFamily: 'Roboto',
                              color: AppColors.black,
                              fontWeight: FontWeight.w500,
                              fontSize: 12,
                            ),
                            hint: AppText(
                              text: '-- Chọn lý do --',
                              fontSize: 12,
                              color: AppColors.color9D9D9D,
                              fontStyle: FontStyle.italic,
                            ),
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: BorderSide(
                                  color: AppColors.colorA3A3A3,
                                ),
                              ),
                              filled: true,
                              fillColor: AppColors.white,
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 12,
                              ),
                            ),
                            isDense: true,
                            isExpanded: true,
                            items: _reasons.map((item) {
                              return DropdownMenuItem<String>(
                                value: item,
                                child: AppText(
                                  text: item,
                                  color: AppColors.black,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12,
                                ),
                              );
                            }).toList(),
                            onChanged: (value) {
                              _controller.setSelectedReason(value);
                            },
                          ),
                        ],
                      ),

                      const SizedBox(height: 32),
                      CustomButton(
                        text: 'Gửi',
                        height: 42,
                        onPressed: _selectedReason == null
                            ? null
                            : () {
                                Navigator.of(context).pop();
                              },
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
          ),
        );
      },
    );
  }

  /// open images bottom sheet
  void _openImageViewerBottomSheet({
    required BuildContext context,
    required String title,
    required List<String> photos,
    required int initPage,
  }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.black12.withValues(alpha: 0.3),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
      ),
      builder: (_) => ImageViewerBottomSheet(
        title: title,
        photos: photos,
        initPage: initPage,
      ),
    );
  }

  ///
}
