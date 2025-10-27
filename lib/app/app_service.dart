import 'environments/environment.dart';

class AppService {
  static final AppService _instance = AppService._internal();

  AppService._internal();

  factory AppService() {
    return _instance;
  }

  bool isCalledLogout = false;

  String environment = Environment.dev;
}
