import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wincare_modules/app/app_secure_storage.dart';

import '../../../app/app_constants.dart';
import '../domain/entities/user_entity.dart';
import 'widgets/loading_indicator.dart';

class CaptureController extends GetxController {
  static final _channel = MethodChannel(AppConstants.captureChannel);

  /// Reason
  var selectedReason = Rxn<String>();
  var reasons = RxList<String>(['Apple', 'Banana', 'Cherry', 'Mango']);

  var banners = RxList<MyImage>([
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
  ]);

  var images = RxList<MyImage>([]);
  var currentImage = 0.obs;
  final ImagePicker _picker = ImagePicker();

  void updateCurrentImage(int index) {
    currentImage.value = index;
  }

  void onDeleteImageInList(int index) {
    images.removeAt(index);
    images.refresh();
  }

  void onUpdateImageInList(int index) async {
    final newPath = await replacePicture();
    if (newPath != null) {
      images[index] = MyImage(url: null, path: newPath);
      images.refresh();
    }
  }

  void onAddNewImage(XFile image) {
    images.add(MyImage(url: null, path: image));
    images.refresh();
    updateCurrentImage(images.length - 1);
  }

  Future<XFile?> replacePicture() async {
    final XFile? image = await _picker.pickImage(
      source: ImageSource.camera,
      preferredCameraDevice: CameraDevice.rear,
    );
    if (image != null) {
      /// Send this image to server and get the url back
      return image;
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
      onAddNewImage(image);
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

class MyImage {
  final String? url;
  final XFile? path;

  MyImage({required this.url, required this.path});
}
