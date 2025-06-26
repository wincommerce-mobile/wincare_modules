import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'app/app_pages.dart';

void main() {
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

@pragma('vm:entry-point')
void printerModule() {
  runApp(PrinterModule());
}

@pragma('vm:entry-point')
void scannerModule() {
  runApp(ScannerModule());
}

class PrinterModule extends StatelessWidget {
  const PrinterModule({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class ScannerModule extends StatelessWidget {
  const ScannerModule({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
