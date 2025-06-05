import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bluetooth_printer/flutter_bluetooth_printer.dart';

import '../../../../core/theme.dart';
import '../../data/models/sale_order_header.dart';
import '../widgets/custom_divider.dart';
import '../widgets/printing_progress_dialog.dart';

class ReceiptPage extends StatefulWidget {
  const ReceiptPage({super.key});

  @override
  State<ReceiptPage> createState() => _ReceiptPageState();
}

class _ReceiptPageState extends State<ReceiptPage> {
  ReceiptController? controller;
  String? address;
  late SaleOrderHeader receiptData;

  static const _channel = MethodChannel('com.wincare/printer');

  void setupChannelHandler() {
    _channel.setMethodCallHandler((call) async {
      print("Received method: ${call.method}");
      print("Received arguments: ${call.arguments}");
      if (call.method == 'sendSaleOrderData') {
        final jsonStr = call.arguments as String;
        final Map<String, dynamic> decoded = jsonDecode(jsonStr);
        final saleOrder = SaleOrderHeader.fromJson(decoded);
        setState(() {
          receiptData = saleOrder;
        });
        print("Received order: ${saleOrder.items?.length}");
      }
    });
  }

  @override
  void initState() {
    super.initState();
    setupChannelHandler();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () async {
              final selected = await FlutterBluetoothPrinter.selectDevice(
                context,
              );
              if (selected != null) {
                setState(() {
                  address = selected.address;
                });
              }
            },
            icon: const Icon(Icons.settings),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Receipt(
              backgroundColor: Colors.grey.shade200,
              builder: (context) {
                return Align(
                  alignment: Alignment.topCenter,
                  child: SizedBox(
                    width: 576, // Printable width for 8mmm paper
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        /// header
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Expanded(
                              flex: 1,
                              child: Image.asset(
                                'assets/win-logo.png',
                                height: 35,
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: const Text(
                                'HUB WIN+ THA Phần Thôn, Thọ Xuân Thôn Phần Thôn, Xã Thọ Hải, Huyện Thọ Xuân',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: ReceiptSize.standard,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 22),
                        const Center(
                          child: Column(
                            children: [
                              Text(
                                'HÓA ĐƠN IN LẠI',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 12),
                              Text(
                                '(In lần 1)',
                                style: TextStyle(fontSize: ReceiptSize.small),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 12),
                        buildKeyValueRow('Ngày bán:', ""),
                        buildKeyValueRow('HD:', ""),
                        buildKeyValueRow('Quầy:', ""),
                        buildKeyValueRow('Mã GH:', ""),
                        buildKeyValueRow('KH:', ""),

                        /// items
                        buildKeyValueRow('SĐT:', ""),
                        const CustomDivider(),
                        buildItemHeader(),
                        if(receiptData.items!= null && receiptData.items!.isEmpty)
                          const Center(
                            child: Text(
                              'Không có mặt hàng nào',
                              style: TextStyle(fontSize: ReceiptSize.standard),
                            ),
                          ),
                        for (final item in receiptData.items!)
                          buildItemRow(item),
                        const CustomDivider(),
                        buildTotalRow(
                          'TỔNG TIỀN PHẢI T.TOÁN',
                          "00000",
                          bold: true,
                        ),
                        buildTotalRow(
                          'TỔNG TIỀN SẢN PHẨM',
                          "00000",
                        ),
                        buildTotalRow(
                          'TIỀN KHÁCH TRẢ',
                          "",
                        ),
                        buildKeyValueRow(
                          '  Tiền Voucher',
                          "",
                        ),
                        buildTotalRow('TIỀN TRẢ LẠI', ""),
                        const SizedBox(height: 8),
                        const Center(
                          child: Text(
                            '(Giá đã bao gồm thuế GTGT)',
                            style: TextStyle(fontSize: ReceiptSize.small),
                          ),
                        ),
                        const CustomDivider(),
                        buildKeyValueRow(
                          'ID thẻ khách hàng',
                          "",
                        ),
                        buildKeyValueRow(
                          'Điểm tích',
                          "",
                        ),
                        const CustomDivider(),
                        buildKeyValueRow(
                          'Hình thức GH',
                          "",
                        ),
                        buildKeyValueRow('KH:', receiptData.customerName ?? ''),
                        buildKeyValueRow('Giờ GH:', ""),
                        buildKeyValueRow(
                          'Địa chỉ GH:',
                          receiptData.fullAddress ?? '',
                        ),
                        const SizedBox(height: 12),
                        const Center(
                          child: Column(
                            children: [
                              Text(
                                'Chỉ xuất hoá đơn trong ngày',
                                style: TextStyle(
                                  fontSize: ReceiptSize.standard,
                                ),
                              ),
                              SizedBox(height: 12),
                              Text(
                                'Tax invoice will be issued within same day',
                                style: TextStyle(
                                  fontSize: ReceiptSize.standard,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 4),
                        const CustomDivider(),
                        const SizedBox(height: 4),

                        /// footer
                        const Center(
                          child: Column(
                            children: [
                              Text(
                                'CẢM ƠN QUÝ KHÁCH VÀ HẸN GẶP LẠI',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: ReceiptSize.standard,
                                ),
                              ),
                              SizedBox(height: 16),
                              Text(
                                'Hotline: 02471066856   Website: www.winmart.vn',
                                style: TextStyle(fontSize: ReceiptSize.small),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
              onInitialized: (controller) {
                controller.paperSize = PaperSize.mm80;
                setState(() {
                  this.controller = controller;
                });
              },
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () async {
                        final selectedAddress =
                            address ??
                            (await FlutterBluetoothPrinter.selectDevice(
                              context,
                            ))?.address;
                        if (context.mounted && selectedAddress != null) {
                          PrintingProgressDialog.print(
                            context,
                            device: selectedAddress,
                            controller: controller!,
                          );
                        }
                      },
                      child: const Text('PRINT'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildKeyValueRow(String key, String value) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 2),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 4,
          child: Text(
            key,
            style: const TextStyle(fontSize: ReceiptSize.standard),
          ),
        ),
        Expanded(
          flex: 6,
          child: Text(
            value,
            style: const TextStyle(fontSize: ReceiptSize.standard),
          ),
        ),
      ],
    ),
  );

  Widget buildItemHeader() => Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: Row(
      children: const [
        Expanded(
          flex: 6,
          child: Text(
            'Mặt hàng',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: ReceiptSize.standard,
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Text(
            'Đơn giá',
            textAlign: TextAlign.right,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: ReceiptSize.standard,
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Text(
            'SL',
            textAlign: TextAlign.right,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: ReceiptSize.standard,
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Text(
            'ĐVT',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: ReceiptSize.standard,
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Text(
            'T.Tiền',
            textAlign: TextAlign.right,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: ReceiptSize.standard,
            ),
          ),
        ),
      ],
    ),
  );

  Widget buildItemRow(SaleOrderItem item) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 2),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          item.description ?? '',
          style: const TextStyle(fontSize: ReceiptSize.standard),
        ),
        Row(
          children: [
            const SizedBox(width: 0),
            Expanded(flex: 6, child: SizedBox()),
            Expanded(
              flex: 2,
              child: Text(
                item.netPrice != null ? item.netPrice.toString() : '0',
                textAlign: TextAlign.right,
                style: const TextStyle(fontSize: ReceiptSize.standard),
              ),
            ),
            Expanded(
              flex: 1,
              child: Text(
                item.quantity != null ? item.quantity.toString() : '0',
                textAlign: TextAlign.right,
                style: const TextStyle(fontSize: ReceiptSize.standard),
              ),
            ),
            Expanded(
              flex: 1,
              child: Text(
                item.unitPrice != null ? item.unitPrice.toString() : 'T',
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: ReceiptSize.standard),
              ),
            ),
            Expanded(
              flex: 2,
              child: Text(
                item.totalAmount != null ? item.totalAmount.toString() : '0',
                textAlign: TextAlign.right,
                style: const TextStyle(fontSize: ReceiptSize.standard),
              ),
            ),
          ],
        ),
      ],
    ),
  );

  Widget buildTotalRow(String label, String amount, {bool bold = false}) =>
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 2),
        child: Row(
          children: [
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  fontSize: ReceiptSize.standard,
                  fontWeight: bold ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ),
            Text(
              amount,
              style: TextStyle(
                fontSize: ReceiptSize.standard,
                fontWeight: bold ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      );
}
