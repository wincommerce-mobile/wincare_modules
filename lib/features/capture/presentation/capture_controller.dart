import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wincare_modules/app/app_extensions.dart';
import 'package:wincare_modules/app/app_secure_storage.dart';
import 'package:wincare_modules/features/capture/data/request/image_template_request.dart';
import 'package:wincare_modules/features/capture/domain/entities/capture/complaint_reason_entity.dart';
import 'package:wincare_modules/features/capture/domain/entities/request_data_model.dart';
import 'package:wincare_modules/features/capture/domain/usecases/get_image_template_use_case.dart';
import 'package:wincare_modules/features/capture/domain/usecases/get_promotion_aiv_complaint_reason_use_case.dart';
import 'package:wincare_modules/features/capture/domain/usecases/promotion_aiv_complaint_use_case.dart';
import 'package:wincare_modules/features/capture/domain/usecases/sampling_cancel_image_use_case.dart';
import 'package:wincare_modules/features/capture/domain/usecases/sampling_confirm_image_use_case.dart';
import 'package:wincare_modules/features/capture/domain/usecases/sampling_upload_image_use_case.dart';
import 'package:wincare_modules/features/capture/presentation/widgets/loading_indicator.dart';
import 'package:wincare_modules/features/capture/presentation/widgets/snack_bar.dart';

import '../../../app/app_colors.dart';
import '../../../app/app_constants.dart';
import '../../../app/app_enum.dart';
import '../data/request/complaint_reason_request.dart';
import '../data/request/sampling_upload_image_request.dart';
import '../domain/entities/base/base_error_entity.dart';
import '../domain/entities/capture/image_template_entity.dart';
import '../domain/usecases/sampling_result_image_garniture.dart';
import '../domain/usecases/sampling_sent_approval_image_use_case.dart';
import 'common/capture_method_channel.dart';
import 'widgets/common_dialog.dart';
import 'zone_controller.dart';

class CaptureController extends GetxController {
  /// Lấy bộ hình mẫu
  final GetImageTemplateUseCase getImageTemplateUseCase;

  /// Lý do khiếu nại
  final GetPromotionAivComplaintReasonUseCase
  getPromotionAivComplaintReasonUseCase;

  /// Chụp & Upload hình lên server
  final SamplingUploadImageUseCase samplingUploadImageUseCase;

  /// Xoá hình
  final SamplingCancelImageUseCase samplingCancelImageUseCase;

  /// Xác nhận bộ hình
  final SamplingConfirmImageUseCase samplingConfirmImageUseCase;

  /// Khiếu nại kết quá
  final PromotionAivComplaintUseCase promotionAivComplaintUseCase;

  /// Lấy kết quả
  final SamplingResultImageGarniture samplingResultImageGarniture;

  /// Gửi Chấm hình
  final SamplingSentApprovalImageUseCase samplingSentApprovalImageUseCase;

  CaptureController({
    required this.getImageTemplateUseCase,
    required this.getPromotionAivComplaintReasonUseCase,
    required this.samplingUploadImageUseCase,
    required this.samplingCancelImageUseCase,
    required this.samplingConfirmImageUseCase,
    required this.promotionAivComplaintUseCase,
    required this.samplingResultImageGarniture,
    required this.samplingSentApprovalImageUseCase,
  });

  static final _channel = MethodChannel(AppConstants.captureChannel);

  /// Reason
  var selectedReason = Rxn<ComplaintReasonEntity>();
  var reasons = RxList<ComplaintReasonEntity>([]);

  final PageController pageController = PageController();
  final zoneControllers = <ZoneController>[].obs;

  final _requestData = Rxn<RequestDataModel>();

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

  var imageZones = RxList<ImageTemplateEntity>([]);

  Future<void> onDeletePicTure(int zoneIndex, imageIndex) async {
    var imgZone = imageZones[zoneIndex];
    final result = await _deleteImage(
      imgZone.sampleImages[imageIndex].url,
      imgZone.planogramCode,
    );
    if (result) {
      imgZone.sampleImages.removeAt(imageIndex);
      imageZones[zoneIndex] = imgZone.copyWith(
        sampleImages: imgZone.sampleImages,
      );
      imageZones.refresh();
    } else {
      Get.back();
    }
  }

  Future<void> onTakePicTure(int zoneIndex) async {
    final image = await _takePicture();
    if (image != null) {
      var imgZone = imageZones[zoneIndex];
      //showLoadingIndicator();
      final result = await _uploadImage(
        await image.readAsBytes(),
        imgZone.planogramCode,
      );
      if (result != null && result.isNotEmpty) {
        final address = await _getAddressFromLocation();
        final takenDate = DateTime.now().toAppDateTimeFormat();
        //hideLoadingIndicator();

        imgZone.sampleImages.add(
          SampleImageEntity(
            url: result,
            path: null,
            address: address,
            takenDate: takenDate,
          ),
        );
        imageZones[zoneIndex] = imgZone.copyWith(
          sampleImages: imgZone.sampleImages,
        );
        imageZones.refresh();
      }
    }
  }

