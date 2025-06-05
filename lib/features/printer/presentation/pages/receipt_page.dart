import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bluetooth_printer/flutter_bluetooth_printer.dart';
import 'package:wincare_modules/features/printer/data/models/receipt_model.dart';

import '../../../../core/theme.dart';
import '../../domain/entities/receipt_entity.dart';
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

  static const _channel = MethodChannel('com.wincare/printer');


  void setupChannelHandler() {
    _channel.setMethodCallHandler((call) async {
      print("Received method: ${call.method}");
      print("Received arguments: ${call.arguments}");
      if (call.method == 'sendSaleOrderData') {
        final jsonStr = call.arguments as String;
        final Map<String, dynamic> decoded = jsonDecode(jsonStr);
        final saleOrder = ReceiptModel.fromJson(decoded);
        print("Received order: ${saleOrder.items?.length}");
      }
    });
  }

  @override
  void initState() {
    super.initState();
    setupChannelHandler();
  }

  final receiptData = ReceiptEntity(
    saleDate: '17/01/2025 19:59',
    receiptCode: '6B100617789112648',
    counter: 'B10',
    orderCode: '6B100617789112648',
    customerName: 'Trần Thị Hợp (Cửa Hàng Tạp Hóa Hợp Thanh)',
    customerPhone: '0961891427',
    items: [
      ItemEntity(
        name:
            'OMACHI Mì DO kấy sườn ngũ quả 80g 18936221041746 OMACHI Mì DO kấy sườn ngũ quả 80g 18936221041746',
        price: '202,000',
        qty: '5',
        unit: 'T',
        total: '1,010,000',
      ),
      ItemEntity(
        name:
            'OMACHI Mì DO xốt bò hầm 80g 18936221041753 OMACHI Mì DO xốt bò hầm 80g 18936221041753 OMACHI Mì DO xốt bò hầm 80g 18936221041753',
        price: '202,000',
        qty: '6',
        unit: 'T',
        total: '1,212,000',
      ),
      ItemEntity(
        name:
            'DELIPIE Bánh pie sữa hương vani 216g 18935604744126 DELIPIE Bánh pie sữa hương vani 216g 18935604744126 DELIPIE Bánh pie sữa hương vani 216g 18935604744126',
        price: '277,200',
        qty: '1',
        unit: 'T',
        total: '277,200',
      ),
      ItemEntity(
        name: 'OMACHI Mì DO kấy sườn ngũ quả 80g\n18936221041746',
        price: '202,000',
        qty: '5',
        unit: 'T',
        total: '1,010,000',
      ),
      ItemEntity(
        name: 'OMACHI Mì DO xốt bò hầm 80g\n18936221041753',
        price: '202,000',
        qty: '6',
        unit: 'T',
        total: '1,212,000',
      ),
      ItemEntity(
        name: 'DELIPIE Bánh pie sữa hương vani 216g\n18935604744126',
        price: '277,200',
        qty: '1',
        unit: 'T',
        total: '277,200',
      ),
      ItemEntity(
        name: 'OMACHI Mì DO kấy sườn ngũ quả 80g\n18936221041746',
        price: '202,000',
        qty: '5',
        unit: 'T',
        total: '1,010,000',
      ),
      ItemEntity(
        name: 'OMACHI Mì DO kấy sườn ngũ quả 80g\n18936221041746',
        price: '202,000',
        qty: '5',
        unit: 'T',
        total: '1,010,000',
      ),
      ItemEntity(
        name: 'OMACHI Mì DO xốt bò hầm 80g\n18936221041753',
        price: '202,000',
        qty: '6',
        unit: 'T',
        total: '1,212,000',
      ),
      ItemEntity(
        name: 'DELIPIE Bánh pie sữa hương vani 216g\n18935604744126',
        price: '277,200',
        qty: '1',
        unit: 'T',
        total: '277,200',
      ),
      ItemEntity(
        name: 'OMACHI Mì DO kấy sườn ngũ quả 80g\n18936221041746',
        price: '202,000',
        qty: '5',
        unit: 'T',
        total: '1,010,000',
      ),
      ItemEntity(
        name: 'OMACHI Mì DO xốt bò hầm 80g\n18936221041753',
        price: '202,000',
        qty: '6',
        unit: 'T',
        total: '1,212,000',
      ),
      ItemEntity(
        name: 'DELIPIE Bánh pie sữa hương vani 216g\n18935604744126',
        price: '277,200',
        qty: '1',
        unit: 'T',
        total: '277,200',
      ),
      ItemEntity(
        name: 'OMACHI Mì DO kấy sườn ngũ quả 80g\n18936221041746',
        price: '202,000',
        qty: '5',
        unit: 'T',
        total: '1,010,000',
      ),
      ItemEntity(
        name: 'OMACHI Mì DO kấy sườn ngũ quả 80g\n18936221041746',
        price: '202,000',
        qty: '5',
        unit: 'T',
        total: '1,010,000',
      ),
      ItemEntity(
        name: 'OMACHI Mì DO xốt bò hầm 80g\n18936221041753',
        price: '202,000',
        qty: '6',
        unit: 'T',
        total: '1,212,000',
      ),
      ItemEntity(
        name: 'DELIPIE Bánh pie sữa hương vani 216g\n18935604744126',
        price: '277,200',
        qty: '1',
        unit: 'T',
        total: '277,200',
      ),
      ItemEntity(
        name: 'OMACHI Mì DO kấy sườn ngũ quả 80g\n18936221041746',
        price: '202,000',
        qty: '5',
        unit: 'T',
        total: '1,010,000',
      ),
      ItemEntity(
        name: 'OMACHI Mì DO xốt bò hầm 80g\n18936221041753',
        price: '202,000',
        qty: '6',
        unit: 'T',
        total: '1,212,000',
      ),
      ItemEntity(
        name: 'DELIPIE Bánh pie sữa hương vani 216g\n18935604744126',
        price: '277,200',
        qty: '1',
        unit: 'T',
        total: '277,200',
      ),
      ItemEntity(
        name: 'OMACHI Mì DO kấy sườn ngũ quả 80g\n18936221041746',
        price: '202,000',
        qty: '5',
        unit: 'T',
        total: '1,010,000',
      ),
    ],
    totalAmount: '2,499,200',
    totalProductAmount: '2,499,200',
    customerPaid: '805,500',
    voucherAmount: '805,500',
    refundAmount: '0',
    customerCardId: 'XXXXXXXXXXXX1427',
    accumulatedPoints: '0',
    deliveryMethod: 'Đơn bán hàng Mobile',
    deliveryTime: '17/01/2025 19:42',
    deliveryAddress: 'Thôn Hải Mậu, Xã Thọ Hải, Thọ Xuân',
  );

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
                        buildKeyValueRow('Ngày bán:', receiptData.saleDate),
                        buildKeyValueRow('HD:', receiptData.receiptCode),
                        buildKeyValueRow('Quầy:', receiptData.counter),
                        buildKeyValueRow('Mã GH:', receiptData.orderCode),
                        buildKeyValueRow('KH:', receiptData.customerName),

                        /// items
                        buildKeyValueRow('SĐT:', receiptData.customerPhone),
                        const CustomDivider(),
                        buildItemHeader(),
                        for (final item in receiptData.items)
                          buildItemRow(item),
                        const CustomDivider(),
                        buildTotalRow(
                          'TỔNG TIỀN PHẢI T.TOÁN',
                          receiptData.totalAmount,
                          bold: true,
                        ),
                        buildTotalRow(
                          'TỔNG TIỀN SẢN PHẨM',
                          receiptData.totalProductAmount,
                        ),
                        buildTotalRow(
                          'TIỀN KHÁCH TRẢ',
                          receiptData.customerPaid,
                        ),
                        buildKeyValueRow(
                          '  Tiền Voucher',
                          receiptData.voucherAmount,
                        ),
                        buildTotalRow('TIỀN TRẢ LẠI', receiptData.refundAmount),
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
                          receiptData.customerCardId,
                        ),
                        buildKeyValueRow(
                          'Điểm tích',
                          receiptData.accumulatedPoints,
                        ),
                        const CustomDivider(),
                        buildKeyValueRow(
                          'Hình thức GH',
                          receiptData.deliveryMethod,
                        ),
                        buildKeyValueRow('KH:', receiptData.customerName),
                        buildKeyValueRow('Giờ GH:', receiptData.deliveryTime),
                        buildKeyValueRow(
                          'Địa chỉ GH:',
                          receiptData.deliveryAddress,
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

  Widget buildItemRow(ItemEntity item) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 2),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(item.name, style: const TextStyle(fontSize: ReceiptSize.standard)),
        Row(
          children: [
            const SizedBox(width: 0),
            Expanded(flex: 6, child: SizedBox()),
            Expanded(
              flex: 2,
              child: Text(
                item.price,
                textAlign: TextAlign.right,
                style: const TextStyle(fontSize: ReceiptSize.standard),
              ),
            ),
            Expanded(
              flex: 1,
              child: Text(
                item.qty,
                textAlign: TextAlign.right,
                style: const TextStyle(fontSize: ReceiptSize.standard),
              ),
            ),
            Expanded(
              flex: 1,
              child: Text(
                item.unit,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: ReceiptSize.standard),
              ),
            ),
            Expanded(
              flex: 2,
              child: Text(
                item.total,
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
