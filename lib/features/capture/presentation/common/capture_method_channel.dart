import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

import '../../../../app/app_constants.dart';

class CaptureMethodChannel {
  static final _channel = MethodChannel(AppConstants.captureChannel);

  static Future<void> logOut() async {
    try {
      await _channel.invokeMethod(AppConstants.onSessionExpired);
    } catch (e) {
      debugPrint('Error calling native back: $e');
    }
  }
}
