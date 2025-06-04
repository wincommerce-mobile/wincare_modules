// Refracted ReceiptPage with dynamic item list, correct layout and full-width alignment.

import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_printer/flutter_bluetooth_printer.dart';

import '../../../../core/theme.dart';

class Item {
  final String name;
  final String price;
  final String qty;
  final String unit;
  final String total;

  Item({
    required this.name,
    required this.price,
    required this.qty,
    required this.unit,
    required this.total,
  });
}

class ReceiptData {
  final String saleDate;
  final String receiptCode;
  final String counter;
  final String orderCode;
  final String customerName;
  final String customerPhone;
  final List<Item> items;
  final String totalAmount;
  final String totalProductAmount;
  final String customerPaid;
  final String voucherAmount;
  final String refundAmount;
  final String customerCardId;
  final String accumulatedPoints;
  final String deliveryMethod;
  final String deliveryTime;
  final String deliveryAddress;

  ReceiptData({
    required this.saleDate,
    required this.receiptCode,
    required this.counter,
    required this.orderCode,
    required this.customerName,
    required this.customerPhone,
    required this.items,
    required this.totalAmount,
    required this.totalProductAmount,
    required this.customerPaid,
    required this.voucherAmount,
    required this.refundAmount,
    required this.customerCardId,
    required this.accumulatedPoints,
    required this.deliveryMethod,
    required this.deliveryTime,
    required this.deliveryAddress,
  });
}


class ReceiptPage extends StatefulWidget {
  const ReceiptPage({super.key});

  @override
  State<ReceiptPage> createState() => _ReceiptPageState();
}

class _ReceiptPageState extends State<ReceiptPage> {
  ReceiptController? controller;
  String? address;

