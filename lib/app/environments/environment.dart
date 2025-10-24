import 'development_env.dart';
import 'production_env.dart';
import 'uat_env.dart';

class Environment {
  static const String dev = 'DEV';
  static const String uat = 'UAT';
  static const String pro = 'PRO';

  /// Prod environment
  factory Environment.production() {
    return ProductionEnvironment.env();
  }

  /// Uat environment
  factory Environment.userAcceptTest() {
    return UatEnvironment.env();
  }

  /// Dev environment
  factory Environment.development() {
    return DevelopmentEnvironment.env();
  }

  static Environment getConfigEnvironment(String env) {
    switch (env.toUpperCase()) {
      case dev:
        return Environment.development();
      case uat:
        return Environment.userAcceptTest();
      case pro:
        return Environment.production();
      default:
        return Environment.development();
    }
  }

  final String envName;
  final String baseDomain;

  Environment({required this.envName, required this.baseDomain});
}
