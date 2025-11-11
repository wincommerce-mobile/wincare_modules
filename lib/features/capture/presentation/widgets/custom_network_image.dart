import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../app/app_icon.dart';

class CustomNetworkImage extends StatelessWidget {
  const CustomNetworkImage({
    super.key,
    required this.url,
    this.fit,
    this.height,
    this.width,
  });

  final String url;
  final BoxFit? fit;
  final double? height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    if (url.isEmpty) {
      return AppIcon.placeholder.widget(
        height: height,
        width: width,
        fit: BoxFit.cover,
      );
    }
    return CachedNetworkImage(
      imageUrl: url,
      height: height,
      width: width,
      fit: fit ?? BoxFit.cover,
      placeholder: (context, url) =>
          AppIcon.placeholder.widget(height: height, width: width, fit: BoxFit.cover),
      errorWidget: (context, url, error) => AppIcon.placeholder.widget(
        height: height,
        width: width,
        fit: BoxFit.cover,
      ),
    );
  }
}