  final ReceiptData receiptData = ReceiptData(
    saleDate: '17/01/2025 19:59',
    receiptCode: '6B100617789112648',
    counter: 'B10',
    orderCode: '6B100617789112648',
    customerName: 'Trần Thị Hợp (Cửa Hàng Tạp Hóa Hợp Thanh)',
    customerPhone: '0961891427',
    items: [
      Item(
        name: 'OMACHI Mì DO kấy sườn ngũ quả 80g\n18936221041746',
        price: '202,000',
        qty: '5',
        unit: 'T',
        total: '1,010,000',
      ),
      Item(
        name: 'OMACHI Mì DO xốt bò hầm 80g\n18936221041753',
        price: '202,000',
        qty: '6',
        unit: 'T',
        total: '1,212,000',
      ),
      Item(
        name: 'DELIPIE Bánh pie sữa hương vani 216g\n18935604744126',
        price: '277,200',
        qty: '1',
        unit: 'T',
        total: '277,200',
      ),
      Item(
        name: 'OMACHI Mì DO kấy sườn ngũ quả 80g\n18936221041746',
        price: '202,000',
        qty: '5',
        unit: 'T',
        total: '1,010,000',
      ),
      Item(
        name: 'OMACHI Mì DO xốt bò hầm 80g\n18936221041753',
        price: '202,000',
        qty: '6',
        unit: 'T',
        total: '1,212,000',
      ),
      Item(
        name: 'DELIPIE Bánh pie sữa hương vani 216g\n18935604744126',
        price: '277,200',
        qty: '1',
        unit: 'T',
        total: '277,200',
      ),
      Item(
        name: 'OMACHI Mì DO kấy sườn ngũ quả 80g\n18936221041746',
        price: '202,000',
        qty: '5',
        unit: 'T',
        total: '1,010,000',
      ),
      Item(
        name: 'OMACHI Mì DO xốt bò hầm 80g\n18936221041753',
        price: '202,000',
        qty: '6',
        unit: 'T',
        total: '1,212,000',
      ),
      Item(
        name: 'DELIPIE Bánh pie sữa hương vani 216g\n18935604744126',
        price: '277,200',
        qty: '1',
        unit: 'T',
        total: '277,200',
      ),
      Item(
        name: 'OMACHI Mì DO kấy sườn ngũ quả 80g\n18936221041746',
        price: '202,000',
        qty: '5',
        unit: 'T',
        total: '1,010,000',
      ),
      Item(
        name: 'OMACHI Mì DO xốt bò hầm 80g\n18936221041753',
        price: '202,000',
        qty: '6',
        unit: 'T',
        total: '1,212,000',
      ),
      Item(
        name: 'DELIPIE Bánh pie sữa hương vani 216g\n18935604744126',
        price: '277,200',
        qty: '1',
        unit: 'T',
        total: '277,200',
      ),
      Item(
        name: 'OMACHI Mì DO kấy sườn ngũ quả 80g\n18936221041746',
        price: '202,000',
        qty: '5',
        unit: 'T',
        total: '1,010,000',
      ),
      Item(
        name: 'OMACHI Mì DO xốt bò hầm 80g\n18936221041753',
        price: '202,000',
        qty: '6',
        unit: 'T',
        total: '1,212,000',
      ),
      Item(
        name: 'DELIPIE Bánh pie sữa hương vani 216g\n18935604744126',
        price: '277,200',
        qty: '1',
        unit: 'T',
        total: '277,200',
      ),
      Item(
        name: 'OMACHI Mì DO kấy sườn ngũ quả 80g\n18936221041746',
        price: '202,000',
        qty: '5',
        unit: 'T',
        total: '1,010,000',
      ),
      Item(
        name: 'OMACHI Mì DO xốt bò hầm 80g\n18936221041753',
        price: '202,000',
        qty: '6',
        unit: 'T',
        total: '1,212,000',
      ),
      Item(
        name: 'DELIPIE Bánh pie sữa hương vani 216g\n18935604744126',
        price: '277,200',
        qty: '1',
        unit: 'T',
        total: '277,200',
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
                        // TODO - update
                        Center(
                          child: Row(
                            children: [
                              Image.asset('assets/win-logo.png', height: 35),
                              const SizedBox(height: 8),
                              const Text(
                                'HUB WIN+ THA Phần\nThôn, Thọ Xuân\nThôn Phần Thôn, Xã Thọ Hải, Huyện Thọ Xuân',
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: ReceiptSize.standard),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 4),
                        const Center(
                          child: Column(
                            children: [
                              Text(
                                'HÓA ĐƠN IN LẠI',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text(
                                '(In lần 1)',
                                style: TextStyle(fontSize: ReceiptSize.small),
                              ),
                            ],
                          ),
                        ),
                        const Divider(),
                        buildKeyValueRow('Ngày bán:', receiptData.saleDate),
                        buildKeyValueRow('HD:', receiptData.receiptCode),
                        buildKeyValueRow('Quầy:', receiptData.counter),
                        buildKeyValueRow('Mã GH:', receiptData.orderCode),
                        buildKeyValueRow(
                          'KH:',
                          receiptData.customerName,
                        ),
                        /// items
                        buildKeyValueRow('SĐT:', receiptData.customerPhone),
                        const Divider(),
                        buildItemHeader(),
                        for (final item in receiptData.items) buildItemRow(item),
                        const Divider(),
                        buildTotalRow(
                          'TỔNG TIỀN PHẢI T.TOÁN',
                          receiptData.totalAmount,
                          bold: true,
                        ),
                        buildTotalRow('TỔNG TIỀN SẢN PHẨM', receiptData.totalProductAmount),
                        buildTotalRow('TIỀN KHÁCH TRẢ', receiptData.customerPaid),
                        buildKeyValueRow('  Tiền Voucher', receiptData.voucherAmount),
                        buildTotalRow('TIỀN TRẢ LẠI', receiptData.refundAmount),
                        const SizedBox(height: 8),
                        const Center(
                          child: Text(
                            '(Giá đã bao gồm thuế GTGT)',
                            style: TextStyle(fontSize: ReceiptSize.small),
                          ),
                        ),
                        const Divider(),
                        buildKeyValueRow(
                          'ID thẻ khách hàng',
                          receiptData.customerCardId,
                        ),
                        buildKeyValueRow('Điểm tích', receiptData.accumulatedPoints),
                        const Divider(),
                        buildKeyValueRow('Hình thức GH', receiptData.deliveryMethod),
                        buildKeyValueRow(
                          'KH:',
                          receiptData.customerName,
                        ),
                        buildKeyValueRow('Giờ GH:', receiptData.deliveryTime),
                        buildKeyValueRow(
                          'Địa chỉ GH:',
                          receiptData.deliveryAddress,
                        ),
                        const SizedBox(height: 4),
                        const Center(
                          child: Column(
                            children: [
                              Text(
                                'Chỉ xuất hoá đơn trong ngày',
                                style: TextStyle(fontSize: ReceiptSize.standard),
                              ),
                              Text(
                                'Tax invoice will be issued within same day',
                                style: TextStyle(fontSize: ReceiptSize.standard),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 4),
                        const Divider(),
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
          child: Text(key, style: const TextStyle(fontSize: ReceiptSize.standard)),
        ),
        Expanded(
          flex: 6,
          child: Text(value, style: const TextStyle(fontSize: ReceiptSize.standard)),
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
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: ReceiptSize.standard),
          ),
        ),
        Expanded(
          flex: 2,
          child: Text(
            'Đơn giá',
            textAlign: TextAlign.right,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: ReceiptSize.standard),
          ),
        ),
        Expanded(
          flex: 1,
          child: Text(
            'SL',
            textAlign: TextAlign.right,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: ReceiptSize.standard),
          ),
        ),
        Expanded(
          flex: 1,
          child: Text(
            'ĐVT',
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: ReceiptSize.standard),
          ),
        ),
        Expanded(
          flex: 2,
          child: Text(
            'T.Tiền',
            textAlign: TextAlign.right,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: ReceiptSize.standard),
          ),
        ),
      ],
    ),
  );

  Widget buildItemRow(Item item) => Padding(
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
      barrierDismissible: false,
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
              'Printing Receipt',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            LinearProgressIndicator(
              value: progress,
              backgroundColor: Colors.grey.shade200,
            ),
            const SizedBox(height: 4),
            Text('Processing: ${((progress ?? 0) * 100).round()}%'),
            if (((progress ?? 0) * 100).round() == 100) ...[
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () async {
                  await FlutterBluetoothPrinter.disconnect(widget.device);

                  if (!context.mounted) return;
                  Navigator.pop(context);
                },
                child: const Text('Disconnect'),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
