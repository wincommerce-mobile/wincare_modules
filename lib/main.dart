import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:wincare_modules/app/app_service.dart';

import 'app/app_config.dart';
import 'app/app_pages.dart';
import 'app/environments/environment.dart';
import 'app/global.dart';

/// Environment
String environment = const String.fromEnvironment(
  'ENV',
  defaultValue: Environment.uat,
);

void main() {
  /// Init config for app based on environment
  AppService().environment = environment;
  AppConfig(env: Environment.getConfigEnvironment(environment));

  runApp(MainApp(initialRoute: AppRoutes.capture));
}

@pragma('vm:entry-point')
void printReceipt() {
  /// Init config for app based on environment
  AppService().environment = environment;
  AppConfig(env: Environment.getConfigEnvironment(environment));
  runApp(MainApp(initialRoute: AppRoutes.receipt));
}

@pragma('vm:entry-point')
void printItems() {
  /// Init config for app based on environment
  AppService().environment = environment;
  AppConfig(env: Environment.getConfigEnvironment(environment));

  runApp(MainApp(initialRoute: AppRoutes.printLabel));
}

@pragma('vm:entry-point')
void displayCapture() {
  /// Init config for app based on environment
  AppService().environment = environment;
  AppConfig(env: Environment.getConfigEnvironment(environment));

  runApp(MainApp(initialRoute: AppRoutes.capture));
}

class MainApp extends StatefulWidget {
  const MainApp({super.key, required this.initialRoute});

  /// Init route
  final String initialRoute;

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.blue,
        appBarTheme: const AppBarTheme(
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: widget.initialRoute,
      getPages: AppPages.pages,
      navigatorObservers: [navigationObserver],
      scaffoldMessengerKey: rootScaffoldMessengerKey,
      navigatorKey: navigatorKey,
    );
  }
}
