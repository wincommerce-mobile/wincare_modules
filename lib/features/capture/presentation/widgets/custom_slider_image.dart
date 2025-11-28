import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:wincare_modules/features/capture/presentation/widgets/image_label.dart';

import '../../../../app/app_colors.dart';
import '../../../../app/app_function.dart';
import '../../../../app/app_icon.dart';
import '../../../../app/app_text.dart';
import '../../domain/entities/capture/image_template_entity.dart';
import '../capture_controller.dart';
import 'custom_network_image.dart';

class CustomSliderImage extends StatefulWidget {
  const CustomSliderImage({
    super.key,
    required this.images,
    required this.width,
    required this.height,
    this.showImageAddress = false,
    this.onImageAction,
    this.initCurrentImage = 0,
    required this.onViewImage,
  });

  final List<SampleImageEntity> images;
  final double width;
  final double height;
  final int initCurrentImage;
  final bool showImageAddress;
  final OnImageAction? onImageAction;
  final OnViewImage onViewImage;

  @override
  State<CustomSliderImage> createState() => _CustomSliderImageState();
}

class _CustomSliderImageState extends State<CustomSliderImage> {
  List<SampleImageEntity> get _images => widget.images;

  double get _width => widget.width;

  double get _height => widget.height;

  bool get _showImageAddress => widget.showImageAddress;

  int _currentImage = 0;
  final _carouselController = CarouselSliderController();

  @override
  void initState() {
    super.initState();
    _currentImage = widget.initCurrentImage;
  }

  @override
  void didUpdateWidget(covariant CustomSliderImage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.initCurrentImage != widget.initCurrentImage) {
      _carouselController.animateToPage(widget.initCurrentImage);
      setState(() {
        _currentImage = widget.initCurrentImage;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CarouselSlider(
          carouselController: _carouselController,
          options: CarouselOptions(
            height: _height,
            autoPlay: false,
            enableInfiniteScroll: false,
            viewportFraction: 1,
            enlargeCenterPage: true,
            onPageChanged: (index, reason) {
              setState(() {
                _currentImage = index;
              });
            },
          ),
          items: _images
              .map(
                (myImage) => Stack(
                  children: [
                    InkWell(
                      onTap: () {
                        widget.onViewImage(_images.indexOf(myImage));
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16.0),
                        child: CustomNetworkImage(
                                url: myImage.url ?? '',
                                fit: BoxFit.contain,
                                width: _width,
                                height: _height,
                              )
                            ,
                      ),
                    ),
                    !_showImageAddress
                        ? Container()
                        : Positioned(
                            left: 14,
                            bottom: 0,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                AppText(
                                  text: myImage.takenDate ?? '',
                                  color: AppColors.white,
                                  backgroundColor: AppColors.black,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                ),
                                const SizedBox(height: 2),
                                AppText(
                                  text: myImage.address ?? '',
                                  fontSize: 10,
                                  backgroundColor: AppColors.black,
                                  color: AppColors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ],
                            ),
                          ),
                    widget.onImageAction == null
                        ? Container()
                        : Positioned(
                            top: 6,
                            right: 6,
                            child: InkWell(
                              onTap: () {
                                widget.onImageAction!(_images.indexOf(myImage));
                              },
                              child: AppIcon.icMoreAction.widget(),
                            ),
                          ),
                    myImage.isHandled
                        ? Positioned(
                            top: 12,
                            right: 0,
                            child: ImageLabel(
                              label: 'Hình đã xử lý',
                              textSize: 12,
                            ),
                          )
                        : SizedBox.shrink(),
                  ],
                ),
              )
              .toList(),
        ),
        const SizedBox(height: 6),
        _images.length > 1
            ? Center(
                child: AnimatedSmoothIndicator(
                  count: _images.length,
                  activeIndex: _currentImage,
                  effect: WormEffect(
                    dotHeight: 10,
                    dotWidth: 10,
                    activeDotColor: AppColors.color3A73FF,
                    dotColor: AppColors.colorC0C0C0,
                  ),
                ),
              )
            : Container(),
      ],
    );
  }
}
