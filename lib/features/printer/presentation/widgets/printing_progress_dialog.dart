import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_printer/flutter_bluetooth_printer_library.dart';
import 'package:get/get.dart';

class PrintingProgressDialog extends StatefulWidget {
  final String device;
  final ReceiptController controller;

  const PrintingProgressDialog({
    super.key,
    required this.device,
    required this.controller,
  });

  @override
  State<PrintingProgressDialog> createState() => _PrintingProgressDialogState();

  static void print(
    BuildContext context, {
    required String device,
    required ReceiptController controller,
  }) async {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) =>
          PrintingProgressDialog(controller: controller, device: device),
    );
  }
}

class _PrintingProgressDialogState extends State<PrintingProgressDialog> {
  double? progress;

  @override
  void initState() {
    super.initState();
    widget.controller.print(
      address: widget.device,
      addFeeds: 5,
      keepConnected: true,
      onProgress: (total, sent) {
        if (mounted) {
          setState(() {
            progress = sent / total;
          });
          Future.delayed(const Duration(milliseconds: 500), () {
            if (mounted) {
              if (((progress ?? 0) * 100).round() == 100) {
                Get.back();
              }
            }
          });
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'In hoá đơn',
              style: TextStyle(
                fontFamily: 'Roboto',
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            LinearProgressIndicator(
              value: progress,
              backgroundColor: Colors.grey.shade200,
            ),
            const SizedBox(height: 4),
            Text('Đang xử lý: ${((progress ?? 0) * 100).round()}%'),
            // if (((progress ?? 0) * 100).round() == 100) ...[
            //   const SizedBox(height: 16),
            //   ElevatedButton(
            //     onPressed: () async {
            //       //await FlutterBluetoothPrinter.disconnect(widget.device);
            //       if (!context.mounted) return;
            //       Navigator.pop(context);
            //     },
            //     child: const Text('Đóng', style: TextStyle(fontFamily: 'Roboto'),),
            //   ),
            // ],
          ],
        ),
      ),
    );
  }
}
