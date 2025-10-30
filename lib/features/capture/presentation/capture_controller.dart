import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wincare_modules/app/app_extensions.dart';
import 'package:wincare_modules/app/app_secure_storage.dart';
import 'package:wincare_modules/features/capture/data/request/employee_overview_request.dart';
import 'package:wincare_modules/features/capture/presentation/widgets/loading_indicator.dart';

import '../../../app/app_colors.dart';
import '../../../app/app_constants.dart';
import '../domain/entities/user_entity.dart';
import '../domain/usecases/get_employee_overview_use_case.dart';
import 'widgets/common_dialog.dart';

class CaptureController extends GetxController {
  GetEmployeeOverviewUseCase getEmployeeOverviewUseCase;

  CaptureController({required this.getEmployeeOverviewUseCase});

  static final _channel = MethodChannel(AppConstants.captureChannel);

  /// Reason
  var selectedReason = Rxn<String>();
  var reasons = RxList<String>(['Apple', 'Banana', 'Cherry', 'Mango']);

  final PageController pageController = PageController();

  void onPageChanged(pageIndex) {
    /// deselect all zones
    for (var i = 0; i < imageZones.length; i++) {
      imageZones[i] = imageZones[i].copyWith(selected: false);
    }

    /// select current zone
    imageZones[pageIndex] = imageZones[pageIndex].copyWith(selected: true);
    imageZones.refresh();
    pageController.jumpToPage(pageIndex);
  }

  var imageZones = RxList<ImageZone>([]);

  Future<void> onDeletePicTure(int zoneIndex, imageIndex) async {
    var imgZone = imageZones[zoneIndex];
    imgZone.myImages.removeAt(imageIndex);
    imageZones[zoneIndex] = imgZone.copyWith(myImages: imgZone.myImages);
    imageZones.refresh();
  }

  Future<void> onTakePicTure(int zoneIndex) async {
    final image = await _takePicture();
    if (image != null) {
      showLoadingIndicator();
      final address = await _getAddressFromLocation();
      final takenDate = DateTime.now().toAppDateTimeFormat();
      hideLoadingIndicator();
      var imgZone = imageZones[zoneIndex];
      imgZone.myImages.add(
        MyImage(url: null, path: image, address: address, takenDate: takenDate),
      );
      imageZones[zoneIndex] = imgZone.copyWith(myImages: imgZone.myImages);
      imageZones.refresh();
    }
  }

  Future<XFile?> _takePicture() async {
    final XFile? image = await ImagePicker().pickImage(
      source: ImageSource.camera,
      preferredCameraDevice: CameraDevice.rear,
    );

    return image;
  }

  /// Reason
  void setSelectedReason(String? reason) {
    selectedReason.value = reason;
  }

  ///

