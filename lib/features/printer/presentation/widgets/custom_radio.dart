import 'package:flutter/material.dart';

class CustomRadioExample extends StatefulWidget {
  const CustomRadioExample({super.key});

  @override
  State<CustomRadioExample> createState() => _CustomRadioExampleState();
}

class _CustomRadioExampleState extends State<CustomRadioExample> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(3, (index) {
        return GestureDetector(
          onTap: () {
            setState(() {
              selectedIndex = index;
            });
          },
          child: Image.asset(
            selectedIndex == index
                ? 'assets/images/radio_selected.png'
                : 'assets/images/radio.png',
            width: 24,
            height: 24,
            fit: BoxFit.cover,
          ),
        );
      }),
    );
  }
}
