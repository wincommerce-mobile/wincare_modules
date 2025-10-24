import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wincare_modules/app/app_secure_storage.dart';
import 'package:wincare_modules/features/capture/presentation/widgets/common_dialog.dart';

import '../../../app/app_constants.dart';
import '../domain/entities/user_entity.dart';
import 'widgets/loading_indicator.dart';

class CaptureController extends GetxController {
  static final _channel = MethodChannel(AppConstants.captureChannel);

  /// Reason
  var selectedReason = Rxn<String>();
  var reasons = RxList<String>(['Apple', 'Banana', 'Cherry', 'Mango']);

  var allowMultiImage = false.obs;

  var banners = RxList<String>([
    'https://xebangphan.vn/wp-content/uploads/2024/06/ha-giang-mua-he-2.jpg',
    'https://xebangphan.vn/wp-content/uploads/2024/06/ha-giang-mua-he-2.jpg',
  ]);

  var images = RxList<String>([]);

  final sampleImage =
      'https://xebangphan.vn/wp-content/uploads/2024/06/ha-giang-mua-he-2.jpg';

  var singleImage = Rxn<String>();

  final ImagePicker _picker = ImagePicker();

  void toggleSwitch(bool val) {
    /// current is allow multi
    if (allowMultiImage.value) {
      switch (images.length) {
        case 0:

          /// turn off
          allowMultiImage.value = val;
          break;
        case 1:
          singleImage.value = images[0];
          images.clear();

          /// turn off
          allowMultiImage.value = val;
          break;
        default:
          showWarningDialog(
            context: Get.context!,
            message:
                'Vui lòng chỉ giữ lại 1 hình nếu muốn quay về chấm hình đơn',
          );

          /// -> show popup
          break;
      }
    } else {
      /// turn on
      allowMultiImage.value = val;

      /// Add single image to multi
      if (singleImage.value != null) {
        images.add(singleImage.value!);
        singleImage.value = null;
      }
    }
  }

  void onDeleteSingleImage() {
    singleImage.value = null;
  }

  void onDeleteImageInList(int index) {
    images.removeAt(index);
    images.refresh();
  }

  void onUpdateImageInList(int index) async {
    final newUrl = await replacePicture();
    if (newUrl != null) {
      images[index] = newUrl;
      images.refresh();
    }
  }

  void onAddNewImage(String url) {
    if (allowMultiImage.value) {
      images.add(url);
      images.refresh();
    } else {
      singleImage.value = url;
    }
  }

  Future<String?> replacePicture() async {
    final XFile? image = await _picker.pickImage(
      source: ImageSource.camera,
      preferredCameraDevice: CameraDevice.rear,
    );
    if (image != null) {
      /// Send this image to server and get the url back
      return sampleImage;
    } else {
      return null;
    }
  }

  Future<void> takePicture() async {
    final XFile? image = await _picker.pickImage(
      source: ImageSource.camera,
      preferredCameraDevice: CameraDevice.rear,
    );

    if (image != null) {
      /// Send this image to server and get the url back
      onAddNewImage(sampleImage);
    } else {
      debugPrint('No image captured');
    }
  }

  /// Reason
  void setSelectedReason(String? reason) {
    selectedReason.value = reason;
  }

  ///

  Future<void> setupChannelHandler() async {
    try {
      showLoadingIndicator();
      _channel.setMethodCallHandler((call) async {
        debugPrint("Received arguments: ${call.arguments}");
        if (call.method == AppConstants.getRequestData) {
          final jsonStr = call.arguments as String;
          debugPrint("Received getRequestData: $jsonStr");
          final Map<String, dynamic> decoded = jsonDecode(jsonStr);
          final userEntity = UserEntity.fromJson(decoded);
          await AppSecureStorage.saveUser(userEntity);
          hideLoadingIndicator();
        }
      });
    } catch (e) {
      hideLoadingIndicator();

      debugPrint('Error setting up channel handler: $e');
    }
  }

  @override
  void onInit() async {
    super.onInit();
    //await setupChannelHandler();

    ///
  }
}
