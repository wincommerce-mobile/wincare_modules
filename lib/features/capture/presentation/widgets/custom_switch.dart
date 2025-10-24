import 'package:flutter/material.dart';
import 'package:wincare_modules/app/app_colors.dart';

import '../../../../app/app_icon.dart';
import '../../../../app/app_text.dart';

class CustomSwitch extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;
  final String label;

  const CustomSwitch({
    super.key,
    required this.value,
    required this.onChanged,
    this.label = "Ghép nhiều hình",
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onChanged(!value),
      child: Row(
        children: [
          value ? AppIcon.icSwitchOn.widget() : AppIcon.icSwitchOff.widget(),
          const SizedBox(width: 8.0),
          AppText(text: label, fontSize: 12, color: AppColors.color4D4D4D),
        ],
      ),
    );
  }
}
