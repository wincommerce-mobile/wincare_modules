import 'dart:math' as math;
import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image/image.dart' as img;

import '../../../../app/app_icon.dart';

class SmartNetworkImage extends StatefulWidget {
  const SmartNetworkImage({
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
  State<SmartNetworkImage> createState() => _CustomNetworkImageState();
}

class _CustomNetworkImageState extends State<SmartNetworkImage> {
  bool? _isLandscape;
  Uint8List? _imageBytes;

  @override
  void initState() {
    super.initState();
    if (widget.url.isNotEmpty) _fetchAndDetect(widget.url);
  }

  Future<void> _fetchAndDetect(String url) async {
    try {
      final dio = Dio();
      final response = await dio.get<List<int>>(
        url,
        options: Options(responseType: ResponseType.bytes),
      );

      final bytes = Uint8List.fromList(response.data!);
      final decoded = img.decodeImage(bytes);

      if (decoded != null) {
        setState(() {
          _isLandscape = decoded.width > decoded.height;
          _imageBytes = bytes;
        });
      }
    } catch (e) {
      debugPrint('Dio image fetch/orientation detection failed: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.url.isEmpty) {
      return AppIcon.placeholder.widget(
        height: widget.height,
        width: widget.width,
        fit: BoxFit.cover,
      );
    }

    // Still loading or detection pending
    if (_imageBytes == null || _isLandscape == null) {
      return CachedNetworkImage(
        imageUrl: widget.url,
        height: widget.height,
        width: widget.width,
        fit: widget.fit ?? BoxFit.cover,
        placeholder: (context, url) => AppIcon.placeholder.widget(
          height: widget.height,
          width: widget.width,
        ),
        errorWidget: (context, url, error) => AppIcon.placeholder.widget(
          height: widget.height,
          width: widget.width,
          fit: BoxFit.cover,
        ),
      );
    }

    // Display the processed image
    final imageWidget = Image.memory(
      _imageBytes!,
      height: widget.height,
      width: widget.width,
      fit: BoxFit.fill,
    );

    // Rotate if it’s landscape
    return _isLandscape!
        ? Transform.rotate(angle: 90 * math.pi / 180, child: imageWidget)
        : imageWidget;
  }
}
