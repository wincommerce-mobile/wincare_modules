import 'package:flutter/material.dart';
import 'dart:math' as math;

class DiagonalStripesShimmer extends StatefulWidget {
  final double height;
  final double width;
  final double stripeWidth; // độ rộng của stripe (và gap sẽ = stripeWidth)
  final Duration duration;
  final double horizontalPadding;
  final double borderRadius;

  const DiagonalStripesShimmer({
    super.key,
    this.height = 27,
    this.width = 400,
    this.stripeWidth = 16,
    this.duration = const Duration(seconds: 2),
    this.horizontalPadding = 16,
    this.borderRadius = 8,
  });

  @override
  State<DiagonalStripesShimmer> createState() => _DiagonalStripesShimmerState();
}

class _DiagonalStripesShimmerState extends State<DiagonalStripesShimmer>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration)
      ..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      width: widget.width,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return CustomPaint(
            painter: _DiagonalStripesPainter(
              progress: _controller.value,
              stripeWidth: widget.stripeWidth,
              padding: 0,
              borderRadius: widget.borderRadius,
            ),
          );
        },
      ),
    );
  }
}

class _DiagonalStripesPainter extends CustomPainter {
  final double progress;
  final double stripeWidth;
  final double padding;
  final double borderRadius;

  _DiagonalStripesPainter({
    required this.progress,
    required this.stripeWidth,
    required this.padding,
    required this.borderRadius,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // vùng nội dung sau khi trừ padding 2 bên
    final contentLeft = padding;
    final contentTop = 0.0;
    final contentWidth = size.width - padding * 2;
    final contentHeight = size.height;

    final RRect contentRRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(contentLeft, contentTop, contentWidth, contentHeight),
      Radius.circular(borderRadius),
    );

    // 1) vẽ nền với bo góc
    final Paint backgroundPaint = Paint()
      ..color = Color(0xFFE9EDF1)
      ..style = PaintingStyle.fill;
    canvas.drawRRect(contentRRect, backgroundPaint);

    // 2) clip với RRect (rất quan trọng: clip trước khi vẽ stripe)
    canvas.save();
    canvas.clipRRect(contentRRect);

    // 3) translate origin vào góc trái trên vùng nội dung để dễ tính toán
    canvas.translate(contentLeft, contentTop);

    // 4) chuẩn bị paint cho stripe
    final Paint stripePaint = Paint()
      ..color = Color(0xFFF4F7FA)
      ..style = PaintingStyle.fill;

    // 5) để tạo stripe nghiêng 45°, ta rotate canvas -45deg rồi vẽ các thanh dọc
    //    khi rotate, chiều cần cover là đường chéo của rectangle
    final double w = contentWidth;
    final double h = contentHeight;
    final double diag = math.sqrt(w * w + h * h);

    // spacing giữa tâm các stripe = stripeWidth + gap. Ta muốn stripe và gap bằng nhau,
    // nên spacing = stripeWidth * 2
    final double spacing = stripeWidth * 2.0;

    // offset animation (mod spacing để vòng lặp mượt)
    final double dxOffset = (progress * spacing) % spacing;

    // rotate about center of content
    canvas.save();
    canvas.translate(w / 2.0, h / 2.0);
    canvas.rotate(-math.pi / 4); // -45 độ

    // vẽ các thanh dọc trải dài để che toàn bộ diag
    // vì đã translate đến center, ta vẽ từ -diag/2 đến +diag/2
    final double startX = -diag / 2.0 - spacing;
    final double endX = diag / 2.0 + spacing;

    for (double x = startX; x <= endX; x += spacing) {
      final double left = x - dxOffset;
      // thanh dọc có width = stripeWidth, cao = diag (đủ dài để cover)
      final Rect r = Rect.fromLTWH(left, -diag / 2.0, stripeWidth, diag);
      canvas.drawRect(r, stripePaint);
    }

    canvas.restore(); // restore sau khi rotate & vẽ

    canvas.restore(); // restore sau khi clip

    // nếu bạn muốn viền nhẹ (tuỳ chọn) sử dụng:
    // final Paint border = Paint()..color = Colors.grey.shade300..style = PaintingStyle.stroke;
    // canvas.drawRRect(contentRRect, border);
  }

  @override
  bool shouldRepaint(covariant _DiagonalStripesPainter oldDelegate) =>
      oldDelegate.progress != progress ||
      oldDelegate.stripeWidth != stripeWidth ||
      oldDelegate.padding != padding ||
      oldDelegate.borderRadius != borderRadius;
}
