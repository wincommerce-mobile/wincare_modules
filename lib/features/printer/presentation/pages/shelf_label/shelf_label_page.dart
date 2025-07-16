import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bluetooth_printer/flutter_bluetooth_printer_library.dart'
    hide ReceiptController, PaperSize;
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wincare_modules/features/printer/presentation/pages/shelf_label/border_label_widget.dart';
import 'package:wincare_modules/features/printer/presentation/pages/shelf_label/no_border_label_widget.dart';

import '../../../../../app/app_constants.dart';
import '../../../../../core/theme.dart';
import '../../../data/models/label_type.dart';
import '../../../data/models/printer_model.dart';
import '../../../data/models/shelf_label_item.dart';
import '../../custom_print/custom_print_progress_dialog.dart';
import '../../custom_print/custom_print.dart';

class ShelfLabelPage extends StatefulWidget {
  const ShelfLabelPage({super.key});

  @override
  State<ShelfLabelPage> createState() => _ShelfLabelPageState();
}

class _ShelfLabelPageState extends State<ShelfLabelPage> {
  final GlobalKey _key = GlobalKey();

  // Change this for your device

  ReceiptController? controller;
  Printer? printer;
  LabelType? labelType;
  List<ShelfLabelItem> shelfLabelItems = [];
  bool _isLoading = true;

  static final _channel = MethodChannel(AppConstants.printerChannel);

