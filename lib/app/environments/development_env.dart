import 'environment.dart';

extension DevelopmentEnvironment on Environment {
  static Environment env() {
    return Environment(
      envName: "DEV",
      baseDomain: "https://api-wincare-test.winmart.vn",
    );
  }
}
