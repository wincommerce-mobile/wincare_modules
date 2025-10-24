import 'environments/environment.dart';

mixin AppConfigType {
  /// Base domain
  late String baseDomain;
}

class AppConfig with AppConfigType {
  static final AppConfig shared = AppConfig._instance();

  factory AppConfig({required Environment env}) {
    shared.env = env;
    return shared;
  }

  AppConfig._instance();

  Environment? env;

  @override
  String get baseDomain => env?.baseDomain ?? '';
}
