import 'dart:ui';
import 'package:flutter/material.dart';
import 'dart:typed_data';
import 'package:flutter/rendering.dart';
import 'package:flutter_bluetooth_printer/flutter_bluetooth_printer.dart';

typedef ProgressCallback = void Function(int total, int sent);

enum PaperSize {
  // original is 384 => 48 * 8
  mm58(360, 58, 'Roll Paper 58mm'),
  mm60(384, 60.4, 'Roll Paper 60mm'),
  mm80(576, 80, 'Roll Paper 80mm');

  final int width;
  final double paperWidthMM;
  final String name;

  const PaperSize(this.width, this.paperWidthMM, this.name);
}

class ReceiptController with ChangeNotifier {
  final ReceiptState _state;

  PaperSize _paperSize = PaperSize.mm60;

  PaperSize get paperSize => _paperSize;

  set paperSize(PaperSize size) {
    _paperSize = size;
    notifyListeners();
  }

  ReceiptController._({required ReceiptState state}) : _state = state;

  Future<bool> print({
    required String address,
    ProgressCallback? onProgress,

    /// add lines after print
    int addFeeds = 0,
    bool keepConnected = false,
    int maxBufferSize = 512,
    int delayTime = 120,
  }) {
    return _state.print(
      address: address,
      onProgress: onProgress,
      addFeeds: addFeeds,
      keepConnected: keepConnected,
      maxBufferSize: maxBufferSize,
      delayTime: delayTime,
    );
  }

  Future<Uint8List> getImageBytes() {
    return _state.getImageBytes();
  }
}

class CustomReceipt extends StatefulWidget {
  final WidgetBuilder builder;
  final Widget Function(BuildContext context, Widget child)? containerBuilder;
  final Color backgroundColor;
  final TextStyle? defaultTextStyle;
  final void Function(ReceiptController controller) onInitialized;

  const CustomReceipt({
    super.key,
    this.defaultTextStyle,
    this.backgroundColor = Colors.grey,
    required this.builder,
    required this.onInitialized,
    this.containerBuilder,
  });

  @override
  State<CustomReceipt> createState() => ReceiptState();
}

class ReceiptState extends State<CustomReceipt> {
  final _localKey = GlobalKey();
  PaperSize _paperSize = PaperSize.mm60;
  late ReceiptController controller;

  @override
  void initState() {
    super.initState();
    controller = ReceiptController._(state: this);
    controller.addListener(_listener);
    Future.delayed(const Duration(milliseconds: 100), () {
      widget.onInitialized(controller);
    });
  }

  void _listener() {
    if (controller._paperSize != _paperSize) {
      if (mounted) {
        setState(() {
          _paperSize = controller._paperSize;
        });
      }
    }
  }

  @override
  void dispose() {
    controller.removeListener(_listener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const style = TextStyle(
      fontSize: 24,
      height: 1.0,
      color: Colors.black,
      fontFeatures: [FontFeature.slashedZero()],
    );

    var receipt = RepaintBoundary(
      key: _localKey,
      child: Container(
        color: Colors.white,
        child: DefaultTextStyle.merge(
          style: style.merge(
            widget.defaultTextStyle ??
                const TextStyle(
                  fontFamily: 'Receipt',
                  package: 'flutter_bluetooth_printer',
                ),
          ),
          child: SizedBox(
            width: _paperSize.width.toDouble(),
            child: Builder(builder: widget.builder),
          ),
        ),
      ),
    );

    if (widget.containerBuilder != null) {
      return widget.containerBuilder!(context, receipt);
    }

    return Container(
      color: widget.backgroundColor,
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
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  padding: const EdgeInsets.all(24),
                  color: Colors.white,
                  child: receipt,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<bool> print({
    required String address,
    ProgressCallback? onProgress,
    int addFeeds = 0,
    bool keepConnected = false,
    int maxBufferSize = 512,
    int delayTime = 120,
  }) async {
    try {
      var bytes = await getImageBytes();

      ///
      final generator = Generator();
      final reset = generator.reset();

      final imageData = await generator.encode(
        bytes: bytes,
        dotsPerLine: _paperSize.width,
        useImageRaster: true,
      );

      await _initialize(address: address);

      // waiting for printer initialized and buffers cleared
      await Future.delayed(const Duration(milliseconds: 400));

      final additional = _paperSize == PaperSize.mm60
          ? <int>[for (int i = 0; i < addFeeds; i++) ...Commands.carriageReturn]
          : <int>[for (int i = 0; i < addFeeds; i++) ...Commands.lineFeed];

      final printResult = await printBytes(
        keepConnected: true,
        address: address,
        data: Uint8List.fromList([...imageData, ...reset, ...additional]),
        onProgress: onProgress,
        maxBufferSize: maxBufferSize,
        delayTime: delayTime,
      );

      return printResult;
    } catch (e) {
      return false;
    } finally {
      if (!keepConnected) {
        await disconnect(address);
      }
    }
  }

  static Future<bool> _initialize({required String address}) async {
    final isConnected = await connect(address);
    if (!isConnected) {
      return false;
    }

    final generator = Generator();
    final reset = generator.reset();
    return printBytes(
      address: address,
      data: Uint8List.fromList(reset),
      keepConnected: true,
    );
  }

  static Future<bool> printBytes({
    required String address,
    required Uint8List data,

    /// if true, you should manually disconnect the printer after finished
    required bool keepConnected,
    int maxBufferSize = 512,
    int delayTime = 120,
    ProgressCallback? onProgress,
  }) {
    return FlutterBluetoothPrinter.printBytes(
      address: address,
      data: data,
      onProgress: onProgress,
      keepConnected: keepConnected,
      maxBufferSize: maxBufferSize,
      delayTime: delayTime,
    );
  }

  /*
  Get the PNG bytes of the receipt image.
  */
  Future<Uint8List> getImageBytes() async {
    final RenderRepaintBoundary boundary =
        _localKey.currentContext!.findRenderObject() as RenderRepaintBoundary;

    final screenWidth = boundary.size.width;
    double quality = _paperSize.width / screenWidth;

    final image = await boundary.toImage(pixelRatio: quality);

    final byteData = await image.toByteData(format: ImageByteFormat.png);
    var bytes = byteData!.buffer.asUint8List();
    return bytes;
  }

  static Future<bool> disconnect(String address) async {
    return FlutterBluetoothPrinter.disconnect(address);
  }

  static Future<bool> connect(String address) async {
    return FlutterBluetoothPrinter.connect(address);
  }
}
