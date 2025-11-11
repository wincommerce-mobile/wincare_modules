import 'dart:io';

import '../../../app/app_secure_storage.dart';
import 'base/base_request.dart';

class GlobalRequestBuilder {
  static Future<BaseRequest<T>> build<T>(
    T? params, {
    double? lat,
    double? lng,
  }) async {
    final requestData = await AppSecureStorage.getRequestData();
    final osName = Platform.isAndroid ? 'Android' : 'iOS';

    final lat = 0.0;
    final lng = 0.0;

    return BaseRequest<T>(
      params: params,
      lat: lat,
      lng: lng,
      osName: osName,
      versionInfo: requestData?.versionInfo,
      sessionKey: requestData?.sessionLogin,
      uid: requestData?.userId,
    );
  }
}
