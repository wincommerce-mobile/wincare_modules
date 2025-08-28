import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bluetooth_printer/flutter_bluetooth_printer.dart'
    hide ReceiptController;
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wincare_modules/app/app_text.dart';
import 'package:wincare_modules/features/printer/data/models/label_type.dart';
import 'package:wincare_modules/features/printer/presentation/pages/shelf_label/shelf_label_item_mapper.dart';

import '../../../../../app/app_colors.dart';
import '../../../../../app/app_constants.dart';
import '../../../../../app/app_enum.dart';
import '../../../data/models/printer_model.dart';
import '../../../data/models/product_model.dart';
import '../../../data/models/shelf_label_item.dart';
import '../../custom_print/custom_print.dart';
import '../../custom_print/custom_print_progress_dialog.dart';
import 'tem_ke/border_label_widget.dart';
import 'tem_ke/no_border_label_widget.dart';
import 'tem_ke/tem_hoi_vien.dart';

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
  MProduct? _product;
  static final _channel = MethodChannel(AppConstants.printerChannel);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setupChannelHandler();
      //dummyDataTest();
    });
    final arguments = Get.arguments;
    if (arguments != null && arguments is String) {
      debugPrint("barcode: $arguments");
    }
    setState(() {
      _labelType = _allLabels[0];
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
        debugPrint("Received arguments: ${call.arguments}");
        if (call.method == AppConstants.getProductData) {
          /// reset product
          _product = null;
          _filteredLabels = [];
          _labelType = _allLabels[0];
          for (var label in _allLabels) {
            label.checked = false;
          }
          final jsonStr = call.arguments as String;
          debugPrint("Received ProductData: $jsonStr");
          final Map<String, dynamic> decoded = jsonDecode(jsonStr);
          final product = MProduct.fromJson(decoded);
          _product = product;
          _isLoading = false;
          if (product.isSpecPromotionPrice()) {
            final specPromotionLabels = _allLabels
                .where(
                  (label) =>
              (label.labelType == LabelTypeEnum.temHoiVien ||
                  label.labelType == LabelTypeEnum.temHoiVienCoXuatXu),
            )
                .toList();
            _filteredLabels.addAll(specPromotionLabels);
          }
          if (product.isPromotion()) {
            final promotionLabels = _allLabels
                .where(
                  (label) =>
              (label.labelType == LabelTypeEnum.temKhuyenMai ||
                  label.labelType == LabelTypeEnum.temKhuyenMaiCoXuatXu),
            )
                .toList();
            _filteredLabels.addAll(promotionLabels);
          } else {
            final labels = _allLabels
                .where(
                  (label) =>
              (label.labelType == LabelTypeEnum.temThuong ||
                  label.labelType == LabelTypeEnum.temThuongCoXuatXu),
            )
                .toList();
            _filteredLabels.addAll(labels);
          }
          _labelType = _filteredLabels[0];
          _labelType.checked = true;
          setState(() {});
        }
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      debugPrint('Error setting up channel handler: $e');
    }
  }

  Future<void> dummyDataTest() async {
    final jsonStr = """
                 {
  "BuyPrice": 42218,
  "Mch3Name": "Thực phẩm khô",
  "PromotionFrom": "20250718",
  "LenBarcode": 13,
  "PromotionPrice": "39.900",
  "ProductName": "NAM NGƯ Nước Mắm Nhãn Vàng Vàng 650ml",
  "SpecPromotionPrice": "39.900",
  "SpecPromotionTo": "20250801",
  "SpecPromotionFrom": "20250726",
  "PLU": "",
  "UnitCode": "CHA",
  "CountryOriName": "Việt Nam",
  "Mch3": "10206",
  "ReasonId": 0,
  "GroupVAT": 6,
  "QuantityRequire": 0,
  "RequestCancelWarningText": "",
  "Numerator": 1,
  "PromotionCode": "2300669958",
  "CountryOri": "VN",
  "IsBlockedEarnPoint": true,
  "IsAllowDecimal": false,
  "IsRequiredReason": false,
  "_strQty": "0",
  "SellPrice": 39900,
  "ProductCode": "000000000010602829",
  "Quantity": 0,
  "UnitName": "CHA",
  "SalePrice": "512000000 đ",
  "Denominator": 1,
  "PromotionTo": "20250730",
  "VATRate": 8,
  "RequestCancelIsWarning": false,
  "ProductBarcode": "8936017369231"
}

                    """;
    try {
      Future.delayed(const Duration(seconds: 3), () {
        _product = null;
        _filteredLabels = [];
        _labelType = _allLabels[0];
        for (var label in _allLabels) {
          label.checked = false;
        }
        final Map<String, dynamic> decoded = jsonDecode(jsonStr);
        final product = MProduct.fromJson(decoded);

        _product = product;
        _isLoading = false;
        if (product.isSpecPromotionPrice()) {
          final specPromotionLabels = _allLabels
              .where(
                (label) =>
                    (label.labelType == LabelTypeEnum.temHoiVien ||
                    label.labelType == LabelTypeEnum.temHoiVienCoXuatXu),
              )
              .toList();
          _filteredLabels.addAll(specPromotionLabels);
        }
        if (product.isPromotion()) {
          final promotionLabels = _allLabels
              .where(
                (label) =>
                    (label.labelType == LabelTypeEnum.temKhuyenMai ||
                    label.labelType == LabelTypeEnum.temKhuyenMaiCoXuatXu),
              )
              .toList();
          _filteredLabels.addAll(promotionLabels);
        } else {
          final labels = _allLabels
              .where(
                (label) =>
                    (label.labelType == LabelTypeEnum.temThuong ||
                    label.labelType == LabelTypeEnum.temThuongCoXuatXu),
              )
              .toList();
          _filteredLabels.addAll(labels);
        }
        _labelType = _filteredLabels[0];
        _labelType.checked = true;
        setState(() {});
      });
    } catch (e) {
      debugPrint("Error parsing JSON: $e");
    }
  }

  List<LabelType> _filteredLabels = [];
  final List<LabelType> _allLabels = [
    LabelType(
      id: "0",
      name: "Tem thường",
      imagePath: "",
      labelType: LabelTypeEnum.temThuong,
    ),
    LabelType(
      id: "1",
      name: "Tem thường có xuất xứ",
      imagePath: "",
      labelType: LabelTypeEnum.temThuongCoXuatXu,
    ),
    LabelType(
      id: "2",
      name: "Tem khuyến mại",
      imagePath: "",
      labelType: LabelTypeEnum.temKhuyenMai,
    ),
    LabelType(
      id: "3",
      name: "Tem khuyến mại có xuất xứ",
      labelType: LabelTypeEnum.temKhuyenMaiCoXuatXu,
      imagePath: "",
    ),
    LabelType(
      id: "4",
      name: "Tem hội viên",
      labelType: LabelTypeEnum.temHoiVien,
      imagePath: "",
    ),
    LabelType(
      id: "5",
      name: "Tem hội viên có xuất xứ",
      labelType: LabelTypeEnum.temHoiVienCoXuatXu,
      imagePath: "",
    ),
  ];

  void _toggleLabelType(int index) {
    setState(() {
      _labelType = _filteredLabels[index];
      for (int i = 0; i < _filteredLabels.length; i++) {
        _filteredLabels[i].checked = i == index;
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

  static Future<void> _triggerNativeBack() async {
    try {
      await _channel.invokeMethod(AppConstants.onBack);
    } catch (e) {
      print('Error calling native back: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFC6142C),
        centerTitle: true,
        leading: InkWell(
          onTap: () async {
            await _triggerNativeBack();
          },
          child: Padding(
            padding: const EdgeInsets.all(21),
            child: Image.asset(
              "assets/images/icon_back.png",
              fit: BoxFit.contain,
            ),
          ),
        ),
        title: const Text(
          'SẢN PHẨM',
          style: TextStyle(
            fontFamily: 'Roboto',
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 18,
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
            CustomReceipt(
              defaultTextStyle: TextStyle(fontFamily: 'Roboto'),
              containerBuilder: (context, child) {
                return ClipRect(
                  clipBehavior: Clip.hardEdge,
                  child: FittedBox(
                    fit: BoxFit.fitWidth,
                    child: InteractiveViewer(
                      boundaryMargin: EdgeInsets.zero,
                      clipBehavior: Clip.none,
                      child: Container(child: child),
                    ),
                  ),
                );
              },
              builder: (context) {
                return Container(
                  // decoration: BoxDecoration(
                  //   color: Colors.white,
                  //   border: Border.all(color: Colors.black, width: 1),
                  // ),
                  // padding: EdgeInsets.all(6),
                  child: _itemByLabelType(
                    ShelfLabelItemMapper.toShelfLabelItem(_product),
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
            const SizedBox(height: 24),
            Expanded(
              child: ListView.builder(
                itemCount: _filteredLabels.length,
                itemBuilder: (context, index) {
                  final labelType = _filteredLabels[index];
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
                    _triggerNativeBack();
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
    switch (_labelType.labelType) {
      case LabelTypeEnum.temThuong:
      case LabelTypeEnum.temThuongCoXuatXu:
        return NoBorderLabelWidget(
          item: label,
          isTemCoXuatXu:
              _labelType.labelType == LabelTypeEnum.temThuongCoXuatXu,
        );
      case LabelTypeEnum.temKhuyenMai:
      case LabelTypeEnum.temKhuyenMaiCoXuatXu:
        return BorderLabelWidget(
          item: label,
          isTemCoXuatXu:
              _labelType.labelType == LabelTypeEnum.temKhuyenMaiCoXuatXu,
        );
      case LabelTypeEnum.temHoiVien:
      case LabelTypeEnum.temHoiVienCoXuatXu:
        return TemHoiVien(
          item: label,
          isTemCoXuatXu:
              _labelType.labelType == LabelTypeEnum.temHoiVienCoXuatXu,
        );
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
