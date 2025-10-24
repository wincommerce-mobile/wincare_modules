import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../app/app_colors.dart';
import '../../../../app/app_text.dart';
import 'custom_network_image.dart';
import 'dismissible_page.dart';

class ImageViewerBottomSheet extends StatefulWidget {
  ImageViewerBottomSheet({
    super.key,
    required this.title,
    required this.photos,
    int? initPage,
  }) : pageController = PageController(initialPage: initPage ?? 0);

  final String title;
  final List<String> photos;
  final PageController pageController;

  @override
  State<ImageViewerBottomSheet> createState() => _ImageViewerBottomSheetState();
}

class _ImageViewerBottomSheetState extends State<ImageViewerBottomSheet> {
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _currentPage = widget.pageController.initialPage;
  }

  @override
  Widget build(BuildContext context) {
    return DismissiblePage(
      child: SizedBox(
        height: Get.height * .92,
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
                    text: widget.title,
                    color: AppColors.white,
                    fontSize: 14,
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
              child: Stack(
                children: [
                  PageView.builder(
                    controller: widget.pageController,
                    itemCount: widget.photos.length,

                    physics: ClampingScrollPhysics(),
                    onPageChanged: (page) {
                      setState(() {
                        _currentPage = page;
                      });
                    },
                    itemBuilder: (context, index) {
                      return CustomNetworkImage(
                        url: widget.photos[index],
                        fit: BoxFit.fill,
                      );
                    },
                  ),
                  _currentPage > 0
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
                  _currentPage < widget.photos.length - 1
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
          ],
        ),
      ),
    );
  }
}