  Future<void> onUpdateResult(int zoneIndex, ImageResult result) async {
    var imgZone = imageZones[zoneIndex];
    imageZones[zoneIndex] = imgZone.copyWith(result: result);
    imageZones.refresh();
  }

  Future<XFile?> _takePicture() async {
    final XFile? image = await ImagePicker().pickImage(
      source: ImageSource.camera,
      preferredCameraDevice: CameraDevice.rear,
    );

    return image;
  }

  /// Reason
  void setSelectedReason(ComplaintReasonEntity? reason) {
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
            final requestData = RequestDataModel.fromJson(decoded);
            await AppSecureStorage.saveRequestData(requestData);
            _requestData.value = await AppSecureStorage.getRequestData();
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

  Future<ImageResult> _getImageResultFromServer(int zoneIndex) async {
    // call get result API for the zone
    // e.g. final res = await getImageResultUseCase.call(GetImageResultRequest(...));
    // return res;
    throw UnimplementedError('Implement image result fetch from server');
  }

  Future<void> _submitImageToServer(
    int zoneIndex,
    SampleImageEntity image,
  ) async {
    // call upload/process API for the zone/image
    // e.g. await processImageUseCase.call(ProcessImageRequest(...));
    // after sending, the backend will report processing state -> ZoneController will poll _fetchZoneResultFromServer
    throw UnimplementedError('Implement image submit to server');
  }

  /// =========================== API call Zone ===========================//
  Future<void> _getImageTemplates() async {
    try {
      showLoadingIndicator();
      final request = ImageTemplateRequest();
      final result = await getImageTemplateUseCase.call(request);
      imageZones.value = result;
      if (imageZones.isNotEmpty) {
        imageZones[0] = imageZones[0].copyWith(selected: true);
        imageZones.refresh();
      }
      for (var zone in result) {
        final zc = ZoneController(
          zoneId: zone.planogramId!,
          samplingResultImageGarnitureUseCase: samplingResultImageGarniture,
          samplingSentApprovalImageUseCase: samplingSentApprovalImageUseCase,
          promotionAivComplaintUseCase: promotionAivComplaintUseCase,
          getPromotionAivComplaintReasonUseCase:
              getPromotionAivComplaintReasonUseCase,
        );
        // if zone already has a processing state, start polling
        if (zone.result?.status == MyImageStatus.processing) {
          zc.startPolling();
        }
        zoneControllers.add(zc);
      }
      hideLoadingIndicator();
    } on BaseErrorEntity catch (error) {
      if (error.statusCode == 1002) {
        await CaptureMethodChannel.logOut();
        hideLoadingIndicator();
        return;
      }
      hideLoadingIndicator();
      showSnackBar(description: error.message ?? '');
    }
  }

  Future<String?> _uploadImage(Uint8List bytes, String? planogramCode) async {
    final requestData = _requestData.value;
    try {
      showLoadingIndicator();
      final request = SamplingUploadImageRequest(
        userId: requestData?.userId,
        userName: requestData?.displayName,
        employeeCode: requestData?.employeeCode,
        siteId: requestData?.siteId,
        imageGarnitureId: requestData?.imageGarnitureId,
        planogramCode: planogramCode,
        imageType: ImageType.sampling,
        img: base64Encode(bytes),
        urlImg: null,
        fileName: null,
        fileExtension: FileExtension.jpeg.type,
      );
      final result = await samplingUploadImageUseCase.call(request);
      debugPrint("_uploadImage: ${result.systemMessage}");
      hideLoadingIndicator();

      /// Image url
      return result.systemMessage;
    } on BaseErrorEntity catch (error) {
      if (error.statusCode == 1002) {
        hideLoadingIndicator();
        showSnackBar(description: error.message ?? '');
        await CaptureMethodChannel.logOut();
        return null;
      }
      hideLoadingIndicator();
      showSnackBar(description: error.message ?? '');
      return null;
    }
  }

  Future<bool> _deleteImage(String? urlImg, String? planogramCode) async {
    final requestData = _requestData.value;
    try {
      showLoadingIndicator();
      final request = SamplingUploadImageRequest(
        userId: requestData?.userId,
        userName: requestData?.displayName,
        employeeCode: requestData?.employeeCode,
        siteId: requestData?.siteId,
        imageGarnitureId: requestData?.imageGarnitureId,
        planogramCode: planogramCode,
        imageType: ImageType.sampling,
        img: null,
        urlImg: urlImg,
        fileName: null,
        fileExtension: FileExtension.jpeg.type,
      );
      final result = await samplingCancelImageUseCase.call(request);
      debugPrint("_deleteImage: ${result.systemMessage}");
      hideLoadingIndicator();
      return true;
    } on BaseErrorEntity catch (error) {
      if (error.statusCode == 1002) {
        hideLoadingIndicator();
        showSnackBar(description: error.message ?? '');
        await CaptureMethodChannel.logOut();
        return false;
      }
      hideLoadingIndicator();
      showSnackBar(description: error.message ?? '');
      return false;
    }
  }

  @override
  void onInit() async {
    super.onInit();
    await _getImageTemplates();
  }
}
