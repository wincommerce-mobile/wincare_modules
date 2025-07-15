import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bluetooth_printer/flutter_bluetooth_printer.dart'
    hide ReceiptController;
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wincare_modules/app/app_text.dart';
import 'package:wincare_modules/features/printer/data/models/label_type.dart';

import '../../../../../app/app_colors.dart';
import '../../../../../app/app_constants.dart';
import '../../../../../app/app_pages.dart';
import '../../../data/models/printer_model.dart';
import '../../../data/models/product_model.dart';
import '../../../data/models/shelf_label_item.dart';
import '../../custom_print/custom_print_progress_dialog.dart';
import '../../custom_print/custom_print.dart';
import 'border_label_widget.dart';
import 'no_border_label_widget.dart';

class PrintShelfLabelPage extends StatefulWidget {
  const PrintShelfLabelPage({super.key});

  @override
  State<PrintShelfLabelPage> createState() => _PrintShelfLabelPageState();
}

class _PrintShelfLabelPageState extends State<PrintShelfLabelPage> {
  BluetoothDevice? _selectedDevice;
  ReceiptController? controller;
  late LabelType _labelType;
  bool _isLoading = true;
  MProduct? mProduct;
  static final _channel = MethodChannel(AppConstants.printerChannel);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setupChannelHandler();
    });
    final arguments = Get.arguments;
    if (arguments != null && arguments is String) {
      debugPrint("barcode: $arguments");
    }
    setState(() {
      _labelType = _list[0];
    });
  }

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    await getMacAddress();
  }

  Future<void> setupChannelHandler() async {
    try {
      _channel.setMethodCallHandler((call) async {
        print("Received arguments: ${call.arguments}");
        if (call.method == AppConstants.getProductData) {
          final jsonStr = call.arguments as String;
          print("Received ProductData: $jsonStr");
          final Map<String, dynamic> decoded = jsonDecode(jsonStr);
          final product = MProduct.fromJson(decoded);
          setState(() {
            mProduct = product;
            _isLoading = false;
          });
        }
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      print('Error setting up channel handler: $e');
    }

    ///
//     final jsonStr = """
//           {
//   "ProductCode": "PRD001",
//   "ProductName": "Super Widget",
//   "ProductBarcode": "1234567890123",
//   "UnitCode": "PCS",
//   "UnitName": "Piece",
//   "Quantity": 10.5,
//   "QuantityRequire": 12.0,
//   "SAPLineItem": "1001",
//   "CarrierCode": "CR001",
//   "CarrierName": "FastDelivery",
//   "SalePrice": 100000,
//   "PromotionPrice": 90000,
//   "PromotionFrom": "2025-07-01T00:00:00Z",
//   "PromotionTo": "2025-07-31T23:59:59Z",
//   "Sloc": "SL01",
//   "SellPrice": 95000,
//   "LenBarcode": 13,
//   "BuyPrice": 80000.0,
//   "IsAllowDecimal": true,
//   "VATRate": 10,
//   "GroupVAT": 1,
//   "PromotionCode": "PROMO2025",
//   "IsBlockedEarnPoint": false,
//   "Mch3": "CAT01",
//   "Mch3Name": "Electronics",
//   "IsRequiredReason": false,
//   "ReasonId": 0,
//   "ReasonName": "",
//   "ReasonNote": "",
//   "RequestCancelIsWarning": false,
//   "RequestCancelWarningText": "",
//   "Numerator": 1,
//   "Denominator": 1,
//   "SpecPromotionPrice": 88000,
//   "SpecPromotionFrom": "2025-07-10T00:00:00Z",
//   "SpecPromotionTo": "2025-07-20T23:59:59Z",
//   "PLU": "PLU12345",
//   "_strQty": "10.5",
//   "CountryOri": "VN",
//   "CountryOriName": "Vietnam"
// }
//             """;
//     try {
//       Future.delayed(const Duration(seconds: 5), () {
//         final Map<String, dynamic> decoded = jsonDecode(jsonStr);
//         final product = MProduct.fromJson(decoded);
//         setState(() {
//           mProduct = product;
//           _isLoading = false;
//         });
//       });
//     } catch (e) {
//       print("Error parsing JSON: $e");
//     }
  }

  final List<LabelType> _list = [
    LabelType(id: "0", name: "Tem thường", imagePath: "", checked: true),
    LabelType(id: "1", name: "Tem thường có xuất xứ", imagePath: ""),
    LabelType(id: "2", name: "Tem khuyến mại", imagePath: "", isKM: true),
    LabelType(
      id: "3",
      name: "Tem khuyến mại có xuất xứ",
      imagePath: "",
      isKM: true,
    ),
  ];

  void _toggleLabelType(int index) {
    setState(() {
      _labelType = _list[index];
      for (int i = 0; i < _list.length; i++) {
        _list[i].checked = i == index;
      }
    });
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
          _selectedDevice = null;
          prefs.remove("device_address");
          prefs.remove("device_name");
          return;
        } else {
          setState(() {
            _selectedDevice = BluetoothDevice(address: address, name: name);
          });
        }
      } else {
        debugPrint("No printer found in preferences");
      }
    } catch (e) {
      debugPrint("Error retrieving MAC address: $e");
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
            Get.offAndToNamed(AppRoutes.scanProduct);
          },
        ),
        title: const Text(
          'SẢN PHẨM',
          style: TextStyle(
            fontFamily: 'Roboto',
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 22,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () async {
              await _showPrinterDialog(context);
            },
            icon: Image.asset(
              "assets/images/setting.png",
              width: 24,
              height: 24,
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Column(
          children: [
            const SizedBox(height: 6),
            Container(
              //height: 200,
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                border: Border.all(color: Color(0xFFC6142C), width: 1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: CustomReceipt(
                containerBuilder: (context, child) {
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: ClipRect(
                      clipBehavior: Clip.hardEdge,
                      child: FittedBox(
                        fit: BoxFit.fitWidth,
                        child: InteractiveViewer(
                          boundaryMargin: EdgeInsets.zero,
                          clipBehavior: Clip.none,
                          child: Container(child: child),
                        ),
                      ),
                    ),
                  );
                },
                builder: (context) {
                  return _itemByLabelType(
                    ShelfLabelItem(
                      name: mProduct?.productName ?? "",
                      originalPrice: mProduct?.salePrice ?? 0,
                      discountedPrice: mProduct?.promotionPrice ?? 0,
                      qrCode: mProduct?.productBarcode ?? "",
                      unitOfMeasure: mProduct?.unitName ?? "",
                      fromDate: DateTime.parse(mProduct?.promotionFrom ?? "1970-01-01T00:00:00Z"),
                      toDate: DateTime.parse(mProduct?.promotionTo ?? "1970-02-01T00:00:00Z"),
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
            const SizedBox(height: 24),
            Expanded(
              child: ListView.builder(
                itemCount: _list.length,
                itemBuilder: (context, index) {
                  final labelType = _list[index];
                  return InkWell(
                    onTap: () {
                      _toggleLabelType(index);
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 8,
                      ),
                      margin: EdgeInsets.only(bottom: 10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Color(0xFFC6142C), width: 1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          Image.asset(
                            "assets/images/printer.png",
                            width: 23,
                            height: 23,
                            fit: BoxFit.cover,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: AppText(
                              text: labelType.name,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Image.asset(
                            labelType.checked
                                ? "assets/images/checked.png"
                                : "assets/images/uncheck.png",
                            width: 23,
                            height: 23,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 12),
          //height: 44,
          child: Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    Get.offAndToNamed(AppRoutes.scanProduct);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF2F6BFF),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  child: SizedBox(
                    height: 44,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          "assets/images/scanner.png",
                          width: 23,
                          height: 23,
                          color: Colors.white,
                          fit: BoxFit.cover,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          "Quét mã",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Roboto',
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 24),
              Expanded(
                child: ElevatedButton(
                  onPressed: () async {
                    if (_selectedDevice == null) {
                      await _showPrinterDialog(context);
                      return;
                    }

                    if (context.mounted && _selectedDevice != null) {
                      await CustomPrintProgressDialog.print(
                        context,
                        device: _selectedDevice!.address,
                        controller: controller!,
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFC6142C),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  child: SizedBox(
                    height: 44,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          "assets/images/printer.png",
                          width: 23,
                          height: 23,
                          color: Colors.white,
                          fit: BoxFit.cover,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          "In tem",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Roboto',
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _itemByLabelType(ShelfLabelItem label) {
    switch (_labelType.id) {
      /// Border
      case '0':
      case '1':
        return NoBorderLabelWidget(item: label);
      case '2':
      case '3':
        return BorderLabelWidget(item: label);
      default:
        return Text('Unknown label type');
    }
  }

  Future<void> _showPrinterDialog(BuildContext context) async {
    final discoveryStream = FlutterBluetoothPrinter.discovery
        .asBroadcastStream();

    await showDialog(
      context: context,
      builder: (context) {
        int selectedIndex = -1;
        BluetoothDevice? tempSelected = _selectedDevice;
        return StatefulBuilder(
          builder: (context, setState) {
            return Dialog(
              backgroundColor: AppColors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Top Bar
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: const BoxDecoration(
                      color: AppColors.red,
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(16),
                      ),
                    ),
                    height: 50,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Visibility(
                          visible: false,
                          child: GestureDetector(
                            onTap: null,
                            child: const Icon(
                              Icons.close,
                              color: AppColors.white,
                            ),
                          ),
                        ),
                        Expanded(
                          child: const Text(
                            "Chọn máy in",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: 'Roboto',
                              color: AppColors.white,
                              fontWeight: FontWeight.w400,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: const Icon(
                            Icons.close,
                            color: AppColors.white,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  StreamBuilder(
                    stream: discoveryStream,
                    builder: (context, snapshot) {
                      print(snapshot.connectionState.toString());
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const SizedBox(
                          height: 200,
                          child: Center(child: CircularProgressIndicator()),
                        );
                      }

                      final data = snapshot.data;

                      if (data is UnknownState) {
                        return const SizedBox(
                          height: 200,
                          child: Center(child: Text('Unknown Result')),
                        );
                      }

                      final List<BluetoothDevice> devices =
                          data is DiscoveryResult ? data.devices : [];

                      return devices.isEmpty
                          ? const Padding(
                              padding: EdgeInsets.all(16),
                              child: Text(
                                'Không tìm thấy máy in.',
                                style: TextStyle(
                                  fontFamily: 'Roboto',
                                  color: AppColors.black,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16,
                                ),
                              ),
                            )
                          : Container(
                              height: Get.height / 3,
                              padding: EdgeInsets.symmetric(horizontal: 24),
                              child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: devices.length,
                                itemBuilder: (context, index) {
                                  final device = devices[index];
                                  final isSelected =
                                      device.address == tempSelected?.address;
                                  return GestureDetector(
                                    onTap: () {
                                      if (isSelected) {
                                        return;
                                      }
                                      selectedIndex = index;
                                      tempSelected = device;
                                      setState(() {});
                                    },
                                    child: Column(
                                      key: ValueKey(index),
                                      children: [
                                        Row(
                                          children: [
                                            Expanded(
                                              child: Text(
                                                device.name ?? "Unknown",
                                                style: TextStyle(
                                                  fontFamily: 'Roboto',
                                                  color: AppColors.black,
                                                  fontWeight: isSelected
                                                      ? FontWeight.bold
                                                      : FontWeight.w400,
                                                  fontSize: 16,
                                                ),
                                              ),
                                            ),
                                            Image.asset(
                                              isSelected
                                                  ? 'assets/images/radio_selected.png'
                                                  : 'assets/images/radio.png',
                                              width: 24,
                                              height: 24,
                                              fit: BoxFit.cover,
                                            ),
                                          ],
                                        ),
                                        Divider(
                                          height: 20,
                                          thickness: 1,
                                          color: AppColors.black,
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            );
                    },
                  ),

                  const SizedBox(height: 8),
                  // Select Button
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 12,
                    ),
                    child: SizedBox(
                      width: double.infinity,
                      height: 45,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: tempSelected != null
                              ? AppColors.red
                              : Colors.grey,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: tempSelected != null
                            ? () {
                                _selectedDevice = tempSelected;

                                final printer = Printer(
                                  name: tempSelected!.name ?? 'Unknown Printer',
                                  address: tempSelected!.address,
                                );

                                saveMacAddress(printer);
                                Get.back();
                              }
                            : null,
                        child: const Text(
                          "Chọn",
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            color: AppColors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
