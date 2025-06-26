import 'package:flutter/material.dart';

class AppText extends StatelessWidget {
  const AppText({
    super.key,
    required this.text,
    this.height,
    this.fontSize = 19,
    this.fontWeight = FontWeight.w700,
  });

  final String text;
  final FontWeight? fontWeight;
  final double? height;
  final double? fontSize;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontFamily: 'Roboto',
        fontWeight: fontWeight,
        height: height,
        fontSize: fontSize,
      ),
    );
  }
}
