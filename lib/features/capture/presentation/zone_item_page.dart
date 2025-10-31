import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wincare_modules/features/capture/presentation/capture_controller.dart';

import '../../../app/app_colors.dart';
import '../../../app/app_function.dart';
import '../../../app/app_icon.dart';
import '../../../app/app_text.dart';
import 'widgets/common_dialog.dart';
import 'widgets/custom_border_button.dart';
import 'widgets/custom_button.dart';
import 'widgets/custom_slider_image.dart';
import 'widgets/diagonal_stripes_shimmer.dart';
import 'widgets/image_viewer_bottomsheet.dart';

class ZoneItemPage extends StatefulWidget {
  const ZoneItemPage({
    super.key,
    required this.imageZone,
    required this.onTakePicTure,
    required this.onDeleteImage,
  });

  final ImageZone imageZone;
  final OnTakePicTure onTakePicTure;
  final OnDeleteImage onDeleteImage;

  @override
  State<ZoneItemPage> createState() => _ZoneItemPageState();
}

class _ZoneItemPageState extends State<ZoneItemPage>
    with AutomaticKeepAliveClientMixin {
  List<MyImage> get _banners => widget.imageZone.sampleImages;

  List<MyImage> get _images => widget.imageZone.myImages;

  ImageResult get _result => widget.imageZone.result;

  bool get _finalComplianceStatus => widget.imageZone.finalComplianceStatus;

  bool get _showVerifyImageButton =>
      (widget.imageZone.myImages.isNotEmpty &&
          _result.status != MyImageStatus.verified &&
          _result.status != MyImageStatus.processing) ||
      !_finalComplianceStatus;

  bool get _showTakePickTureButton =>
      (_result.status != MyImageStatus.verified &&
          _result.status != MyImageStatus.processing) ||
      !_finalComplianceStatus;

  double get _bottom => MediaQuery.of(context).padding.bottom;

  String? _selectedReason;

  final _reasons = ['Chấm sai', 'Chấm sai 1', 'Chấm sai 2', 'Chấm sai 3'];

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Stack(
      children: [
        SingleChildScrollView(
          padding: EdgeInsets.only(
            left: 16,
            right: 16,
            bottom: _bottom + 24,
            top: 12,
          ),
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
        Positioned(
          left: 16,
          right: 16,
          bottom: _bottom - 12,
          child: _buildAction(),
        ),
      ],
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
              isShowDelete: false,
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
            InkWell(
              onTap: () {
                showInformDialog(
                  context: context,
                  message:
                      'Chỉ chụp 1 hình trưng bày rõ nét các sản phẩm đặt trên kệ. Nếu kệ quá dài thì chụp từng phần kệ, hệ thống sẽ ghép thành 1 hình sau khi chấm hình',
                );
              },
              child: Row(
                children: [
                  AppText(
                    text: 'Ghép nhiều hình',
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: AppColors.color4D4D4D,
                  ),
                  const SizedBox(width: 8.0),
                  AppIcon.icImageInfo.widget(),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        _images.isEmpty ? _emptyImage() : _buildMultiImages(),
      ],
    );
  }

  Widget _emptyImage() {
    return InkWell(
      onTap: widget.onTakePicTure,
      child: DottedBorder(
        options: RoundedRectDottedBorderOptions(
          dashPattern: [6, 5],
          strokeWidth: 1,
          radius: Radius.circular(20),
          color: AppColors.colorC2C2C2,
        ),
        child: SizedBox(
          width: Get.width,
          height: 225,
          child: Padding(
            padding: const EdgeInsets.all(62.5),
            child: AppIcon.captureImage.widget(),
          ),
        ),
      ),
    );
  }

  Widget _buildMultiImages() {
    final width = Get.width - 30;
    final height = 255.0;
    return CustomSliderImage(
      images: _images,
      width: width,
      height: height,
      initCurrentImage: _images.length - 1,
      key: ValueKey('multiImages'),
      onViewImage: (index) {
        _openImageViewerBottomSheet(
          context: context,
          title: "Hình ảnh trưng bày",
          photos: _images,
          initPage: index,
          isShowDelete: true,
        );
      },
      showImageAddress: true,
    );
  }

  /// Capture / Get point
  Widget _buildCapture() {
    return Row(
      children: [
        Expanded(
          child: _showTakePickTureButton
              ? CustomBorderButton(
                  title: 'Chụp hình mới',
                  onPressed: () async {
                    widget.onTakePicTure();
                  },
                  icon: AppIcon.icCamera.widget(),
                  borderColor: AppColors.color3A73FF,
                  textColor: AppColors.color3A73FF,
                )
              : SizedBox.shrink(),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: _showVerifyImageButton
              ? CustomButton(text: 'Chấm hình', onPressed: () {})
              : SizedBox.shrink(),
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
                  AppText(
                    text: 'Kết quả: ',
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                  AppText(
                    text: _result.status.name,
                    fontSize: 14,
                    color: _result.status.color,
                  ),
                ],
              ),
              Row(
                children: [
                  AppText(
                    text: 'Người: ',
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                  AppText(
                    text: _result.name,
                    fontSize: 14,
                    color: AppColors.black,
                  ),
                ],
              ),
              Row(
                children: [
                  AppText(
                    text: 'Ngày: ',
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                  AppText(
                    text: _result.resultDate,
                    fontSize: 14,
                    color: AppColors.black,
                  ),
                ],
              ),
              if (_result.status == MyImageStatus.processing) ...[
                const SizedBox(height: 8),
                DiagonalStripesShimmer(
                  height: 14,
                  width: Get.width,
                  stripeWidth: 12,
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }

  /// Confirm / Feedback
  Widget _buildAction() {
    if (_result.status == MyImageStatus.processing ||
        _result.status == MyImageStatus.created ||
        _finalComplianceStatus) {
      return Container();
    }
    return Container(
      color: AppColors.white,
      child: Row(
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
      ),
    );
  }

  /// Feedback
  void showDropdownReasonDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setStateBottom) {
            return Dialog(
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
                                setState(() {
                                  _selectedReason = value!;
                                });
                                setStateBottom(() {});
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
            );
          },
        );
      },
    );
  }

  /// open images bottom sheet
  void _openImageViewerBottomSheet({
    required BuildContext context,
    required String title,
    required List<MyImage> photos,
    required int initPage,
    required bool isShowDelete,
  }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.black12.withValues(alpha: 0.3),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setStateBottom) {
            return ImageViewerBottomSheet(
              title: title,
              photos: photos,
              initPage: initPage,
              isShowDelete: isShowDelete,
              onImageAction: (imageIndex) {
                showConfirmDialog(
                  context: context,
                  message: 'Bạn chắc chắn xóa hình?',
                  onConfirm: () {
                    widget.onDeleteImage(imageIndex);
                    Future.delayed(const Duration(milliseconds: 100), () {
                      if (_images.isEmpty) Get.back();
                    });
                    setState(() {}); // rebuild parent
                    setStateBottom(() {}); // rebuild bottom sheet
                  },
                );
              },
            );
          },
        );
      },
    );
  }
}
