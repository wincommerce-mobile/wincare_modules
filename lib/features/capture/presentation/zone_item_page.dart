import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wincare_modules/app/app_extensions.dart';
import 'package:wincare_modules/features/capture/domain/entities/capture/complaint_reason_entity.dart';
import 'package:wincare_modules/features/capture/presentation/zone_controller.dart';

import '../../../app/app_colors.dart';
import '../../../app/app_enum.dart';
import '../../../app/app_function.dart';
import '../../../app/app_icon.dart';
import '../../../app/app_text.dart';
import '../domain/entities/capture/image_template_entity.dart';
import '../domain/entities/capture/result_image_garniture_entity.dart';
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
    required this.zoneController,
    required this.onGetImagePoint,
    required this.onUpdateFinalResult,
    required this.onRefreshZone,
  });

  final ImageTemplateEntity imageZone;
  final OnTakePicTure onTakePicTure;
  final OnDeleteImage onDeleteImage;
  final OnGetImagePoint onGetImagePoint;
  final OnUpdateFinalResult onUpdateFinalResult;
  final ZoneController zoneController;
  final VoidCallback onRefreshZone;

  @override
  State<ZoneItemPage> createState() => _ZoneItemPageState();
}

class _ZoneItemPageState extends State<ZoneItemPage>
    with AutomaticKeepAliveClientMixin {
  ZoneController get _zoneController => widget.zoneController;
  final int _maxImageZone = 8;

  final ScrollController _scrollController = ScrollController();

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeOut,
      );
    });
  }

  ImageTemplateEntity get _imageZone => widget.imageZone;

  List<SampleImageEntity> get _templateImages =>
      widget.imageZone.templateImage != null
      ? [widget.imageZone.templateImage!]
      : [];

  bool get _isAllowEdit =>
      _zoneController.requestDataModel?.isAllowEdit ?? true;

  bool get _isAllowAddImage =>
      _zoneController.requestDataModel?.isAllowAddImage ?? true;

  bool get _isAllowCancelImage =>
      _zoneController.requestDataModel?.isAllowCancelImage ?? true;

  bool get _isAllowSendApproval =>
      _zoneController.requestDataModel?.isAllowSendApproval ?? true;

  List<SampleImageEntity> get _images => widget.imageZone.sampleImages;

  ResultImageGarnitureEntity? get _result => widget.imageZone.result;

  bool get _hiddenAction {
    final condition1 = _result?.complianceStatusEnum == null;
    final condition2 =
        _result?.complianceStatusEnum == ComplianceStatusEnum.waitingResult;
    final condition3 =
        _result?.complianceStatusEnum == ComplianceStatusEnum.created;
    final condition4 = _finalComplianceStatus;
    final condition5 = !_isAllowEdit;
    final condition6 = widget.imageZone.sampleImages.isEmpty;
    final condition7 = !_imageZone.allImagesConfirmed;
    final condition8 = !_isAllowSendApproval;

    // Print each condition
    debugPrint('condition1 (complianceStatusEnum == null): $condition1');
    debugPrint('condition2 (waitingResult): $condition2');
    debugPrint('condition3 (created): $condition3');
    debugPrint('condition4 (_finalComplianceStatus): $condition4');
    debugPrint('condition5 (!_isAllowEdit): $condition5');
    debugPrint('condition6 (sampleImages.isEmpty): $condition6');
    debugPrint('condition7 (!allImagesConfirmed): $condition7');
    debugPrint('condition8 (!_isAllowSendApproval): $condition8');

    final result =
        condition1 ||
        condition2 ||
        condition3 ||
        condition4 ||
        condition5 ||
        condition6 ||
        condition7 ||
        condition8;

    print('=> _hiddenAction: $result');

    return result;
  }

  bool get _finalComplianceStatus => widget.imageZone.finalComplianceStatus;

  int get _unhandledImagesCount => widget.imageZone.sampleImages
      .where((image) => image.isHandled == false)
      .length;

  bool get _reachMaxZoneImages => _unhandledImagesCount >= _maxImageZone;

  bool get _allHandled => _images.every((img) => img.isHandled);

  bool get _isSendConfirm => _images.every((img) => img.isSendConfirm);

  bool get _hiddenVerifyImageButton {
    if (!_isAllowEdit) {
      return true;
    }
    if (widget.imageZone.sampleImages.isEmpty) {
      return true;
    }
    if (!_isAllowSendApproval) {
      return true;
    }
    if (_allHandled) {
      return true;
    }

    if (_isSendConfirm) {
      return true;
    }
    if (_finalComplianceStatus) {
      return true;
    }
    if (_result != null &&
        _result?.complianceStatusEnum != null &&
        _result?.complianceStatusEnum == ComplianceStatusEnum.waitingResult) {
      return true;
    }

    return false;
  }

  bool get _hiddenTakePickTureButton {
    if (!_isAllowEdit) {
      return true;
    }
    if (!_isAllowAddImage) {
      return true;
    }
    if (_reachMaxZoneImages) {
      return true;
    }
    if (_finalComplianceStatus) {
      return true;
    }
    if (_result != null &&
        _result?.complianceStatusEnum != null &&
        _result?.complianceStatusEnum == ComplianceStatusEnum.waitingResult) {
      return true;
    }

    return false;
  }

  bool get _showResult => _result?.complianceStatusEnum != null;

  double get _bottom => MediaQuery.of(context).padding.bottom;

  int _currentIndex = 0;

  List<ComplaintReasonEntity> get _reasons => _zoneController.reasons;

  ComplaintReasonEntity? get _selectedReason =>
      _zoneController.selectedReason.value;

  Future<void> onGetPoint() async {
    _zoneController.imageResult.listen((result) {
      debugPrint(
        'onGetPoint: ${result?.complianceStatusEnum} - ${result?.createdByName}',
      );
      if (result != null) {
        widget.onGetImagePoint(result);
        if (result.complianceStatusEnum == ComplianceStatusEnum.passed ||
            result.complianceStatusEnum == ComplianceStatusEnum.notPassed) {
          widget.onRefreshZone();
        }

        _scrollToBottom();
      }
    });
    await _zoneController.samplingSentApprovalImage();
  }

  Future<void> onConfirm() async {
    final result = await _zoneController.samplingConfirmImage();
    _zoneController.updateFinalResult(result);
    widget.onUpdateFinalResult(result);
  }

  Future<void> onComplaint() async {
    final result = await _zoneController.promotionAivComplaint();
    _zoneController.updateFinalResult(result);
    widget.onUpdateFinalResult(result);
  }

  @override
  void initState() {
    super.initState();
    if (_reasons.isEmpty) {
      _zoneController.getComplaintReason();
    }
    debugPrint(
      '_isAllowAddImage: $_isAllowAddImage - _isAllowCancelImage: $_isAllowCancelImage - _isAllowSendApproval: $_isAllowSendApproval',
    );
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Stack(
      children: [
        RefreshIndicator(
          onRefresh: () async {
            await _zoneController.onRefresh();
          },
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            controller: _scrollController,
            padding: EdgeInsets.only(
              left: 16,
              right: 16,
              bottom: _bottom + 32,
              top: 12,
            ),
            child: Column(
              children: [
                _buildSlider(),
                const SizedBox(height: 24),
                _buildImages(),
                if (!_hiddenTakePickTureButton || !_hiddenVerifyImageButton)
                  const SizedBox(height: 24),
                _buildCapture(),
                const SizedBox(height: 24),
                _buildResult(),
                const SizedBox(height: 42),
              ],
            ),
          ),
        ),
        Positioned(left: 0, right: 0, bottom: 0, child: _buildAction()),
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
          images: _templateImages,
          width: width,
          height: height,
          onViewImage: (index) {
            _openImageViewerBottomSheet(
              context: context,
              title: "Hình ảnh trưng bày",
              photos: _templateImages,
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
                  message: _imageZone.collageImageToolTip ?? '',
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
      onTap: _hiddenTakePickTureButton
          ? null
          : () async {
              await widget.onTakePicTure();
              Future.delayed(const Duration(milliseconds: 100), () {
                setState(() {
                  _currentIndex = _images.length - 1;
                });
              });
            },
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
      initCurrentImage: _currentIndex,
      key: ValueKey('multiImages'),
      onViewImage: (index) {
        _openImageViewerBottomSheet(
          context: context,
          title: "Hình ảnh trưng bày",
          photos: _images,
          initPage: index,
          isShowDelete: (_isAllowEdit && _isAllowCancelImage),
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
          child: !_hiddenTakePickTureButton
              ? CustomBorderButton(
                  title: 'Chụp hình mới',
                  onPressed: () async {
                    await widget.onTakePicTure();
                    Future.delayed(const Duration(milliseconds: 100), () {
                      setState(() {
                        _currentIndex = _images.length - 1;
                      });
                    });
                  },
                  icon: AppIcon.icCamera.widget(),
                  borderColor: AppColors.color3A73FF,
                  textColor: AppColors.color3A73FF,
                )
              : SizedBox.shrink(),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: !_hiddenVerifyImageButton
              ? CustomButton(
                  text: 'Chấm hình',
                  onPressed: () {
                    onGetPoint();
                  },
                )
              : SizedBox.shrink(),
        ),
      ],
    );
  }

  /// Image result from api
  Widget _buildResult() {
    if (!_showResult) return SizedBox.shrink();
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
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.1),
                offset: const Offset(0, 2),
                blurRadius: 4,
                spreadRadius: 0,
              ),
            ],
          ),
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
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
                    text: _result?.complianceStatus ?? '',
                    fontSize: 14,
                    color: _result?.complianceStatusEnum?.color,
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
                  Expanded(
                    child: AppText(
                      text: _result?.createdByName ?? '',
                      fontSize: 14,
                      color: AppColors.black,
                    ),
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
                    text: _result?.createdDate?.toDisplayDateTime() ?? '',
                    fontSize: 14,
                    color: AppColors.black,
                  ),
                ],
              ),
              if (_result != null &&
                  _result!.complianceSummary != null &&
                  _result!.complianceSummary!.isNotEmpty)
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText(
                      text: 'Đánh giá: ',
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                    Expanded(
                      child: AppText(
                        text: _result?.complianceSummary ?? '',
                        fontSize: 14,
                        color: AppColors.black,
                      ),
                    ),
                  ],
                ),
              if (_result != null && _result!.products.isNotEmpty)
                ..._result!.products.map(
                  (e) => Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppText(
                        text: 'SKU: ',
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                      Expanded(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Flexible(
                              fit: FlexFit.loose,
                              child: AppText(
                                text: e.productName ?? '',
                                fontSize: 14,
                                color: AppColors.black,
                              ),
                            ),
                            AppText(
                              text: ' - Số mặt: ',
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                            AppText(
                              text: e.skuDetected ?? '',
                              fontSize: 14,
                              color: AppColors.black,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              if (_result?.complianceStatusEnum ==
                  ComplianceStatusEnum.waitingResult) ...[
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
    if (_hiddenAction) {
      return Container();
    }
    return Container(
      color: AppColors.white,
      padding: EdgeInsets.only(bottom: _bottom + 12, left: 12, right: 12),
      child: Row(
        children: [
          Expanded(
            child: CustomButton(
              text: 'Xác nhận',
              onPressed: () {
                showConfirmDialog(
                  context: context,
                  message: 'Bạn chắc chắn xác nhận kết quả?',
                  onConfirm: () async {
                    await onConfirm();
                  },
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
              onPressed: () async {
                _zoneController.setReasonList();
                Future.delayed(const Duration(milliseconds: 100), () {
                  debugPrint('ReasonList: ${_reasons.length}');
                  showDropdownReasonDialog();
                });
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
                            DropdownButtonFormField<ComplaintReasonEntity>(
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
                                return DropdownMenuItem<ComplaintReasonEntity>(
                                  value: item,
                                  child: AppText(
                                    text: item.reason ?? '',
                                    color: AppColors.black,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 12,
                                  ),
                                );
                              }).toList(),
                              onChanged: (value) {
                                _zoneController.setSelectReason(value);
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
                                  onComplaint();
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
    required List<SampleImageEntity> photos,
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
                  onConfirm: () async {
                    await widget.onDeleteImage(imageIndex);
                    Future.delayed(const Duration(milliseconds: 150), () {
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
