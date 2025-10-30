import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

class AppConnectivity extends WidgetsBindingObserver {
  AppConnectivity._internal();

  static final AppConnectivity instance = AppConnectivity._internal();

  Future<bool> isInternetAvailable() async {
    final List<ConnectivityResult> connectivityResult = await Connectivity()
        .checkConnectivity();
    if (connectivityResult.any((result) => result != ConnectivityResult.none)) {
      return true;
    }
    return false;
  }
}
