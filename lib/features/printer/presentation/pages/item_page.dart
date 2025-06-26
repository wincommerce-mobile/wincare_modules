// import 'dart:convert';
//
// import 'package:auto_size_text/auto_size_text.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_bluetooth_printer/flutter_bluetooth_printer.dart';
// import 'package:intl/intl.dart';
// import 'package:qr_flutter/qr_flutter.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// import '../../../../core/theme.dart';
// import '../../data/models/sale_order_header.dart';
// import '../widgets/printing_progress_dialog.dart';
//
// class ItemPage extends StatefulWidget {
//   const ItemPage({super.key});
//
//   @override
//   State<ItemPage> createState() => _ItemPageState();
// }
//
// class _ItemPageState extends State<ItemPage> {
//   ReceiptController? controller;
//   Printer? printer;
//   SaleOrderHeader? receiptData;
//   bool _isLoading = false;
//
//   static const _channel = MethodChannel('com.wincare/printer');
//
//   Future<void> setupChannelHandler() async {
//     try {
//       _channel.setMethodCallHandler((call) async {
//         print("Received arguments: ${call.arguments}");
//         if (call.method == 'sendSaleOrderData') {
//           final jsonStr = call.arguments as String;
//           print("Received saleOrder: $jsonStr");
//           final Map<String, dynamic> decoded = jsonDecode(jsonStr);
//           final saleOrder = SaleOrderHeader.fromJson(decoded);
//           setState(() {
//             receiptData = saleOrder;
//             _isLoading = false;
//           });
//         }
//       });
//     } catch (e) {
//       setState(() {
//         _isLoading = false;
//       });
//       print('Error setting up channel handler: $e');
//     }
//     // final jsonStr = """
//     //       {"BillCode":"6B01smthuyhub638","BillDate":"2025-06-11T00:00:00","CustomerName":"Nguyễn Thị Vân","CustomerPhone":"0367662110","DeliveryDate":"2025-06-14T00:00:00","FullAddress":"Phu phố Phúc Lâm, TT Lam Sơn, Thọ Xuân, Thanh Hóa","IsAllowCancel":false,"IsAllowConfirm":false,"Items":[{"Barcode":"8936210890815","Description":"MYSTYLE Kẹo dẻo bóc vỏ vị trcây mix 120G","DocumentNo":"638","ItemNo":"10142530","LineNo":"4","MarketPrice":0.0,"NetPrice":31200.0,"Quantity":1.0,"QuantityConfirm":0.0,"TotalAmount":31200.0,"UnitOfMeasure":"G1","UnitPrice":31200.0,"UrlImage":"https://hcm.fstorage.vn/winplus/prod/2024/11/12/5372d2b7-686a-46a2-a9bb-dfb60b0a42a8.jpg","VatGroup":0,"VatRate":0},{"Barcode":"8934680025980","Description":"AFC TPBS Bánh lúa mì 172g (T16)","DocumentNo":"638","ItemNo":"10013618","LineNo":"1","MarketPrice":0.0,"NetPrice":25200.0,"Quantity":1.0,"QuantityConfirm":0.0,"TotalAmount":25200.0,"UnitOfMeasure":"HOP","UnitPrice":25200.0,"UrlImage":"https://hcm.fstorage.vn/images/2023/12/10013618-20231213072101.png","VatGroup":0,"VatRate":0},{"Barcode":"2050000915833","Description":"MYSTYLE Kẹo dẻo bóc vỏ vị trcây mix 120G","DocumentNo":"638","ItemNo":"10142530","LineNo":"3","MarketPrice":0.0,"NetPrice":936000.0,"Quantity":1.0,"QuantityConfirm":0.0,"TotalAmount":936000.0,"UnitOfMeasure":"T","UnitPrice":936000.0,"UrlImage":"https://hcm.fstorage.vn/winplus/prod/2024/11/12/5372d2b7-686a-46a2-a9bb-dfb60b0a42a8.jpg","VatGroup":0,"VatRate":0},{"Barcode":"8934680089326","Description":"AFC TPBS Bánh lúa mì 172g (T16)","DocumentNo":"638","ItemNo":"10013618","LineNo":"2","MarketPrice":0.0,"NetPrice":403200.0,"Quantity":1.0,"QuantityConfirm":0.0,"TotalAmount":403200.0,"UnitOfMeasure":"T","UnitPrice":403200.0,"UrlImage":"https://hcm.fstorage.vn/images/2023/12/10013618-20231213072101.png","VatGroup":0,"VatRate":0}],"MemberLevel":1,"MemberLevelName":"Hội viên","PosCode":"sm.thuy.hub","PosName":"sm Thuy HUB","SaleType":1,"StatusId":20,"StatusName":"Đã duyệt","StoreId":"6B01","StoreName":"HUB WIN+ THA 66B Phố Thiều","TotalPrice":1395600.0,"UserId":0,"check":false}
//     //         """;
//     // try {
//     //   Future.delayed(const Duration(seconds: 5), () {
//     //     final Map<String, dynamic> decoded = jsonDecode(jsonStr);
//     //     final saleOrder = SaleOrderHeader.fromJson(decoded);
//     //     setState(() {
//     //       receiptData = saleOrder;
//     //       _isLoading = false;
//     //     });
//     //   });
//     // } catch (e) {
//     //   print("Error parsing JSON: $e");
//     // }
//   }
//
//   String _formatCurrency(num? amount) {
//     if (amount == null) {
//       return "0";
//     }
//
//     final formatter = NumberFormat("#,###", "vi_VN");
//     return formatter.format(amount);
//   }
//
//   String formatDate(DateTime date) {
//     return DateFormat('dd/MM/yyyy').format(date);
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       //setupChannelHandler();
//     });
//   }
//
//   @override
//   void didChangeDependencies() async {
//     super.didChangeDependencies();
//     //await getMacAddress();
//   }
//
//   Future<void> saveMacAddress(Printer printer) async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.setString('device_address', printer.address);
//     await prefs.setString('device_name', printer.name);
//   }
//
//   Future<void> getMacAddress() async {
//     try {
//       final prefs = await SharedPreferences.getInstance();
//       final address = prefs.getString('device_address');
//       final name = prefs.getString('device_name');
//       if (address != null && name != null) {
//         final connectState = await FlutterBluetoothPrinter.connect(address);
//         if (!connectState) {
//           print("Failed to connect to printer with address: $address");
//           printer = null;
//           prefs.remove("device_address");
//           prefs.remove("device_name");
//           return;
//         } else {
//           setState(() {
//             printer = Printer(name: name, address: address);
//           });
//         }
//       } else {
//         print("No printer found in preferences");
//       }
//     } catch (e) {
//       print("Error retrieving MAC address: $e");
//     }
//   }
//
//   Future<void> _setUpPrinter() async {
//     try {
//       final selected = await FlutterBluetoothPrinter.selectDevice(context);
//       if (selected != null) {
//         setState(() {
//           printer = Printer(
//             name: selected.name ?? 'Unknown Printer',
//             address: selected.address,
//           );
//         });
//         saveMacAddress(printer!);
//       }
//     } catch (e) {
//       print("Error selecting printer: $e");
//     }
//   }
//
//   static Future<void> _triggerNativeBack() async {
//     try {
//       await _channel.invokeMethod('onBackPressed');
//     } catch (e) {
//       print('Error calling native back: $e');
//     }
//   }
//
//   num simplifyNumber(num? value) {
//     if (value == null) {
//       return 0;
//     }
//     if (value % 1 == 0) {
//       return value.toInt();
//     } else {
//       return value;
//     }
//   }
//
//   final item = Item(
//     name: 'ALPENLIEBE Kẹo Mềm H.Dâu 2Chew 73.5g',
//     originalPrice: 15900,
//     discountedPrice: 1800,
//     qrCode: '8935001712435',
//     unitOfMeasure: 'G1',
//     fromDate: DateTime(2025, 6, 19),
//     toDate: DateTime(2025, 7, 2),
//   );
//
//   final items = [
//     Item(
//       name: 'ALPENLIEBE Kẹo Mềm H.Dâu 2Chew 73.5g',
//       originalPrice: 9000,
//       discountedPrice: 1800,
//       qrCode: '8935001712435',
//       unitOfMeasure: 'G1',
//       fromDate: DateTime(2025, 6, 19),
//       toDate: DateTime(2025, 7, 2),
//     ),
//     Item(
//       name: 'ALPENLIEBE Kẹo Mềm H.Dâu 2Chew 73.5g',
//       originalPrice: 15900,
//       discountedPrice: 1800,
//       qrCode: '8935001712435',
//       unitOfMeasure: 'G1',
//       fromDate: DateTime(2025, 6, 19),
//       toDate: DateTime(2025, 7, 2),
//     ),
//     Item(
//       name: 'ALPENLIEBE Kẹo Mềm H.Dâu 2Chew 73.5g',
//       originalPrice: 159000,
//       discountedPrice: 1800,
//       qrCode: '8935001712435',
//       unitOfMeasure: 'G1',
//       fromDate: DateTime(2025, 6, 19),
//       toDate: DateTime(2025, 7, 2),
//     ),
//     Item(
//       name: 'ALPENLIEBE Kẹo Mềm H.Dâu 2Chew 73.5g',
//       originalPrice: 1800000,
//       discountedPrice: 1800,
//       qrCode: '8935001712435',
//       unitOfMeasure: 'G1',
//       fromDate: DateTime(2025, 6, 19),
//       toDate: DateTime(2025, 7, 2),
//     ),
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Color(0xFFC6142C),
//         centerTitle: true,
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
//           onPressed: () {
//             _triggerNativeBack();
//           },
//         ),
//         title: const Text(
//           'IN HÓA ĐƠN',
//           style: TextStyle(
//             fontFamily: 'Roboto',
//             fontWeight: FontWeight.bold,
//             color: Colors.white,
//             fontSize: 15,
//           ),
//         ),
//         actions: [
//           IconButton(
//             onPressed: () async {
//               await _setUpPrinter();
//             },
//             icon: const Icon(Icons.print, color: Colors.white),
//           ),
//         ],
//       ),
//       body: Column(
//         crossAxisAlignment: CrossAxisAlignment.stretch,
//         children: [
//           Expanded(
//             child: Receipt(
//               backgroundColor: Color(0xFFE5E5E5),
//               containerBuilder: (context, child) {
//                 return Container(
//                   color: Color(0xFFE5E5E5),
//                   child: ClipRect(
//                     clipBehavior: Clip.hardEdge,
//                     child: Container(
//                       alignment: Alignment.center,
//                       child: FittedBox(
//                         fit: BoxFit.fitWidth,
//                         child: InteractiveViewer(
//                           boundaryMargin: EdgeInsets.zero,
//                           clipBehavior: Clip.none,
//                           child: Padding(
//                             padding: const EdgeInsets.all(16.0),
//                             child: Container(
//                               padding: const EdgeInsets.all(12),
//                               color: Colors.white,
//                               child: child,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 );
//               },
//               builder: (context) {
//                 return Column(
//                   children: items
//                       .map(
//                         (item) => Align(
//                           alignment: Alignment.topCenter,
//                           child: Container(
//                             width: 360,
//                             margin: EdgeInsets.only(bottom: 100),
//                             //height: 240,
//                             child: Stack(
//                               children: [
//                                 Column(
//                                   children: [
//                                     SizedBox(
//                                       width: 360,
//                                       //height: 240,
//                                       child: Column(
//                                         crossAxisAlignment:
//                                             CrossAxisAlignment.start,
//                                         children: [
//                                           /// Product name
//                                           Text(
//                                             item.name,
//                                             style: TextStyle(
//                                               fontFamily: 'Roboto',
//                                               fontWeight: FontWeight.w700,
//                                               height: 1.2,
//                                               fontSize: 19,
//                                             ),
//                                           ),
//
//                                           /// QR & big text
//                                           SizedBox(
//                                             height: 140,
//                                             child: Row(
//                                               crossAxisAlignment:
//                                                   CrossAxisAlignment.end,
//                                               children: [
//                                                 /// QR Code
//                                                 Column(
//                                                   crossAxisAlignment:
//                                                       CrossAxisAlignment.center,
//                                                   mainAxisAlignment:
//                                                       MainAxisAlignment.end,
//                                                   children: [
//                                                     QrImageView(
//                                                       data: item.qrCode,
//                                                       size: 70,
//                                                       padding: EdgeInsets.all(
//                                                         2,
//                                                       ),
//                                                     ),
//                                                     Text(
//                                                       item.qrCode,
//                                                       style: TextStyle(
//                                                         fontSize: 10,
//                                                         fontWeight:
//                                                             FontWeight.bold,
//                                                         fontFamily: 'Roboto',
//                                                       ),
//                                                     ),
//                                                   ],
//                                                 ),
//
//                                                 /// Row spacer
//
//                                                 /// Big text & price
//                                                 Expanded(
//                                                   child: Column(
//                                                     crossAxisAlignment:
//                                                         CrossAxisAlignment.end,
//                                                     children: [
//                                                       Expanded(
//                                                         child: Stack(
//                                                           children: [
//                                                             Container(
//                                                               //width: 250,
//                                                               //height: 110,
//                                                               alignment:
//                                                                   Alignment
//                                                                       .topRight,
//                                                               child: Row(
//                                                                 crossAxisAlignment:
//                                                                     CrossAxisAlignment
//                                                                         .start,
//                                                                 mainAxisSize:
//                                                                     MainAxisSize
//                                                                         .min,
//                                                                 children: [
//                                                                   Expanded(
//                                                                     child: AutoSizeText(
//                                                                       item.major,
//                                                                       maxFontSize:
//                                                                           122,
//                                                                       minFontSize:
//                                                                           22,
//                                                                       maxLines:
//                                                                           1,
//                                                                       textAlign:
//                                                                           TextAlign
//                                                                               .end,
//                                                                       style: TextStyle(
//                                                                         fontSize:
//                                                                             122,
//                                                                         fontFamily:
//                                                                             'Roboto',
//                                                                         fontWeight:
//                                                                             FontWeight.w700,
//                                                                       ),
//                                                                     ),
//                                                                   ),
//                                                                   Container(
//                                                                     height: 35,
//                                                                     alignment:
//                                                                         Alignment
//                                                                             .center,
//                                                                     child: Text(
//                                                                       item.decimal,
//                                                                       style: TextStyle(
//                                                                         fontSize:
//                                                                             22,
//                                                                         fontFamily:
//                                                                             'Roboto',
//                                                                         fontWeight:
//                                                                             FontWeight.bold,
//                                                                       ),
//                                                                     ),
//                                                                   ),
//                                                                 ],
//                                                               ),
//                                                             ),
//                                                             // Positioned(
//                                                             //   top: -20,
//                                                             //   right: 0,
//                                                             //   child: Text(
//                                                             //     '15.900đ',
//                                                             //     style: TextStyle(
//                                                             //       decoration: TextDecoration.lineThrough,
//                                                             //       fontWeight: FontWeight.bold,
//                                                             //       fontFamily: 'Roboto',
//                                                             //       fontSize: 21,
//                                                             //     ),
//                                                             //   ),
//                                                             // ),
//                                                           ],
//                                                         ),
//                                                       ),
//                                                       Text(
//                                                         'ĐVT: ${item.unitOfMeasure}',
//                                                         style: TextStyle(
//                                                           fontSize: 16,
//                                                           fontWeight:
//                                                               FontWeight.bold,
//                                                           fontFamily: 'Roboto',
//                                                         ),
//                                                       ),
//                                                       const SizedBox(height: 4),
//                                                       Text(
//                                                         'Ngày áp dụng: ${formatDate(item.fromDate)} - ${formatDate(item.toDate)}',
//                                                         style: TextStyle(
//                                                           fontSize: 12,
//                                                           fontWeight:
//                                                               FontWeight.bold,
//                                                           fontFamily: 'Roboto',
//                                                         ),
//                                                       ),
//                                                     ],
//                                                   ),
//                                                 ),
//                                               ],
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                                 Positioned(
//                                   top: 32,
//                                   right: 0,
//                                   child: Text(
//                                     item.discountedPrice.toString(),
//                                     style: TextStyle(
//                                       decoration: TextDecoration.lineThrough,
//                                       fontWeight: FontWeight.bold,
//                                       fontFamily: 'Roboto',
//                                       fontSize: 21,
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       )
//                       .toList(),
//                 );
//                 // return Align(
//                 //   alignment: Alignment.topCenter,
//                 //   child: SizedBox(
//                 //     width: 360,
//                 //     //height: 240,
//                 //     child: Stack(
//                 //       children: [
//                 //         Column(
//                 //           children: [
//                 //             SizedBox(
//                 //               width: 360,
//                 //               //height: 240,
//                 //               child: Column(
//                 //                 crossAxisAlignment: CrossAxisAlignment.start,
//                 //                 children: [
//                 //                   /// Product name
//                 //                   Text(
//                 //                     item.name,
//                 //                     style: TextStyle(
//                 //                       fontFamily: 'Roboto',
//                 //                       fontWeight: FontWeight.w700,
//                 //                       height: 1.2,
//                 //                       fontSize: 19,
//                 //                     ),
//                 //                   ),
//                 //
//                 //                   /// QR & big text
//                 //                   SizedBox(
//                 //                     height: 140,
//                 //                     child: Row(
//                 //                       crossAxisAlignment:
//                 //                           CrossAxisAlignment.end,
//                 //                       children: [
//                 //                         /// QR Code
//                 //                         Column(
//                 //                           crossAxisAlignment:
//                 //                               CrossAxisAlignment.center,
//                 //                           mainAxisAlignment:
//                 //                               MainAxisAlignment.end,
//                 //                           children: [
//                 //                             QrImageView(
//                 //                               data: item.qrCode,
//                 //                               size: 70,
//                 //                               padding: EdgeInsets.all(2),
//                 //                             ),
//                 //                             Text(
//                 //                               item.qrCode,
//                 //                               style: TextStyle(
//                 //                                 fontSize: 10,
//                 //                                 fontWeight: FontWeight.bold,
//                 //                                 fontFamily: 'Roboto',
//                 //                               ),
//                 //                             ),
//                 //                           ],
//                 //                         ),
//                 //
//                 //                         /// Row spacer
//                 //
//                 //                         /// Big text & price
//                 //                         Expanded(
//                 //                           child: Column(
//                 //                             crossAxisAlignment:
//                 //                                 CrossAxisAlignment.end,
//                 //                             children: [
//                 //                               Expanded(
//                 //                                 child: Stack(
//                 //                                   children: [
//                 //                                     Container(
//                 //                                       //width: 250,
//                 //                                       //height: 110,
//                 //                                       alignment:
//                 //                                           Alignment.topRight,
//                 //                                       child: Row(
//                 //                                         crossAxisAlignment:
//                 //                                             CrossAxisAlignment
//                 //                                                 .start,
//                 //                                         mainAxisSize:
//                 //                                             MainAxisSize.min,
//                 //                                         children: [
//                 //                                           Expanded(
//                 //                                             child: AutoSizeText(
//                 //                                               item.major,
//                 //                                               maxFontSize: 122,
//                 //                                               minFontSize: 22,
//                 //                                               maxLines: 1,
//                 //                                               textAlign:
//                 //                                                   TextAlign.end,
//                 //                                               style: TextStyle(
//                 //                                                 fontSize: 122,
//                 //                                                 fontFamily:
//                 //                                                     'Roboto',
//                 //                                                 fontWeight:
//                 //                                                     FontWeight
//                 //                                                         .w700,
//                 //                                               ),
//                 //                                             ),
//                 //                                           ),
//                 //                                           Container(
//                 //                                             height: 35,
//                 //                                             alignment: Alignment
//                 //                                                 .center,
//                 //                                             child: Text(
//                 //                                               item.decimal,
//                 //                                               style: TextStyle(
//                 //                                                 fontSize: 22,
//                 //                                                 fontFamily:
//                 //                                                     'Roboto',
//                 //                                                 fontWeight:
//                 //                                                     FontWeight
//                 //                                                         .bold,
//                 //                                               ),
//                 //                                             ),
//                 //                                           ),
//                 //                                         ],
//                 //                                       ),
//                 //                                     ),
//                 //                                     // Positioned(
//                 //                                     //   top: -20,
//                 //                                     //   right: 0,
//                 //                                     //   child: Text(
//                 //                                     //     '15.900đ',
//                 //                                     //     style: TextStyle(
//                 //                                     //       decoration: TextDecoration.lineThrough,
//                 //                                     //       fontWeight: FontWeight.bold,
//                 //                                     //       fontFamily: 'Roboto',
//                 //                                     //       fontSize: 21,
//                 //                                     //     ),
//                 //                                     //   ),
//                 //                                     // ),
//                 //                                   ],
//                 //                                 ),
//                 //                               ),
//                 //                               Text(
//                 //                                 'ĐVT: ${item.unitOfMeasure}',
//                 //                                 style: TextStyle(
//                 //                                   fontSize: 16,
//                 //                                   fontWeight: FontWeight.bold,
//                 //                                   fontFamily: 'Roboto',
//                 //                                 ),
//                 //                               ),
//                 //                               const SizedBox(height: 4),
//                 //                               Text(
//                 //                                 'Ngày áp dụng: ${formatDate(item.fromDate)} - ${formatDate(item.toDate)}',
//                 //                                 style: TextStyle(
//                 //                                   fontSize: 12,
//                 //                                   fontWeight: FontWeight.bold,
//                 //                                   fontFamily: 'Roboto',
//                 //                                 ),
//                 //                               ),
//                 //                             ],
//                 //                           ),
//                 //                         ),
//                 //                       ],
//                 //                     ),
//                 //                   ),
//                 //                 ],
//                 //               ),
//                 //             ),
//                 //           ],
//                 //         ),
//                 //         Positioned(
//                 //           top: 32,
//                 //           right: 0,
//                 //           child: Text(
//                 //             item.discountedPrice.toString(),
//                 //             style: TextStyle(
//                 //               decoration: TextDecoration.lineThrough,
//                 //               fontWeight: FontWeight.bold,
//                 //               fontFamily: 'Roboto',
//                 //               fontSize: 21,
//                 //             ),
//                 //           ),
//                 //         ),
//                 //       ],
//                 //     ),
//                 //   ),
//                 // );
//               },
//               onInitialized: (controller) {
//                 controller.paperSize = PaperSize.mm58;
//                 setState(() {
//                   this.controller = controller;
//                 });
//               },
//             ),
//           ),
//           SafeArea(
//             child: Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Row(
//                 children: [
//                   Expanded(
//                     child: ElevatedButton(
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Color(0xFFC6142C),
//                       ),
//                       onPressed: () async {
//                         if (printer == null) {
//                           await _setUpPrinter();
//                         }
//
//                         if (context.mounted && printer != null) {
//                           PrintingProgressDialog.print(
//                             context,
//                             device: printer!.address,
//                             controller: controller!,
//                           );
//                         }
//                       },
//                       child: Text(
//                         'In (${printer?.name ?? 'Chọn máy in'})',
//                         style: const TextStyle(
//                           fontFamily: 'Roboto',
//                           color: Colors.white,
//                           fontWeight: FontWeight.bold,
//                           fontSize: FontSize.standard,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget buildKeyValueRow(String key, String value) => Padding(
//     padding: const EdgeInsets.symmetric(vertical: 2),
//     child: Row(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Expanded(
//           flex: 4,
//           child: Text(
//             key,
//             style: const TextStyle(
//               fontFamily: 'Roboto',
//               fontSize: ReceiptSize.standard,
//             ),
//           ),
//         ),
//         Expanded(
//           flex: 6,
//           child: Text(
//             value,
//             style: const TextStyle(
//               fontFamily: 'Roboto',
//               fontSize: ReceiptSize.standard,
//             ),
//           ),
//         ),
//       ],
//     ),
//   );
//
//   Widget buildItemHeader() => Padding(
//     padding: const EdgeInsets.symmetric(vertical: 4),
//     child: Row(
//       children: const [
//         Expanded(
//           flex: 4,
//           child: Text(
//             'Mặt hàng',
//             style: TextStyle(
//               fontFamily: 'Roboto',
//               fontWeight: FontWeight.bold,
//               fontSize: ReceiptSize.standard,
//             ),
//           ),
//         ),
//         Expanded(
//           flex: 2,
//           child: Text(
//             'Đơn giá',
//             textAlign: TextAlign.right,
//             style: TextStyle(
//               fontFamily: 'Roboto',
//               fontWeight: FontWeight.bold,
//               fontSize: ReceiptSize.standard,
//             ),
//           ),
//         ),
//         SizedBox(width: 4),
//         Expanded(
//           flex: 1,
//           child: Text(
//             'SL',
//             textAlign: TextAlign.right,
//             style: TextStyle(
//               fontFamily: 'Roboto',
//               fontWeight: FontWeight.bold,
//               fontSize: ReceiptSize.standard,
//             ),
//           ),
//         ),
//         SizedBox(width: 4),
//         Expanded(
//           flex: 1,
//           child: Text(
//             'ĐVT',
//             textAlign: TextAlign.center,
//             style: TextStyle(
//               fontFamily: 'Roboto',
//               fontWeight: FontWeight.bold,
//               fontSize: ReceiptSize.standard,
//             ),
//           ),
//         ),
//         Expanded(
//           flex: 3,
//           child: Text(
//             'T.Tiền',
//             textAlign: TextAlign.right,
//             style: TextStyle(
//               fontFamily: 'Roboto',
//               fontWeight: FontWeight.bold,
//               fontSize: ReceiptSize.standard,
//             ),
//           ),
//         ),
//       ],
//     ),
//   );
//
//   Widget buildItemRow(SaleOrderItem item) => Container(
//     margin: const EdgeInsets.symmetric(vertical: 6),
//     child: Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           item.description ?? '',
//           style: const TextStyle(
//             fontFamily: 'Roboto',
//             fontWeight: FontWeight.w400,
//             fontSize: ReceiptSize.midLarge,
//           ),
//         ),
//         const SizedBox(height: 6),
//         Row(
//           children: [
//             const SizedBox(width: 0),
//             Expanded(flex: 4, child: SizedBox()),
//             Expanded(
//               flex: 2,
//               child: Text(
//                 item.netPrice != null ? _formatCurrency(item.netPrice!) : '0',
//                 textAlign: TextAlign.right,
//                 style: const TextStyle(
//                   fontFamily: 'Roboto',
//                   fontWeight: FontWeight.w400,
//                   fontSize: ReceiptSize.medium2,
//                 ),
//               ),
//             ),
//             SizedBox(width: 4),
//             Expanded(
//               flex: 1,
//               child: Text(
//                 item.quantity != null
//                     ? simplifyNumber(item.quantity).toString()
//                     : '0',
//                 textAlign: TextAlign.right,
//                 style: const TextStyle(
//                   fontFamily: 'Roboto',
//                   fontWeight: FontWeight.w400,
//                   fontSize: ReceiptSize.medium2,
//                 ),
//               ),
//             ),
//             SizedBox(width: 4),
//             Expanded(
//               flex: 1,
//               child: Text(
//                 item.unitOfMeasure != null
//                     ? item.unitOfMeasure.toString()
//                     : 'T',
//                 textAlign: TextAlign.center,
//                 style: const TextStyle(
//                   fontFamily: 'Roboto',
//                   fontWeight: FontWeight.w400,
//                   fontSize: ReceiptSize.medium2,
//                 ),
//               ),
//             ),
//             Expanded(
//               flex: 3,
//               child: Text(
//                 item.totalAmount != null
//                     ? _formatCurrency(item.totalAmount!)
//                     : '0',
//                 textAlign: TextAlign.right,
//                 style: const TextStyle(
//                   fontFamily: 'Roboto',
//                   fontSize: ReceiptSize.medium2,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ],
//     ),
//   );
//
//   Widget buildTotalRow(String label, String amount, {bool bold = false}) =>
//       Padding(
//         padding: const EdgeInsets.symmetric(vertical: 2),
//         child: Row(
//           children: [
//             Expanded(
//               child: Text(
//                 label,
//                 style: TextStyle(
//                   fontFamily: 'Roboto',
//                   fontSize: ReceiptSize.midLarge,
//                   fontWeight: bold ? FontWeight.bold : FontWeight.normal,
//                 ),
//               ),
//             ),
//             Text(
//               amount,
//               style: TextStyle(
//                 fontFamily: 'Roboto',
//                 fontSize: ReceiptSize.midLarge,
//                 fontWeight: bold ? FontWeight.bold : FontWeight.normal,
//               ),
//             ),
//           ],
//         ),
//       );
// }
//
// class Printer {
//   String name;
//   String address;
//
//   Printer({required this.name, required this.address});
// }
//
// class Item {
//   final String name;
//   final num originalPrice;
//   final num discountedPrice;
//   final String qrCode;
//   final String unitOfMeasure;
//   final DateTime fromDate;
//   final DateTime toDate;
//
//   Map<String, String> splitPrice(int value) {
//     final major = (value ~/ 1000).toString(); // Integer division
//     final remainder = value % 1000;
//     final decimal =
//         '.${remainder.toString().padLeft(3, '0')}'; // Always 3 digits
//     return {'major': major, 'decimal': decimal};
//   }
//
//   String get major {
//     final parts = splitPrice(originalPrice.toInt());
//     return '${parts['major']}';
//   }
//
//   String get decimal {
//     final parts = splitPrice(originalPrice.toInt());
//     return '${parts['decimal']}đ';
//   }
//
//   Item({
//     required this.name,
//     required this.originalPrice,
//     required this.discountedPrice,
//     required this.qrCode,
//     required this.unitOfMeasure,
//     required this.fromDate,
//     required this.toDate,
//   });
// }
