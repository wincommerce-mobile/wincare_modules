import 'package:flutter/material.dart';

class CustomRadio extends StatefulWidget {
  final bool initialValue;
  final ValueChanged<bool> onChanged;

  const CustomRadio({
    super.key,
    required this.initialValue,
    required this.onChanged,
  });

  @override
  State<CustomRadio> createState() => _CustomRadioState();
}

class _CustomRadioState extends State<CustomRadio> {
  late bool isChecked;

  @override
  void initState() {
    super.initState();
    isChecked = widget.initialValue;
  }

  void toggleCheckbox() {
    setState(() {
      isChecked = !isChecked;
    });
    widget.onChanged(isChecked);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: toggleCheckbox,
      child: isChecked
          ? Image.asset(
              "assets/images/radio_selected.png",
              width: 24,
              height: 24,
              fit: BoxFit.cover,
            )
          : Image.asset(
              "assets/images/radio.png",
              width: 24,
              height: 24,
              fit: BoxFit.cover,
            ),
    );
  }
}
