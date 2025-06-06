import 'package:flutter/material.dart';

class CustomDivider extends StatelessWidget {
  const CustomDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 1.5,
      color: Colors.black,
      margin: const EdgeInsets.symmetric(vertical: 12),
    );
  }
}
