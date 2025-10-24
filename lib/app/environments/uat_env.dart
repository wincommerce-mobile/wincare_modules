import 'environment.dart';

extension UatEnvironment on Environment {
  static Environment env() {
    return Environment(envName: "UAT", baseDomain: "https://api-logistics-test.winmart.vn/wincare_uat");
  }
}
