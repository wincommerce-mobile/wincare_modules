import '../../../app/app_secure_storage.dart';
import 'base/base_request.dart';

class GlobalRequestBuilder {
  static Future<BaseRequest<T>> build<T>(
    T? params, {
    double? lat,
    double? lng,
  }) async {
    final user = await AppSecureStorage.getUser();

    final lat = 0.0;
    final lng = 0.0;

    return BaseRequest<T>(
      params: params,
      lat: lat,
      lng: lng,
      sessionKey: user?.sessionLogin,
      uid: user?.userId,
    );
  }
}
