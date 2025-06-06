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
    // _channel.setMethodCallHandler((call) async {
    //   print("Received method: ${call.method}");
    //   print("Received arguments: ${call.arguments}");
    //   if (call.method == 'sendSaleOrderData') {
    //     final jsonStr = call.arguments as String;
    //     print("Received saleOrder: $jsonStr");
    //     final Map<String, dynamic> decoded = jsonDecode(jsonStr);
    //     final saleOrder = SaleOrderHeader.fromJson(decoded);
    //     setState(() {
    //       receiptData = saleOrder;
    //     });
    //   }
    // });
    final jsonStr =
        """{"BillCode":"6B01smthuyhub635","BillDate":"2025-06-04T00:00:00","CustomerName":"Nguyễn Thị Dịu","CustomerPhone":"031223456","DeliveryDate":"2025-06-07T00:00:00","FullAddress":"123a","IsAllowCancel":false,"IsAllowConfirm":false,"Items":[{"Barcode":"8934680089739","Description":"LU bánh quy bơ pháp 540g","DocumentNo":"635","ItemNo":"10324065","LineNo":"1","MarketPrice":0.0,"NetPrice":810000.0,"Quantity":1.0,"QuantityConfirm":0.0,"TotalAmount":810000.0,"UnitOfMeasure":"T","UnitPrice":810000.0,"UrlImage":"https://hcm.fstorage.vn/winplus/prod/2024/12/24/aae58cb3-6cd0-4cf6-91e8-43f77f1744d5.jpg","VatGroup":0,"VatRate":0},{"Barcode":"8934680114967","Description":"LU bánh quy bơ pháp 540g","DocumentNo":"635","ItemNo":"10324065","LineNo":"2","MarketPrice":0.0,"NetPrice":135000.0,"Quantity":2.0,"QuantityConfirm":0.0,"TotalAmount":270000.0,"UnitOfMeasure":"HOP","UnitPrice":135000.0,"UrlImage":"https://hcm.fstorage.vn/winplus/prod/2024/12/24/aae58cb3-6cd0-4cf6-91e8-43f77f1744d5.jpg","VatGroup":0,"VatRate":0}],"MemberLevel":1,"MemberLevelName":"Hội viên","PosCode":"sm.thuy.hub","PosName":"sm Thuy HUB","SaleType":1,"StatusId":20,"StatusName":"Đã duyệt","StoreId":"6B01","StoreName":"HUB WIN+ THA 66B Phố Thiều","TotalPrice":1080000.0,"UserId":0,"check":false}""";
    final Map<String, dynamic> decoded = jsonDecode(jsonStr);
    final saleOrder = SaleOrderHeader.fromJson(decoded);
    setState(() {
      receiptData = saleOrder;
    });
  }

  @override
  void initState() {
    super.initState();
    print("initState");
    setupChannelHandler();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print("didChangeDependencies");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: const Text(
          'IN HÓA ĐƠN',
          style: TextStyle(color: Colors.white, fontSize: 15),
        ),
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
            icon: const Icon(Icons.settings, color: Colors.white),
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
                        buildKeyValueRow(
                          'Ngày bán:',
                          receiptData.billDate?.toString() ?? '',
                        ),
                        buildKeyValueRow('HD:', receiptData.billCode ?? ''),
                        buildKeyValueRow('Quầy:', receiptData.storeName ?? ''),
                        buildKeyValueRow('Mã GH:', "635"),
                        buildKeyValueRow('KH:', receiptData.customerName ?? ''),

                        /// items
                        buildKeyValueRow(
                          'SĐT:',
                          receiptData.customerPhone ?? '',
                        ),
                        const CustomDivider(),
                        buildItemHeader(),
                        if (receiptData.items != null &&
                            receiptData.items!.isEmpty)
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
                        buildTotalRow('TỔNG TIỀN SẢN PHẨM', "00000"),
                        buildTotalRow('TIỀN KHÁCH TRẢ', ""),
                        buildKeyValueRow('  Tiền Voucher', ""),
                        buildTotalRow('TIỀN TRẢ LẠI', ""),
                        const SizedBox(height: 8),
                        const Center(
                          child: Text(
                            '(Giá đã bao gồm thuế GTGT)',
                            style: TextStyle(fontSize: ReceiptSize.small),
                          ),
                        ),
                        const CustomDivider(),
                        buildKeyValueRow('ID thẻ khách hàng', ""),
                        buildKeyValueRow(
                          'Điểm tích',
                          receiptData.memberLevel?.toString() ?? '',
                        ),
                        const CustomDivider(),
                        buildKeyValueRow('Hình thức GH', ""),
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
                      child: const Text(
                        'IN HÓA ĐƠN',
                        style: TextStyle(color: Colors.black, fontSize: 12),
                      ),
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
          flex: 4,
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
          flex: 3,
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
        const SizedBox(height: 2),
        Row(
          children: [
            const SizedBox(width: 0),
            Expanded(flex: 4, child: SizedBox()),
            Expanded(
              flex: 2,
              child: Text(
                item.netPrice != null ? item.netPrice.toString() : '0',
                textAlign: TextAlign.right,
                style: const TextStyle(fontSize: ReceiptSize.medium),
              ),
            ),
            Expanded(
              flex: 1,
              child: Text(
                item.quantity != null ? item.quantity.toString() : '0',
                textAlign: TextAlign.right,
                style: const TextStyle(fontSize: ReceiptSize.medium),
              ),
            ),
            Expanded(
              flex: 1,
              child: Text(
                item.unitOfMeasure != null
                    ? item.unitOfMeasure.toString()
                    : 'T',
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: ReceiptSize.medium),
              ),
            ),
            Expanded(
              flex: 3,
              child: Text(
                item.totalAmount != null ? item.totalAmount.toString() : '0',
                textAlign: TextAlign.right,
                style: const TextStyle(fontSize: ReceiptSize.medium),
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
