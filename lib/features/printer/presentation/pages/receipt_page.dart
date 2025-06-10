import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bluetooth_printer/flutter_bluetooth_printer.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  Printer? printer;
  late SaleOrderHeader receiptData;

  static const _channel = MethodChannel('com.wincare/printer');

  void setupChannelHandler() {
    _channel.setMethodCallHandler((call) async {
      print("Received method: ${call.method}");
      print("Received arguments: ${call.arguments}");
      if (call.method == 'sendSaleOrderData') {
        final jsonStr = call.arguments as String;
        print("Received saleOrder: $jsonStr");
        final Map<String, dynamic> decoded = jsonDecode(jsonStr);
        final saleOrder = SaleOrderHeader.fromJson(decoded);
        setState(() {
          receiptData = saleOrder;
        });
      }
    });
    // final jsonStr = """
    //         {
    //   "BillCode": "6B01smthuyhub635",
    //   "BillDate": "2025-06-04T00:00:00",
    //   "CustomerName": "Nguyễn Thị Dịu",
    //   "CustomerPhone": "031223456",
    //   "DeliveryDate": "2025-06-07T00:00:00",
    //   "FullAddress": "123a",
    //   "IsAllowCancel": false,
    //   "IsAllowConfirm": false,
    //   "Items": [
    //     {
    //       "Barcode": "8934680089739",
    //       "Description": "DYMAMYTE Bánh quy bơ pháp 540g SCL BigBag 120g",
    //       "DocumentNo": "635",
    //       "ItemNo": "10324065",
    //       "LineNo": "1",
    //       "MarketPrice": 0,
    //       "NetPrice": 810000,
    //       "Quantity": 1,
    //       "QuantityConfirm": 0,
    //       "TotalAmount": 810000,
    //       "UnitOfMeasure": "T",
    //       "UnitPrice": 810000,
    //       "UrlImage": "https://hcm.fstorage.vn/winplus/prod/2024/12/24/aae58cb3-6cd0-4cf6-91e8-43f77f1744d5.jpg",
    //       "VatGroup": 0,
    //       "VatRate": 0
    //     },
    //     {
    //       "Barcode": "8934680114967",
    //       "Description": "DYMAMYTE Bánh quy bơ pháp 540g SCL BigBag 120g",
    //       "DocumentNo": "635",
    //       "ItemNo": "10324065",
    //       "LineNo": "2",
    //       "MarketPrice": 0,
    //       "NetPrice": 135000,
    //       "Quantity": 2,
    //       "QuantityConfirm": 0,
    //       "TotalAmount": 270000,
    //       "UnitOfMeasure": "HOP",
    //       "UnitPrice": 135000,
    //       "UrlImage": "https://hcm.fstorage.vn/winplus/prod/2024/12/24/aae58cb3-6cd0-4cf6-91e8-43f77f1744d5.jpg",
    //       "VatGroup": 0,
    //       "VatRate": 0
    //     },
    // {
    //       "Barcode": "8934680114967",
    //       "Description": "DYMAMYTE Bánh quy bơ pháp 540g SCL BigBag 120g",
    //       "DocumentNo": "635",
    //       "ItemNo": "10324065",
    //       "LineNo": "2",
    //       "MarketPrice": 0,
    //       "NetPrice": 135000,
    //       "Quantity": 2,
    //       "QuantityConfirm": 0,
    //       "TotalAmount": 270000,
    //       "UnitOfMeasure": "HOP",
    //       "UnitPrice": 135000,
    //       "UrlImage": "https://hcm.fstorage.vn/winplus/prod/2024/12/24/aae58cb3-6cd0-4cf6-91e8-43f77f1744d5.jpg",
    //       "VatGroup": 0,
    //       "VatRate": 0
    //     },
    // {
    //       "Barcode": "8934680114967",
    //       "Description": "DYMAMYTE Bánh quy bơ pháp 540g SCL BigBag 120g",
    //       "DocumentNo": "635",
    //       "ItemNo": "10324065",
    //       "LineNo": "2",
    //       "MarketPrice": 0,
    //       "NetPrice": 135000,
    //       "Quantity": 2,
    //       "QuantityConfirm": 0,
    //       "TotalAmount": 270000,
    //       "UnitOfMeasure": "HOP",
    //       "UnitPrice": 135000,
    //       "UrlImage": "https://hcm.fstorage.vn/winplus/prod/2024/12/24/aae58cb3-6cd0-4cf6-91e8-43f77f1744d5.jpg",
    //       "VatGroup": 0,
    //       "VatRate": 0
    //     },
    // {
    //       "Barcode": "8934680114967",
    //       "Description": "LU bánh quy bơ pháp 540g BigBag 120 g",
    //       "DocumentNo": "635",
    //       "ItemNo": "10324065",
    //       "LineNo": "2",
    //       "MarketPrice": 0,
    //       "NetPrice": 135000,
    //       "Quantity": 2000,
    //       "QuantityConfirm": 0,
    //       "TotalAmount": 270000,
    //       "UnitOfMeasure": "HOP",
    //       "UnitPrice": 135000,
    //       "UrlImage": "https://hcm.fstorage.vn/winplus/prod/2024/12/24/aae58cb3-6cd0-4cf6-91e8-43f77f1744d5.jpg",
    //       "VatGroup": 0,
    //       "VatRate": 0
    //     }
    //   ],
    //   "MemberLevel": 1,
    //   "MemberLevelName": "Hội viên",
    //   "PosCode": "sm.thuy.hub",
    //   "PosName": "sm Thuy HUB",
    //   "SaleType": 1,
    //   "StatusId": 20,
    //   "StatusName": "Đã duyệt",
    //   "StoreId": "6B01",
    //   "StoreName": "HUB WIN+ THA 66B Phố Thiều",
    //   "TotalPrice": 1080000,
    //   "UserId": 0,
    //   "check": false
    // }
    //         """;
    // final Map<String, dynamic> decoded = jsonDecode(jsonStr);
    // final saleOrder = SaleOrderHeader.fromJson(decoded);
    // setState(() {
    //   receiptData = saleOrder;
    // });
  }

  String _formatCurrency(double amount) {
    final formatter = NumberFormat("#,###", "vi_VN");
    return formatter.format(amount);
  }

  @override
  void initState() {
    super.initState();
    setupChannelHandler();
  }

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    await getMacAddress();
  }

  Future<void> saveMacAddress(Printer printer) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('device_address', printer.address);
    await prefs.setString('device_name', printer.name);
  }

  Future<void> getMacAddress() async {
    final prefs = await SharedPreferences.getInstance();
    final address = prefs.getString('device_address');
    final name = prefs.getString('device_name');
    if (address != null && name != null) {
      final connectState = await FlutterBluetoothPrinter.connect(address);
      if (!connectState) {
        print("Failed to connect to printer with address: $address");
        printer = null;
        prefs.remove("device_address");
        prefs.remove("device_name");
        return;
      } else {
        setState(() {
          printer = Printer(name: name, address: address);
        });
      }
    } else {
      print("No printer found in preferences");
    }
  }

  Future<void> _setUpPrinter() async {
    try{
      final selected = await FlutterBluetoothPrinter.selectDevice(context);
      if (selected != null) {
        setState(() {
          printer = Printer(
            name: selected.name ?? 'Unknown Printer',
            address: selected.address,
          );
        });
        saveMacAddress(printer!);
      }
    }catch(e){
      print("Error selecting printer: $e");
    }
  }

  static Future<void> _triggerNativeBack() async {
    try {
      await _channel.invokeMethod('onBackPressed');
    } catch (e) {
      print('Error calling native back: $e');
    }
  }

  num simplifyNumber(double? value) {
    if (value == null) {
      return 0;
    }
    if (value % 1 == 0) {
      return value.toInt();
    } else {
      return value;
    }
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
            _triggerNativeBack();
          },
        ),
        title: const Text(
          'IN HÓA ĐƠN',
          style: TextStyle(
            fontFamily: 'Roboto',
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 15,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () async {
              await _setUpPrinter();
            },
            icon: const Icon(Icons.print, color: Colors.white),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Receipt(
              backgroundColor: Color(0xFFE5E5E5),
              containerBuilder: (context, child) {
                return Container(
                  color: Color(0xFFE5E5E5),
                  child: ClipRect(
                    clipBehavior: Clip.hardEdge,
                    child: Container(
                      alignment: Alignment.center,
                      child: FittedBox(
                        fit: BoxFit.fitWidth,
                        child: InteractiveViewer(
                          boundaryMargin: EdgeInsets.zero,
                          clipBehavior: Clip.none,
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Container(
                              padding: const EdgeInsets.all(12),
                              color: Colors.white,
                              child: child,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
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
                                'assets/images/win-logo.png',
                                height: 35,
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: const Text(
                                'HUB WIN+ THA Phần Thôn, Thọ Xuân Thôn Phần Thôn, Xã Thọ Hải, Huyện Thọ Xuân',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontFamily: 'Roboto',
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
                                style: TextStyle(
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 12),
                              Text(
                                '(In lần 1)',
                                style: TextStyle(
                                  fontFamily: 'Roboto',
                                  fontSize: ReceiptSize.medium,
                                ),
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
                        const SizedBox(height: 4),
                        if (receiptData.items != null &&
                            receiptData.items!.isEmpty)
                          const Center(
                            child: Text(
                              'Không có mặt hàng nào',
                              style: TextStyle(
                                fontFamily: 'Roboto',
                                fontSize: ReceiptSize.standard,
                              ),
                            ),
                          ),
                        for (final item in receiptData.items!)
                          buildItemRow(item),
                        const CustomDivider(),
                        buildTotalRow(
                          'TỔNG TIỀN PHẢI T.TOÁN',
                          _formatCurrency(receiptData.total()),
                          bold: true,
                        ),
                        const SizedBox(height: 2),
                        buildTotalRow(
                          'TỔNG TIỀN SẢN PHẨM',
                          _formatCurrency(
                            receiptData.totalPrice ?? 0,
                          ).toString(),
                        ),
                        const SizedBox(height: 2),
                        buildTotalRow('TIỀN KHÁCH TRẢ', ""),
                        const SizedBox(height: 2),
                        buildKeyValueRow('  Tiền Voucher', ""),
                        const SizedBox(height: 2),
                        buildTotalRow('TIỀN TRẢ LẠI', ""),
                        const SizedBox(height: 8),
                        const Center(
                          child: Text(
                            '(Giá đã bao gồm thuế GTGT)',
                            style: TextStyle(
                              fontFamily: 'Roboto',
                              fontSize: ReceiptSize.medium,
                            ),
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
                                  fontFamily: 'Roboto',
                                  fontSize: ReceiptSize.standard,
                                ),
                              ),
                              SizedBox(height: 12),
                              Text(
                                'Tax invoice will be issued within same day',
                                style: TextStyle(
                                  fontFamily: 'Roboto',
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
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.bold,
                                  fontSize: ReceiptSize.standard,
                                ),
                              ),
                              SizedBox(height: 16),
                              Text(
                                'Hotline: 02471066856   Website: www.winmart.vn',
                                style: TextStyle(
                                  fontFamily: 'Roboto',
                                  fontSize: ReceiptSize.medium,
                                ),
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
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFFC6142C),
                      ),
                      onPressed: () async {
                        if (printer == null) {
                          await _setUpPrinter();
                        }

                        if (context.mounted && printer != null) {
                          PrintingProgressDialog.print(
                            context,
                            device: printer!.address,
                            controller: controller!,
                          );
                        }
                      },
                      child: Text(
                        'In (${printer?.name ?? 'Chọn máy in'})',
                        style: const TextStyle(
                          fontFamily: 'Roboto',
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: FontSize.standard,
                        ),
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
            style: const TextStyle(
              fontFamily: 'Roboto',
              fontSize: ReceiptSize.standard,
            ),
          ),
        ),
        Expanded(
          flex: 6,
          child: Text(
            value,
            style: const TextStyle(
              fontFamily: 'Roboto',
              fontSize: ReceiptSize.standard,
            ),
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
              fontFamily: 'Roboto',
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
              fontFamily: 'Roboto',
              fontWeight: FontWeight.bold,
              fontSize: ReceiptSize.standard,
            ),
          ),
        ),
        SizedBox(width: 4),
        Expanded(
          flex: 1,
          child: Text(
            'SL',
            textAlign: TextAlign.right,
            style: TextStyle(
              fontFamily: 'Roboto',
              fontWeight: FontWeight.bold,
              fontSize: ReceiptSize.standard,
            ),
          ),
        ),
        SizedBox(width: 4),
        Expanded(
          flex: 1,
          child: Text(
            'ĐVT',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Roboto',
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
              fontFamily: 'Roboto',
              fontWeight: FontWeight.bold,
              fontSize: ReceiptSize.standard,
            ),
          ),
        ),
      ],
    ),
  );

  Widget buildItemRow(SaleOrderItem item) => Container(
    margin: const EdgeInsets.symmetric(vertical: 6),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          item.description ?? '',
          style: const TextStyle(
            fontFamily: 'Roboto',
            fontWeight: FontWeight.w400,
            fontSize: ReceiptSize.midLarge,
          ),
        ),
        const SizedBox(height: 6),
        Row(
          children: [
            const SizedBox(width: 0),
            Expanded(flex: 4, child: SizedBox()),
            Expanded(
              flex: 2,
              child: Text(
                item.netPrice != null ? _formatCurrency(item.netPrice!) : '0',
                textAlign: TextAlign.right,
                style: const TextStyle(
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w400,
                  fontSize: ReceiptSize.medium2,
                ),
              ),
            ),
            SizedBox(width: 4),
            Expanded(
              flex: 1,
              child: Text(
                item.quantity != null
                    ? simplifyNumber(item.quantity).toString()
                    : '0',
                textAlign: TextAlign.right,
                style: const TextStyle(
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w400,
                  fontSize: ReceiptSize.medium2,
                ),
              ),
            ),
            SizedBox(width: 4),
            Expanded(
              flex: 1,
              child: Text(
                item.unitOfMeasure != null
                    ? item.unitOfMeasure.toString()
                    : 'T',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w400,
                  fontSize: ReceiptSize.medium2,
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Text(
                item.totalAmount != null
                    ? _formatCurrency(item.totalAmount!)
                    : '0',
                textAlign: TextAlign.right,
                style: const TextStyle(
                  fontFamily: 'Roboto',
                  fontSize: ReceiptSize.medium2,
                ),
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
                  fontFamily: 'Roboto',
                  fontSize: ReceiptSize.midLarge,
                  fontWeight: bold ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ),
            Text(
              amount,
              style: TextStyle(
                fontFamily: 'Roboto',
                fontSize: ReceiptSize.midLarge,
                fontWeight: bold ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      );
}

class Printer {
  String name;
  String address;

  Printer({required this.name, required this.address});
}
