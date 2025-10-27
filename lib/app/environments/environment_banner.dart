import 'package:flutter/material.dart';

import '../app_service.dart';
import 'environment.dart';

class EnvironmentBanner extends StatelessWidget {
  final Widget child;

  const EnvironmentBanner({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    if (AppService().environment == Environment.pro) {
      return child;
    }

    return Banner(
      message: AppService().environment,
      location: BannerLocation.topEnd,
      color: _getBannerColor(),
      child: child,
    );
  }

  Color _getBannerColor() {
    switch (AppService().environment) {
      case Environment.uat:
        return Colors.orange;
      case Environment.dev:
        return Colors.green;
      default:
        return Colors.purple;
    }
  }
}
