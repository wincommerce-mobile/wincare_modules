// import 'package:flutter/foundation.dart';
// import 'package:flutter_bluetooth_printer/flutter_bluetooth_printer_library.dart';
//
// import '../widgets/printing_progress_dialog.dart';
//
// class PrinterHelper {
//   static Future<bool> printBytes({
//     required String address,
//     required Uint8List data,
//
//     /// if true, you should manually disconnect the printer after finished
//     required bool keepConnected,
//     int maxBufferSize = 512,
//     int delayTime = 120,
//     ProgressCallback? onProgress,
//   }) {
//     return FlutterBluetoothPrinter.printBytes(
//       address: address,
//       data: data,
//       onProgress: onProgress,
//       keepConnected: keepConnected,
//       maxBufferSize: maxBufferSize,
//       delayTime: delayTime,
//     );
//   }
// }
//
// class aa {
//   Future<bool> prin() async {
//     int addFeeds = 0;
//     bool useImageRaster = true;
//     final generator = Generator();
//     final reset = generator.reset();
//     final imageData = await generator.encode(
//       bytes: imageBytes,
//       dotsPerLine: paperSize.width,
//       useImageRaster: useImageRaster,
//     );
//
//     final additional = paperSize == PaperSize.mm58
//         ? <int>[
//       for (int i = 0; i < addFeeds; i++) ...Commands.carriageReturn,
//     ]
//         : <int>[
//       for (int i = 0; i < addFeeds; i++) ...Commands.lineFeed,
//     ];
//     ///
//     final keepConnected = true;
//     final address = "";
//     final data = Uint8List.fromList([...imageData, ...reset, ...additional]);
//     final onProgress = (total, sent) {
//       debugPrint('Progress: $sent/$total');
//     };
//     final maxBufferSize = 512;
//     final delayTime = 120;
//     return await PrinterHelper.printBytes(
//       address: '00:11:22:33:44:55',
//       data: Uint8List.fromList([1, 2, 3, 4, 5]),
//       keepConnected: true,
//       maxBufferSize: 512,
//       delayTime: 120,
//       onProgress: (total, sent) {
//         debugPrint('Progress: $sent/$total');
//       },
//     );
//   }
// }
