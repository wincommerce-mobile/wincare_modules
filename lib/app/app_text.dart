import 'package:flutter/material.dart';

class AppText extends StatelessWidget {
  const AppText({
    super.key,
    required this.text,
    this.height,
    this.fontSize = 19,
    this.color = Colors.black,
    this.backgroundColor,
    this.textAlign,
    this.fontStyle,
    this.fontWeight = FontWeight.w700,
  });

  final String text;
  final FontWeight? fontWeight;
  final double? height;
  final Color? color;
  final Color? backgroundColor;
  final TextAlign? textAlign;
  final FontStyle? fontStyle;
  final double? fontSize;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      style: TextStyle(
        fontFamily: 'Roboto',
        color: color,
        fontStyle: fontStyle,
        backgroundColor: backgroundColor,
        fontWeight: fontWeight,
        height: height,
        fontSize: fontSize,
      ),
    );
  }
}
