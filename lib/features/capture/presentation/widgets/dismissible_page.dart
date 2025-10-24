import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DismissiblePage extends StatelessWidget {
  const DismissiblePage({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        _dismiss(unFocus: context);
      },
      child: child,
    );
  }

  void _dismiss({BuildContext? unFocus}) {
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    if (unFocus != null) {
      FocusScope.of(unFocus).unfocus();
    }
  }
}
