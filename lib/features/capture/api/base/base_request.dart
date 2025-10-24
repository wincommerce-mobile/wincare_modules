class BaseRequest<T> {
  T? params;
  int? uid;
  String? sessionKey;
  String? versionInfo;
  bool? checkedLocation;
  double? lat;
  double? lng;

  BaseRequest({
    this.params,
    this.uid = 0,
    this.sessionKey = '',
    this.versionInfo = '',
    this.checkedLocation = false,
    this.lat = 0.0,
    this.lng = 0.0,
  });

  Map<String, dynamic> toJson(Map<String, dynamic> Function(T?) toJsonT) {
    return {
      'Params': params != null ? toJsonT(params) : null,
      'Uid': uid,
      'SessionKey': sessionKey,
      'VersionInfo': versionInfo,
      'CheckedLocation': checkedLocation,
      'Lat': lat,
      'Lng': lng,
    };
  }
}
