import 'dart:convert';

import 'package:flutter/services.dart';

import '../models/receipt_model.dart';

class ReceiptDataSource {
  static const _channel = MethodChannel('com.wincare/printer');

  Future<ReceiptModel> fetchReceipts(String receiptCode) async {
    try {
      // final Map<dynamic, dynamic> result = await _channel.invokeMethod(
      //   'getReceiptData',
      //   {
      //     'receiptCode': receiptCode, // Send params
      //   },
      // );
      //
      // final jsonStr = jsonEncode(result);
      final jsonStr = """{
  "saleDate": "17/01/2025 19:59",
  "receiptCode": "6B100617789112648",
  "counter": "B10",
  "orderCode": "6B100617789112648",
  "customerName": "Trần Thị Hợp (Cửa Hàng Tạp Hóa Hợp Thanh)",
  "customerPhone": "0961891427",
  "items": [
    {
      "name": "OMACHI Mì DO kấy sườn ngũ quả 80g\n18936221041746",
      "price": "202,000",
      "qty": "5",
      "unit": "T",
      "total": "1,010,000"
    },
    {
      "name": "OMACHI Mì DO xốt bò hầm 80g\n18936221041753",
      "price": "202,000",
      "qty": "6",
      "unit": "T",
      "total": "1,212,000"
    },
    {
      "name": "DELIPIE Bánh pie sữa hương vani 216g\n18935604744126",
      "price": "277,200",
      "qty": "1",
      "unit": "T",
      "total": "277,200"
    },
    {
      "name": "OMACHI Mì DO kấy sườn ngũ quả 80g\n18936221041746",
      "price": "202,000",
      "qty": "5",
      "unit": "T",
      "total": "1,010,000"
    },
    {
      "name": "OMACHI Mì DO xốt bò hầm 80g\n18936221041753",
      "price": "202,000",
      "qty": "6",
      "unit": "T",
      "total": "1,212,000"
    },
    {
      "name": "DELIPIE Bánh pie sữa hương vani 216g\n18935604744126",
      "price": "277,200",
      "qty": "1",
      "unit": "T",
      "total": "277,200"
    },
    {
      "name": "OMACHI Mì DO kấy sườn ngũ quả 80g\n18936221041746",
      "price": "202,000",
      "qty": "5",
      "unit": "T",
      "total": "1,010,000"
    }
  ],
  "totalAmount": "2,499,200",
  "totalProductAmount": "2,499,200",
  "customerPaid": "805,500",
  "voucherAmount": "805,500",
  "refundAmount": "0",
  "customerCardId": "XXXXXXXXXXXX1427",
  "accumulatedPoints": "0",
  "deliveryMethod": "Đơn bán hàng Mobile",
  "deliveryTime": "17/01/2025 19:42",
  "deliveryAddress": "Thôn Hải Mậu, Xã Thọ Hải, Thọ Xuân"
}""";
      return ReceiptModel.fromJson(jsonDecode(jsonStr));
    } on PlatformException catch (e) {
      throw Exception("Failed to fetch receipt data: ${e.message}");
    }
  }
}
