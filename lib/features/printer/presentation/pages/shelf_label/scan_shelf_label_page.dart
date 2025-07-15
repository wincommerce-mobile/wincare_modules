import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import '../../../../../app/app_colors.dart';
import '../../../../../app/app_pages.dart';

class ScanShelfLabelPage extends StatefulWidget {
  const ScanShelfLabelPage({super.key});

  @override
  State<ScanShelfLabelPage> createState() => _ScanShelfLabelPageState();
}

class _ScanShelfLabelPageState extends State<ScanShelfLabelPage>
    with WidgetsBindingObserver {
  final MobileScannerController controller = MobileScannerController();
  String? _selectedBarcode;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (!controller.value.hasCameraPermission) {
      return;
    }

    switch (state) {
      case AppLifecycleState.detached:
        debugPrint('AppLifecycleState.detached');
      case AppLifecycleState.hidden:
        debugPrint('AppLifecycleState.hidden');
      case AppLifecycleState.paused:
        debugPrint('AppLifecycleState.paused');
        return;
      case AppLifecycleState.resumed:
        debugPrint('AppLifecycleState.resumed');
        unawaited(controller.start());
      case AppLifecycleState.inactive:
        debugPrint('AppLifecycleState.inactive');
        unawaited(controller.stop());
    }
  }

  @override
  void dispose() async {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
    await controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFC6142C),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () {
            Get.back();
          },
        ),
        title: const Text(
          'IN TEM KỆ',
          style: TextStyle(
            fontFamily: 'Roboto',
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 22,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Stack(
              alignment: Alignment.center,
              children: [
                MobileScanner(
                  controller: controller,
                  onDetect: (capture) async {
                    final barcode = capture.barcodes.first;
                    final String? code = barcode.rawValue;

                    if (code != null) {
                      List<String> barcodeList = List<String>.from(
                        jsonDecode(code),
                      );
                      controller.stop();
                      await _showBarCodeDialog(context, barcodeList);
                      controller.start();
                    }
                  },
                ),
                // Overlay border
                CustomPaint(
                  painter: ScannerOverlayPainter(),
                  size: const Size.square(250),
                ),
                // Torch & Manual Input
                Positioned(
                  top: 20,
                  left: 20,
                  child: IconButton(
                    icon: const Icon(Icons.flash_off, color: Colors.white),
                    onPressed: () => controller.toggleTorch(),
                  ),
                ),
                Positioned(
                  top: 20,
                  child: GestureDetector(
                    onTap: () async {
                      final manualCode = await _showManualInputDialog(context);
                      if (manualCode != null && manualCode.isNotEmpty) {
                        try {
                          List<String> barcodeList = List<String>.from(
                            jsonDecode(manualCode),
                          );
                          await _showBarCodeDialog(context, barcodeList);
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Mã không hợp lệ')),
                          );
                        }
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.8),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Text(
                        'Nhập mã bằng tay',
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<String?> _showManualInputDialog(BuildContext context) async {
    String input = '';

    return showDialog<String>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                child: Row(
                  children: [
                    Visibility(
                      visible: false,
                      child: IconButton(
                        icon: const Icon(Icons.close, color: Colors.red),
                        onPressed: null,
                      ),
                    ),
                    Expanded(
                      child: const Text(
                        'Nhập mã / tên sản phẩm',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Roboto',
                          color: Color(0xff333333),
                        ),
                      ),
                    ),
                    GestureDetector(
                      child: const Icon(Icons.close, color: Color(0xff666666)),
                      onTap: () => Navigator.of(context).pop(),
                    ),
                  ],
                ),
              ),
              Divider(thickness: 1, color: AppColors.black,)
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                onChanged: (value) => input = value,
                decoration: const InputDecoration(hintText: ''),
                maxLines: null,
              ),
              const SizedBox(height: 6),
              Text(
                'Nhập mã/tên được in trên bao bì sản phẩm',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Roboto',
                  color: Color(0xFFA3A3A3),
                ),
              )
            ],
          ),
          titlePadding: EdgeInsets.zero,
          actionsAlignment: MainAxisAlignment.center,
          actions: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 24),
              height: 44,
              child: ElevatedButton(
                onPressed: () => Navigator.of(context).pop(input),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.white,
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(color: AppColors.red),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                child: const Text(
                  'Xác nhận',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Roboto',
                    color: Colors.red,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Future<void> _showBarCodeDialog(
    BuildContext context,
    List<String> barcodeList,
  ) async {
    await showDialog(
      context: context,
      builder: (context) {
        int selectedIndex = -1;
        return StatefulBuilder(
          builder: (context, setState) {
            return Dialog(
              backgroundColor: AppColors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Top Bar
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: const BoxDecoration(
                      color: AppColors.red,
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(16),
                      ),
                    ),
                    height: 50,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Visibility(
                          visible: false,
                          child: GestureDetector(
                            onTap: null,
                            child: const Icon(
                              Icons.close,
                              color: AppColors.white,
                            ),
                          ),
                        ),
                        Expanded(
                          child: const Text(
                            "Chọn Barcode sản phẩm",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: 'Roboto',
                              color: AppColors.white,
                              fontWeight: FontWeight.w400,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: const Icon(
                            Icons.close,
                            color: AppColors.white,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  Container(
                    height: Get.height / 3,
                    padding: EdgeInsets.symmetric(horizontal: 24),
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: barcodeList.length,
                      itemBuilder: (context, index) {
                        final barcode = barcodeList[index];
                        final isSelected = index == selectedIndex;
                        return GestureDetector(
                          onTap: () {
                            if (selectedIndex == index) {
                              return;
                            }
                            selectedIndex = index;
                            _selectedBarcode = barcode;
                            setState(() {});
                          },
                          child: Column(
                            key: ValueKey(index),
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      barcode,
                                      style: TextStyle(
                                        fontFamily: 'Roboto',
                                        color: AppColors.black,
                                        fontWeight: isSelected
                                            ? FontWeight.bold
                                            : FontWeight.w400,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                  Image.asset(
                                    selectedIndex == index
                                        ? 'assets/images/radio_selected.png'
                                        : 'assets/images/radio.png',
                                    width: 24,
                                    height: 24,
                                    fit: BoxFit.cover,
                                  ),
                                ],
                              ),
                              Divider(
                                height: 20,
                                thickness: 1,
                                color: AppColors.black,
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),

                  const SizedBox(height: 8),
                  // Select Button
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 12,
                    ),
                    child: SizedBox(
                      width: double.infinity,
                      height: 45,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: _selectedBarcode != null
                              ? AppColors.red
                              : Colors.grey,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: _selectedBarcode != null
                            ? () {
                                Get.back();
                                Get.offAndToNamed(
                                  AppRoutes.printLabel,
                                  arguments: _selectedBarcode,
                                );
                              }
                            : null,
                        child: const Text(
                          "Chọn",
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            color: AppColors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    ).then((v) {});
  }
}

class ScannerOverlayPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..strokeWidth = 4
      ..style = PaintingStyle.stroke;

    const cornerLength = 30.0;

    // Top-left
    canvas.drawLine(Offset(0, 0), Offset(cornerLength, 0), paint);
    canvas.drawLine(Offset(0, 0), Offset(0, cornerLength), paint);

    // Top-right
    canvas.drawLine(
      Offset(size.width, 0),
      Offset(size.width - cornerLength, 0),
      paint,
    );
    canvas.drawLine(
      Offset(size.width, 0),
      Offset(size.width, cornerLength),
      paint,
    );

    // Bottom-left
    canvas.drawLine(
      Offset(0, size.height),
      Offset(0, size.height - cornerLength),
      paint,
    );
    canvas.drawLine(
      Offset(0, size.height),
      Offset(cornerLength, size.height),
      paint,
    );

    // Bottom-right
    canvas.drawLine(
      Offset(size.width, size.height),
      Offset(size.width - cornerLength, size.height),
      paint,
    );
    canvas.drawLine(
      Offset(size.width, size.height),
      Offset(size.width, size.height - cornerLength),
      paint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