  Future<void> setupChannelHandler() async {
    _channel.setMethodCallHandler((call) async {
      debugPrint("Received arguments: ${call.arguments}");
      try {
        showLoadingIndicator();
        switch (call.method) {
          case AppConstants.getRequestData:
            final jsonStr = call.arguments as String;
            debugPrint("Received getRequestData: $jsonStr");
            final Map<String, dynamic> decoded = jsonDecode(jsonStr);
            final userEntity = UserEntity.fromJson(decoded);
            await AppSecureStorage.saveUser(userEntity);
            getEmployeeOverview();
            hideLoadingIndicator();
            break;
          case AppConstants.onNativeBackPressed:
            if (Get.context != null) {
              showWarningDialog(
                context: Get.context!,
                message: 'Vui lòng xác nhận kết quả',
              );
            }
            break;
          default:
            hideLoadingIndicator();
            break;
        }
      } catch (e) {
        hideLoadingIndicator();
        debugPrint('Error setting up channel handler: $e');
      }
    });
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.',
      );
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }

  Future<String?> _getAddressFromLocation() async {
    try {
      Position position = await _determinePosition();
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );
      if (placemarks.isNotEmpty) {
        Placemark place = placemarks[0];
        debugPrint('_getAddressFromLocation: ${place.toJson()}');
        return "${place.street}, ${place.subAdministrativeArea}, ${place.administrativeArea}, ${place.country}";
      } else {
        debugPrint('No address found for this location');
        return null;
      }
    } catch (e) {
      debugPrint('Error get address from location: $e');
      return null;
    }
  }

  Future<void> setupPageView() async {
    final zones = [
      ImageZone(
        zoneId: 1,
        zoneName: 'Zone chính',
        required: true,
        selected: true,
        sampleImages: [
          MyImage(
            url:
                'https://xebangphan.vn/wp-content/uploads/2024/06/ha-giang-mua-he-2.jpg',
            path: null,
          ),
          MyImage(
            url:
                'https://xebangphan.vn/wp-content/uploads/2024/06/ha-giang-mua-he-2.jpg',
            path: null,
          ),
        ],
        myImages: [
          MyImage(
            url:
                'https://xebangphan.vn/wp-content/uploads/2024/06/ha-giang-mua-he-2.jpg',
            path: null,
          ),
        ],
        result: ImageResult(
          status: MyImageStatus.processing,
          name: 'AI chấm',
          resultDate: '16/10/2025 11:33',
        ),
      ),
      ImageZone(
        zoneId: 2,
        zoneName: 'Zone phụ 2',
        required: false,
        sampleImages: [
          MyImage(
            url:
                'https://xebangphan.vn/wp-content/uploads/2024/06/ha-giang-mua-he-2.jpg',
            path: null,
          ),
          MyImage(
            url:
                'https://xebangphan.vn/wp-content/uploads/2024/06/ha-giang-mua-he-2.jpg',
            path: null,
          ),
        ],
        myImages: [
          MyImage(
            url:
                'https://xebangphan.vn/wp-content/uploads/2024/06/ha-giang-mua-he-2.jpg',
            path: null,
          ),
        ],
        result: ImageResult(
          status: MyImageStatus.verified,
          name: 'AI chấm',
          resultDate: '16/10/2025 11:33',
        ),
      ),
      ImageZone(
        zoneId: 3,
        zoneName: 'Zone phụ 3',
        required: true,
        sampleImages: [
          MyImage(
            url:
                'https://xebangphan.vn/wp-content/uploads/2024/06/ha-giang-mua-he-2.jpg',
            path: null,
          ),
          MyImage(
            url:
                'https://xebangphan.vn/wp-content/uploads/2024/06/ha-giang-mua-he-2.jpg',
            path: null,
          ),
        ],
        myImages: [
          MyImage(
            url:
                'https://xebangphan.vn/wp-content/uploads/2024/06/ha-giang-mua-he-2.jpg',
            path: null,
          ),
        ],
        result: ImageResult(
          status: MyImageStatus.failed,
          name: 'AI chấm',
          resultDate: '16/10/2025 11:33',
        ),
      ),
      ImageZone(
        zoneId: 4,
        zoneName: 'Zone phụ 4',
        required: false,
        sampleImages: [
          MyImage(
            url:
                'https://xebangphan.vn/wp-content/uploads/2024/06/ha-giang-mua-he-2.jpg',
            path: null,
          ),
          MyImage(
            url:
                'https://xebangphan.vn/wp-content/uploads/2024/06/ha-giang-mua-he-2.jpg',
            path: null,
          ),
        ],
        myImages: [],
        result: ImageResult(
          status: MyImageStatus.created,
          name: 'AI chấm',
          resultDate: '16/10/2025 11:33',
        ),
      ),
    ];
    imageZones.value = zones;
  }

  void getEmployeeOverview() async {
    final user = await AppSecureStorage.getUser();
    final rq = EmployeeOverviewRequest(
      userId: user?.userId,
      userName: user?.displayName,
      siteId: user?.siteId,
      employeeCode: user?.employeeCode,
    );
    final result = await getEmployeeOverviewUseCase.call(rq);
    debugPrint('getEmployeeOverview: ${result.employeeCode}');
    debugPrint('getEmployeeOverview: ${result.banners.length}');
  }

  @override
  void onInit() {
    super.onInit();
    setupPageView();
  }
}

class ImageZone {
  final int zoneId;
  final String zoneName;
  final bool required;
  final List<MyImage> sampleImages;
  final List<MyImage> myImages;
  final ImageResult result;
  bool selected;

  ImageZone({
    required this.zoneId,
    required this.zoneName,
    required this.required,
    required this.sampleImages,
    required this.myImages,
    required this.result,
    this.selected = false,
  });

  copyWith({
    int? zoneId,
    String? zoneName,
    bool? required,
    List<MyImage>? sampleImages,
    List<MyImage>? myImages,
    ImageResult? result,
    bool? selected,
  }) {
    return ImageZone(
      zoneId: zoneId ?? this.zoneId,
      zoneName: zoneName ?? this.zoneName,
      required: required ?? this.required,
      sampleImages: sampleImages ?? this.sampleImages,
      myImages: myImages ?? this.myImages,
      result: result ?? this.result,
      selected: selected ?? this.selected,
    );
  }
}

enum MyImageStatus {
  created(name: 'Mới tạo', color: AppColors.black4D),
  processing(name: 'Chờ kết quả chấm', color: Color(0xFFE7B400)),
  verified(name: 'Đạt', color: Color(0xFF3A73FF)),
  failed(name: 'Rớt', color: AppColors.red);

  const MyImageStatus({required this.name, required this.color});

  final String name;
  final Color color;
}

class ImageResult {
  final MyImageStatus status;
  final String name;
  final String resultDate;

  ImageResult({
    required this.status,
    required this.name,
    required this.resultDate,
  });

  copyWith({MyImageStatus? status, String? name, String? resultDate}) {
    return ImageResult(
      status: status ?? this.status,
      name: name ?? this.name,
      resultDate: resultDate ?? this.resultDate,
    );
  }
}

class MyImage {
  final String? url;
  final XFile? path;
  final String? address;
  final String? takenDate;
  final bool isHandled;

  MyImage({
    required this.url,
    required this.path,
    this.isHandled = false,
    this.address,
    this.takenDate,
  });

  copyWith({String? url, String? address, XFile? path, bool? isHandled}) {
    return MyImage(
      url: url ?? this.url,
      address: address ?? this.address,
      takenDate: takenDate,
      path: path ?? this.path,
      isHandled: isHandled ?? this.isHandled,
    );
  }
}
