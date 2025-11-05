import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../features/capture/domain/entities/request_data_model.dart';

class AppSecureStorage {
  static const _keyRequestData = 'request_data';

  static AndroidOptions _getAndroidOptions() =>
      const AndroidOptions(encryptedSharedPreferences: true);

  static final FlutterSecureStorage _storage = FlutterSecureStorage(
    aOptions: _getAndroidOptions(),
  );

  static Future<void> saveRequestData(RequestDataModel request) async {
    final jsonStr = jsonEncode(request.toJson());
    await _storage.write(key: _keyRequestData, value: jsonStr);
    debugPrint("saveRequest success: ${request.displayName}");
  }

  static Future<RequestDataModel?> getRequestData() async {
    final jsonStr = await _storage.read(key: _keyRequestData);
    if (jsonStr == null) return null;
    return RequestDataModel.fromJson(jsonDecode(jsonStr));
  }

  static Future<void> clearRequest() async {
    await _storage.delete(key: _keyRequestData);
  }
}
