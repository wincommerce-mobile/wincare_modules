import 'environment.dart';

extension ProductionEnvironment on Environment {
  static Environment env() {
    return Environment(
      envName: "PRO",
      baseDomain: "https://api-wincare-report.winmart.vn",
    );
  }
}