  Future<void> setupChannelHandler() async {
    debugPrint("Setting up channel handler");
    try {
      _channel.setMethodCallHandler((call) async {
        if(call.method == AppConstants.onNativeBackPressed) {
          debugPrint("Native back pressed");
          Get.back();
        }
        debugPrint("Received arguments: ${call.arguments}");
        // if (call.method == 'sendItemData') {
        //   final jsonStr = call.arguments as String;
        //   print("Received saleOrder: $jsonStr");
        //   final List decoded = jsonDecode(jsonStr);
        //   final List<ShelfLabelItem> items = decoded
        //       .map((item) => ShelfLabelItem.fromJson(item))
        //       .toList();
        //   setState(() {
        //     shelfLabelItems = items;
        //     _isLoading = false;
        //   });
        // }
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      debugPrint('Error setting up channel handler: $e');
    }
    final jsonStr = """
          [
  {
    "title": "KHUYEN MAI",
    "name": "ALPENLIEBE Kẹo Mềm H.Dâu 2Chew 73.5g",
    "originalPrice": 20200,
    "discountedPrice": 1800,
    "qrCode": "8935001712435",
    "unitOfMeasure": "G1",
    "fromDate": "2025-06-19T00:00:00.000",
    "toDate": "2025-07-02T00:00:00.000"
  },
  {
    "title": "KHUYEN MAI",
    "name": "ALPENLIEBE Kẹo Mềm H.Dâu 2Chew 73.5g",
    "originalPrice": 20200,
    "discountedPrice": 1800,
    "qrCode": "8935001712435",
    "unitOfMeasure": "G1",
    "fromDate": "2025-06-19T00:00:00.000",
    "toDate": "2025-07-02T00:00:00.000"
  }
  ]
            """;
    try {
      Future.delayed(const Duration(seconds: 1), () {
        final List decoded = jsonDecode(jsonStr);
        final List<ShelfLabelItem> items = decoded
            .map((item) => ShelfLabelItem.fromJson(item))
            .toList();
        debugPrint('Decoded items: ${items.length}');
        setState(() {
          shelfLabelItems = items;
          _isLoading = false;
        });
      });
    } catch (e) {
      debugPrint("Error parsing JSON: $e");
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setupChannelHandler();
      setState(() {
        labelType = Get.arguments as LabelType?;
      });
    });
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
    try {
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
    } catch (e) {
      print("Error retrieving MAC address: $e");
    }
  }

  Future<void> _setUpPrinter() async {
    try {
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
    } catch (e) {
      print("Error selecting printer: $e");
    }
  }

  final item = ShelfLabelItem(
    name: 'ALPENLIEBE Kẹo Mềm H.Dâu 2Chew 73.5g',
    originalPrice: 15900,
    discountedPrice: 100,
    qrCode: '8935001712435',
    unitOfMeasure: 'G1',
    fromDate: "2025-06-19T00:00:00.000",
    toDate: "2025-07-02T00:00:00.000",
  );

  /// item with no title (no border item)
  final itemsNoBorder = [
    ShelfLabelItem(
      name: 'ALPENLIEBE Kẹo Mềm H.Dâu 2Chew 73.5g',
      originalPrice: 20200,
      discountedPrice: 1800,
      qrCode: '8935001712435',
      unitOfMeasure: 'G1',
      fromDate: "2025-06-19T00:00:00.000",
      toDate: "2025-07-02T00:00:00.000",
    ),
    // ShelfLabelItem(
    //   name: 'ALPENLIEBE Kẹo Mềm H.Dâu 2Chew 73.5g',
    //   originalPrice: 15900,
    //   discountedPrice: 18000,
    //   qrCode: '8935001712435',
    //   unitOfMeasure: 'G1',
    //   fromDate: DateTime(2025, 6, 19),
    //   toDate: DateTime(2025, 7, 2),
    // ),
    // ShelfLabelItem(
    //   name: 'ALPENLIEBE Kẹo Mềm H.Dâu 2Chew 73.5g',
    //   originalPrice: 159000,
    //   discountedPrice: 1800,
    //   qrCode: '8935001712435',
    //   unitOfMeasure: 'G1',
    //   fromDate: DateTime(2025, 6, 19),
    //   toDate: DateTime(2025, 7, 2),
    // ),
    // ShelfLabelItem(
    //   name: 'ALPENLIEBE Kẹo Mềm H.Dâu 2Chew 73.5g',
    //   originalPrice: 1800000,
    //   discountedPrice: 180000,
    //   qrCode: '8935001712435',
    //   unitOfMeasure: 'G1',
    //   fromDate: DateTime(2025, 6, 19),
    //   toDate: DateTime(2025, 7, 2),
    // ),
  ];

  final itemsBorder = [
    ShelfLabelItem(
      title: "",
      name: 'ALPENLIEBE Kẹo Mềm H.Dâu 2Chew 73.5g',
      originalPrice: 20200,
      discountedPrice: 1800,
      qrCode: '8935001712435',
      unitOfMeasure: 'G1',
      fromDate: "2025-06-19T00:00:00.000",
      toDate: "2025-07-02T00:00:00.000",
    ),
    // ShelfLabelItem(
    //   title: "KHUYEN MAI",
    //   name: 'ALPENLIEBE Kẹo Mềm H.Dâu 2Chew 73.5g',
    //   originalPrice: 15900,
    //   discountedPrice: 18000,
    //   qrCode: '8935001712435',
    //   unitOfMeasure: 'G1',
    //   fromDate: DateTime(2025, 6, 19),
    //   toDate: DateTime(2025, 7, 2),
    // ),
    // ShelfLabelItem(
    //   title: "KHUYEN MAI",
    //   name: 'ALPENLIEBE Kẹo Mềm H.Dâu 2Chew 73.5g',
    //   originalPrice: 159000,
    //   discountedPrice: 1800,
    //   qrCode: '8935001712435',
    //   unitOfMeasure: 'G1',
    //   fromDate: DateTime(2025, 6, 19),
    //   toDate: DateTime(2025, 7, 2),
    // ),
    // ShelfLabelItem(
    //   title: "KHUYEN MAI",
    //   name: 'ALPENLIEBE Kẹo Mềm H.Dâu 2Chew 73.5g',
    //   originalPrice: 1800000,
    //   discountedPrice: 180000,
    //   qrCode: '8935001712435',
    //   unitOfMeasure: 'G1',
    //   fromDate: DateTime(2025, 6, 19),
    //   toDate: DateTime(2025, 7, 2),
    // ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFC6142C),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () {
            Get.back();
          },
        ),
        title: const Text(
          'IN TEM KỆ',
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
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: CustomReceipt(
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
                                child: Container(
                                  //padding: const EdgeInsets.all(6.0),
                                  color: _color(),
                                  child: child,
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                    builder: (context) {
                      return Container(
                        key: _key,
                        //margin: EdgeInsets.only(bottom: 50),
                        child: Column(
                          children: shelfLabelItems
                              .map((item) => _itemByLabelType(item))
                              .toList(),
                        ),
                      );
                    },
                    onInitialized: (controller) {
                      controller.paperSize = MyPaperSize.mm60;
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
                                CustomPrintProgressDialog.print(
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

  Color _color() {
    if (labelType == null) {
      return Colors.white;
    }
    switch (labelType!.id) {
      /// Red
      case '1':
        return Colors.red;
      case '2':
        return Colors.white;
      default:
        return Colors.white;
    }
  }

  Widget _itemByLabelType(ShelfLabelItem label) {
    if (labelType == null) {
      return Text('No label type selected');
    }
    switch (labelType!.id) {
      /// Border
      case '1':
        return BorderLabelWidget(item: label);
      case '2':
        return NoBorderLabelWidget(item: label);
      default:
        return Text('Unknown label type');
    }
  }

  void _setupShelfLabelItems() {
    if (labelType == null) {
      shelfLabelItems = [];
      return;
    }

    ///
    switch (labelType!.id) {
      /// Border
      case '1':
        _setItems(itemsBorder);
        break;
      case '2':
        _setItems(itemsNoBorder);
        break;
      default:
        _setItems([]);
        break;
    }
  }

  void _setItems(List<ShelfLabelItem> items) {
    setState(() {
      shelfLabelItems = items;
    });
  }
}
