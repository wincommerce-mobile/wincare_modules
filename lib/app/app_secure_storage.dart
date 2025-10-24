import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../features/capture/domain/entities/user_entity.dart';

class AppSecureStorage {
  static const _keyUser = 'user';

  static AndroidOptions _getAndroidOptions() =>
      const AndroidOptions(encryptedSharedPreferences: true);

  static final FlutterSecureStorage _storage = FlutterSecureStorage(
    aOptions: _getAndroidOptions(),
  );

  static Future<void> saveUser(UserEntity user) async {
    final jsonStr = jsonEncode(user.toJson());
    await _storage.write(key: _keyUser, value: jsonStr);
  }

  static Future<UserEntity?> getUser() async {
    final jsonStr = await _storage.read(key: _keyUser);
    if (jsonStr == null) return null;
    return UserEntity.fromJson(jsonDecode(jsonStr));
  }

  static Future<void> clearUser() async {
    await _storage.delete(key: _keyUser);
  }
}
