import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'app/app_pages.dart';

void main() {
  runApp(MainApp(initialRoute: AppRoutes.selectLabel));
}

@pragma('vm:entry-point')
void printReceipt() {
  runApp(MainApp(initialRoute: AppRoutes.receipt));
}

@pragma('vm:entry-point')
void printItems() {
  runApp(MainApp(initialRoute: AppRoutes.selectLabel));
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
    );
  }
}
