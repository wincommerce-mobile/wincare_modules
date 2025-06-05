import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'features/printer/presentation/pages/receipt_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
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
      home: const ReceiptPage(),
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
