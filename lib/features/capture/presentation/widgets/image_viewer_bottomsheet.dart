import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wincare_modules/app/app_icon.dart';
import 'package:wincare_modules/features/capture/presentation/capture_controller.dart';

import '../../../../app/app_colors.dart';
import '../../../../app/app_function.dart';
import '../../../../app/app_text.dart';
import '../../domain/entities/capture/image_template_entity.dart';
import 'custom_network_image.dart';
import 'dismissible_page.dart';
import 'smart_network_image.dart';

class ImageViewerBottomSheet extends StatefulWidget {
  ImageViewerBottomSheet({
    super.key,
    required this.title,
    required this.photos,
    required this.onImageAction,
    this.isShowDelete = false,
    int? initPage,
  }) : pageController = PageController(initialPage: initPage ?? 0);

  final String title;
  final bool isShowDelete;
  final List<SampleImageEntity> photos;
  final OnImageAction onImageAction;
  final PageController pageController;

  @override
  State<ImageViewerBottomSheet> createState() => _ImageViewerBottomSheetState();
}

class _ImageViewerBottomSheetState extends State<ImageViewerBottomSheet> {
  int _currentPage = 0;
  List<SampleImageEntity> _photos = [];

  double get _bottom => widget.isShowDelete ? 133 : 42;

  bool get _showLeft => _currentPage > 0 && _photos.length > 1;

  bool get _showRight =>
      _currentPage < _photos.length - 1 && _photos.length > 1;

  @override
  void initState() {
    super.initState();
    _currentPage = widget.pageController.initialPage;
    _photos = widget.photos;
  }

  @override
  void didUpdateWidget(covariant ImageViewerBottomSheet oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.pageController.initialPage !=
        widget.pageController.initialPage) {
      setState(() {
        _currentPage = widget.pageController.initialPage;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return DismissiblePage(
      child: SizedBox(
        height: Get.height * .95,
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: 42,
                  color: AppColors.red,
                  width: double.infinity,
                  alignment: Alignment.center,
                  child: AppText(
                    text: widget.title.toUpperCase(),
                    color: AppColors.white,
                    fontSize: 16,
                    textAlign: TextAlign.center,
                  ),
                ),
                Positioned(
                  left: 12,
                  top: 12,
                  child: InkWell(
                    onTap: () => Get.back(),
                    child: Icon(Icons.close, color: AppColors.white),
                  ),
                ),
              ],
            ),
            Expanded(
              child: Container(
                color: AppColors.white,
                child: Stack(
                  children: [
                    PageView.builder(
                      controller: widget.pageController,
                      itemCount: _photos.length,
                      physics: ClampingScrollPhysics(),
                      onPageChanged: (page) {
                        setState(() {
                          _currentPage = page;
                        });
                      },
                      itemBuilder: (context, index) {
                        final photo = _photos[index];
                        return Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Stack(
                              children: [
                                InteractiveViewer(
                                  panEnabled: true,
                                  minScale: 1,
                                  maxScale: 5,
                                  child: photo.url != null
                                      ? CustomNetworkImage(
                                          url: photo.url!,
                                          height: Get.height * .92 - _bottom,
                                          fit: BoxFit.contain,
                                        )
                                      : Image.file(
                                          File(photo.path!.path),
                                          height: Get.height * .92 - _bottom,
                                          fit: BoxFit.contain,
                                        ),
                                ),

                                widget.isShowDelete
                                    ? Positioned(
                                        left: 4,
                                        bottom: 4,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            AppText(
                                              text: photo.takenDate ?? '',
                                              color: AppColors.white,
                                              backgroundColor: AppColors.black,
                                              fontSize: 10,
                                              fontWeight: FontWeight.bold,
                                            ),
                                            const SizedBox(height: 2),
                                            AppText(
                                              text: photo.address ?? '',
                                              fontSize: 10,
                                              backgroundColor: AppColors.black,
                                              color: AppColors.white,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ],
                                        ),
                                      )
                                    : Container(),
                              ],
                            ),
                            !(widget.isShowDelete) ||
                                    photo.isHandled ||
                                    !photo.isAllowEdit
                                ? SizedBox.shrink()
                                : InkWell(
                                    onTap: () {
                                      widget.onImageAction(index);
                                    },
                                    child: Container(
                                      height: 60,
                                      width: Get.width,
                                      color: AppColors.white,
                                      child: Column(
                                        children: [
                                          const SizedBox(height: 10),
                                          AppIcon.icDelete.widget(
                                            color: AppColors.red,
                                          ),
                                          const SizedBox(height: 4),
                                          AppText(
                                            text: 'Xoá ảnh',
                                            fontSize: 12,
                                            color: AppColors.color4D4D4D,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                          ],
                        );
                      },
                    ),
                    _showLeft
                        ? Align(
                            alignment: Alignment.centerLeft,
                            child: IconButton(
                              onPressed: () {
                                widget.pageController.previousPage(
                                  duration: Duration(milliseconds: 300),
                                  curve: Curves.easeInOut,
                                );
                              },
                              icon: Icon(
                                Icons.arrow_back_ios,
                                color: AppColors.white,
                                size: 32,
                              ),
                            ),
                          )
                        : Container(),
                    _showRight
                        ? Align(
                            alignment: Alignment.centerRight,
                            child: IconButton(
                              onPressed: () {
                                widget.pageController.nextPage(
                                  duration: Duration(milliseconds: 300),
                                  curve: Curves.easeInOut,
                                );
                              },
                              icon: Icon(
                                Icons.arrow_forward_ios,
                                color: AppColors.white,
                                size: 32,
                              ),
                            ),
                          )
                        : Container(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
