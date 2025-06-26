import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_printer/flutter_bluetooth_printer_library.dart' hide ReceiptController, PaperSize;
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wincare_modules/features/printer/presentation/pages/shelf_label/border_label_widget.dart';
import 'package:wincare_modules/features/printer/presentation/pages/shelf_label/no_border_label_widget.dart';

import '../../../../../core/theme.dart';
import '../../../data/models/label_type.dart';
import '../../../data/models/printer_model.dart';
import '../../../data/models/shelf_label_item.dart';
import '../../custom_print/custom_prin_progress_dialog.dart';
import '../../custom_print/custom_print.dart';

class ShelfLabelPage extends StatefulWidget {
  const ShelfLabelPage({super.key});

  @override
  State<ShelfLabelPage> createState() => _ShelfLabelPageState();
}

class _ShelfLabelPageState extends State<ShelfLabelPage> {
  final GlobalKey _key = GlobalKey();

  // Change this for your device
  final double devicePpi = 460; // iPhone 16 example
  ReceiptController? controller;
  Printer? printer;
  LabelType? labelType;
  List<ShelfLabelItem> shelfLabelItems = [];

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        labelType = Get.arguments as LabelType?;
      });
      _setupShelfLabelItems();
      final RenderBox box =
          _key.currentContext!.findRenderObject() as RenderBox;
      final size = box.size; // logical pixels

      double widthMm = logicalPixelsToMillimeters(
        context,
        size.width,
        devicePpi,
      );
      double heightMm = logicalPixelsToMillimeters(
        context,
        size.height,
        devicePpi,
      );

      print("Width in mm: $widthMm, Height in mm: $heightMm");
      //setupChannelHandler();
    });
  }

  double logicalPixelsToMillimeters(
    BuildContext context,
    double logicalPixels,
    double ppi,
  ) {
    final dpr = MediaQuery.of(context).devicePixelRatio;
    return (logicalPixels * 25.4) / (ppi * dpr);
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
    fromDate: DateTime(2025, 6, 19),
    toDate: DateTime(2025, 7, 2),
  );

  final items = [
    ShelfLabelItem(
      name: 'ALPENLIEBE Kẹo Mềm H.Dâu 2Chew 73.5g',
      originalPrice: 9000,
      discountedPrice: 1800,
      qrCode: '8935001712435',
      unitOfMeasure: 'G1',
      fromDate: DateTime(2025, 6, 19),
      toDate: DateTime(2025, 7, 2),
    ),
    ShelfLabelItem(
      name: 'ALPENLIEBE Kẹo Mềm H.Dâu 2Chew 73.5g',
      originalPrice: 15900,
      discountedPrice: 18000,
      qrCode: '8935001712435',
      unitOfMeasure: 'G1',
      fromDate: DateTime(2025, 6, 19),
      toDate: DateTime(2025, 7, 2),
    ),
    ShelfLabelItem(
      name: 'ALPENLIEBE Kẹo Mềm H.Dâu 2Chew 73.5g',
      originalPrice: 159000,
      discountedPrice: 1800,
      qrCode: '8935001712435',
      unitOfMeasure: 'G1',
      fromDate: DateTime(2025, 6, 19),
      toDate: DateTime(2025, 7, 2),
    ),
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
      body: Column(
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
                  margin: EdgeInsets.only(bottom: 75),
                  child: Column(
                    children: shelfLabelItems
                        .map((item) => _itemByLabelType(item))
                        .toList(),
                  ),
                );
              },
              onInitialized: (controller) {
                controller.paperSize = PaperSize.mm60;
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
        setState(() {
          shelfLabelItems = [
            ShelfLabelItem(
              title: "KHUYEN MAI",
              name: 'ALPENLIEBE Kẹo Mềm H.Dâu 2Chew 73.5g',
              originalPrice: 9000,
              discountedPrice: 1800,
              qrCode: '8935001712435',
              unitOfMeasure: 'G1',
              fromDate: DateTime(2025, 6, 19),
              toDate: DateTime(2025, 7, 2),
            ),
            ShelfLabelItem(
              title: "KHUYEN MAI",
              name: 'ALPENLIEBE Kẹo Mềm H.Dâu 2Chew 73.5g',
              originalPrice: 15900,
              discountedPrice: 18000,
              qrCode: '8935001712435',
              unitOfMeasure: 'G1',
              fromDate: DateTime(2025, 6, 19),
              toDate: DateTime(2025, 7, 2),
            ),
            ShelfLabelItem(
              title: "KHUYEN MAI",
              name: 'ALPENLIEBE Kẹo Mềm H.Dâu 2Chew 73.5g',
              originalPrice: 159000,
              discountedPrice: 1800,
              qrCode: '8935001712435',
              unitOfMeasure: 'G1',
              fromDate: DateTime(2025, 6, 19),
              toDate: DateTime(2025, 7, 2),
            ),
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
        });
        break;
      case '2':
        setState(() {
          shelfLabelItems = items;
        });
        break;
      default:
        shelfLabelItems = [];
        break;
    }
  }
}
