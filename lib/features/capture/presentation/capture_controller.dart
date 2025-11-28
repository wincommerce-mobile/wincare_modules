import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wincare_modules/app/app_extensions.dart';
import 'package:wincare_modules/app/app_pages.dart';
import 'package:wincare_modules/app/app_secure_storage.dart';
import 'package:wincare_modules/features/capture/data/request/image_template_request.dart';
import 'package:wincare_modules/features/capture/domain/entities/request_data_model.dart';
import 'package:wincare_modules/features/capture/domain/usecases/get_image_template_use_case.dart';
import 'package:wincare_modules/features/capture/domain/usecases/get_promotion_aiv_complaint_reason_use_case.dart';
import 'package:wincare_modules/features/capture/domain/usecases/promotion_aiv_complaint_use_case.dart';
import 'package:wincare_modules/features/capture/domain/usecases/sampling_cancel_image_use_case.dart';
import 'package:wincare_modules/features/capture/domain/usecases/sampling_confirm_image_use_case.dart';
import 'package:wincare_modules/features/capture/domain/usecases/sampling_upload_image_use_case.dart';
import 'package:wincare_modules/features/capture/presentation/widgets/loading_indicator.dart';
import 'package:wincare_modules/features/capture/presentation/widgets/snack_bar.dart';

import '../../../app/app_constants.dart';
import '../../../app/app_enum.dart';
import '../data/request/complaint_reason_request.dart';
import '../data/request/sampling_upload_image_request.dart';
import '../domain/entities/base/base_error_entity.dart';
import '../domain/entities/capture/complaint_reason_entity.dart';
import '../domain/entities/capture/image_template_entity.dart';
import '../domain/entities/capture/result_image_garniture_entity.dart';
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

  final PageController pageController = PageController();
  var _currentPageIndex = 0;
  final zoneControllers = <ZoneController>[].obs;
  Position? _position;

  final _reasons = RxList<ComplaintReasonEntity>([]);

  final _requestData = Rxn<RequestDataModel>();

  var imageZones = RxList<ImageTemplateEntity>([]);

  //var message = 'Vui lòng xác nhận kết quả'.obs;


  /// Message warning các zone đã chấm hình nhưng chưa xác nhận / khiếu nại
  String get requiredMessage {
    String newMessage = '';
    for (var i in imageZones) {
      if (!i.finalComplianceStatus &&
          i.type == TemplateType.require &&
          ((i.result != null) ||
              (i.result == null && i.sampleImages.isNotEmpty))) {
        newMessage = '$newMessage[${i.zoneName}]';
      }
    }
    return '$newMessage chưa chấm hình / xác nhận kết quả';
  }

  /// Chỉ cho phép back khi đã xác nhận bộ hình (passed or not passed)
  bool get allowBack => imageZones
      .where((i) => i.type == TemplateType.require)
      .every(
        (i) =>
            (i.finalComplianceStatus == true ||
            (i.sampleImages.isEmpty) ||
            (_requestData.value != null && !_requestData.value!.isAllowEdit) ||
            (i.result != null &&
                i.result!.complianceStatusEnum != null &&
                i.result!.complianceStatusEnum != ComplianceStatusEnum.passed &&
                i.result!.complianceStatusEnum !=
                    ComplianceStatusEnum.notPassed)),
      );

  /// Trạng thái cuối cùng của cả bộ hình (tất cả các zone requỉred & đã xác nhận kq)
  bool get _finalComplianceStatus => imageZones
      .where((i) => i.type == TemplateType.require)
      .every((i) => (i.finalComplianceStatus == true));

  /// =========================== Method channel Zone ===========================//
  Future<void> triggerNativeBack() async {
    try {
      await _channel.invokeMethod(AppConstants.onBack, _finalComplianceStatus);
    } catch (e) {
      debugPrint('Error calling native back: $e');
    }
  }


  /// Test standalone flutter module with dummy data
  // Future<void> loadWithDummy() async {
  //   //showLoadingIndicator();
  //   await _clearResult();
  //   final dummyJsonStr = '''
  //    {"displayName":"SM Training 17","sessionLogin":"fd4f4598-cca1-4ca7-a711-4c8d4cd5a2d5","employeeCode":"sm.training17","siteId":"G-10KF1292","userId":2789,"samplingId":"1-5DT8EGT","imageGarnitureId":"49339ED0-81BC-45AD-A2D7-2B7AF6A66383","outletCode":"2158326","versionInfo":"1.8","isAllowEdit":true,"isAllowAddImage":true,"isAllowCancelImage":true,"isAllowSendApproval":true}
  //    ''';
  //   final Map<String, dynamic> decoded = jsonDecode(dummyJsonStr);
  //   final requestData = RequestDataModel.fromJson(decoded);
  //   await AppSecureStorage.saveRequestData(requestData);
  //   _requestData.value = await AppSecureStorage.getRequestData();
  //   await _getComplaintReason();
  //   await _getImageTemplates();
  //   _position = await _determinePosition();
  //   //hideLoadingIndicator();
  // }

  /// Method channel to conmunicate with native side
  Future<void> setupChannelHandler() async {
    _channel.setMethodCallHandler((call) async {
      debugPrint("Received arguments: ${call.arguments}");
      try {
        showLoadingIndicator();
        switch (call.method) {
          /// Get request data from native
          case AppConstants.getRequestData:
            /// Clear to prevent cached
            await _clearResult();
            final jsonStr = call.arguments as String;
            debugPrint("Received getRequestData: $jsonStr");
            final Map<String, dynamic> decoded = jsonDecode(jsonStr);
            final requestData = RequestDataModel.fromJson(decoded);
            /// Save new
            await AppSecureStorage.saveRequestData(requestData);
            _requestData.value = await AppSecureStorage.getRequestData();
            /// Pre-load reason
            await _getComplaintReason();
            /// Load data for zones
            await _getImageTemplates();
            hideLoadingIndicator();
            _position = await _determinePosition();
            break;
          case AppConstants.onNativeBackPressed:
            if (Get.currentRoute == AppRoutes.history) {
              Get.back();
            } else {
              if (Get.context != null && !allowBack) {
                showWarningDialog(
                  context: Get.context!,
                  message: requiredMessage,
                );
              } else {
                await triggerNativeBack();
              }
            }

            hideLoadingIndicator();
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

  Future<void> _clearResult() async {
    imageZones.clear();
    imageZones.refresh();
    zoneControllers.clear();
    zoneControllers.refresh();
    _requestData.value = null;
    await AppSecureStorage.clearRequest();
  }

  void onPageChanged(pageIndex) {
    _currentPageIndex = pageIndex;

    /// deselect all zones
    for (var i = 0; i < imageZones.length; i++) {
      imageZones[i] = imageZones[i].copyWith(selected: false);
    }

    /// select current zone
    imageZones[pageIndex] = imageZones[pageIndex].copyWith(selected: true);
    pageController.jumpToPage(pageIndex);
    imageZones.refresh();
  }

  /// Delete picture
  Future<void> onDeletePicTure(int zoneIndex, imageIndex) async {
    var imgZone = imageZones[zoneIndex];
    final result = await _deleteImage(
      imgZone.sampleImages[imageIndex].url,
      imgZone.planogramCode,
      imgZone.planogramId,
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

  /// Take picture
  Future<void> onTakePicTure(int zoneIndex) async {
    _position ??= await _determinePosition();
    final image = await _takePicture();
    if (image != null) {
      var imgZone = imageZones[zoneIndex];
      //showLoadingIndicator();
      final result = await _uploadImage(
        await image.readAsBytes(),
        imgZone.planogramCode,
        imgZone.planogramId,
        _position?.latitude ?? 0.0,
        _position?.longitude ?? 0.0,
      );
      if (result != null && result.isNotEmpty) {
        final address = await _getAddressFromLocation();
        final takenDate = DateTime.now().toAppDateTimeFormat();
        //hideLoadingIndicator();

        imgZone.sampleImages.add(
          SampleImageEntity(
            url: result,
            address: address,
            isSendConfirm: false,
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

  /// Listen kết quả chấm hình và update và zone
  Future<void> onUpdateResult(
    int zoneIndex,
    ResultImageGarnitureEntity result,
  ) async {
    var imgZone = imageZones[zoneIndex];
    bool isWaiting =
        result.complianceStatusEnum == ComplianceStatusEnum.waitingResult;

    /// Sau khi gọi chấm thành công, update tất cả hình trong zone thành hình đã chấm
    imageZones[zoneIndex] = imgZone.copyWith(
      result: result,
      sampleImages: imgZone.sampleImages
          .map<SampleImageEntity>(
            (img) =>
                img.copyWith(isSendConfirm: true, isWaitingResult: isWaiting),
          )
          .toList(),
    );
    imageZones.refresh();
  }

  /// Update kết quả cho cả bộ hình
  Future<void> onUpdateFinalResult(int zoneIndex, bool finaResult) async {
    var imgZone = imageZones[zoneIndex];
    imageZones[zoneIndex] = imgZone.copyWith(
      finalComplianceStatus: finaResult,
      sampleImages: imgZone.sampleImages
          .map<SampleImageEntity>((img) => img.copyWith(isAllowEdit: false))
          .toList(),
    );
    imageZones.refresh();
  }

  Future<XFile?> _takePicture() async {
    final XFile? image = await ImagePicker().pickImage(
      source: ImageSource.camera,
      imageQuality: 50,
      preferredCameraDevice: CameraDevice.rear,
    );

    return image;
  }

  /// =========================== Address & location zone ===========================//

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
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
      showLoadingIndicator(duration: Duration.zero);

      List<Placemark> placemarks = await placemarkFromCoordinates(
        _position?.latitude ?? 0.0,
        _position?.longitude ?? 0.0,
      );
      if (placemarks.isNotEmpty) {
        Placemark place = placemarks[0];
        debugPrint('_getAddressFromLocation: ${place.toJson()}');
        hideLoadingIndicator();
        return "${place.street}, ${place.subAdministrativeArea}, ${place.administrativeArea}, ${place.country}";
      } else {
        debugPrint('No address found for this location');
        hideLoadingIndicator();
        return null;
      }
    } catch (e) {
      debugPrint('Error get address from location: $e');
      hideLoadingIndicator();
      return null;
    }
  }

  /// Swipe to refresh zone data & get zone's result
  Future<void> onRefreshZone() async {
    await _getImageTemplates(selectedIndex: _currentPageIndex);
  }

  /// =========================== API call Zone ===========================//
  Future<List<ComplaintReasonEntity>> _getComplaintReason() async {
    try {
      final requestData = _requestData.value;
      final request = ComplaintReasonRequest(
        userId: requestData?.userId,
        userName: requestData?.displayName,
        employeeCode: requestData?.employeeCode,
        siteId: requestData?.siteId,
      );
      final result = await getPromotionAivComplaintReasonUseCase.call(request);
      _reasons.value = result;
      return result;
    } on BaseErrorEntity catch (error) {
      if (error.statusCode == 1002) {
        await CaptureMethodChannel.logOut();
        return [];
      }
      showSnackBar(description: error.message ?? '');
      return [];
    }
  }

  /// Lấy bộ hình mẫu
  Future<void> _getImageTemplates({int selectedIndex = 0}) async {
    try {
      showLoadingIndicator();
      final requestData = _requestData.value;
      final request = ImageTemplateRequest(
        userId: requestData?.userId,
        employeeCode: requestData?.employeeCode,
        samplingId: requestData?.samplingId,
        outletCode: requestData?.outletCode,
        imageGarnitureId: requestData?.imageGarnitureId,
      );
      final result = await getImageTemplateUseCase.call(request);
      imageZones.value = result;
      if (imageZones.isNotEmpty) {
        imageZones[selectedIndex] = imageZones[selectedIndex].copyWith(
          selected: true,
        );
        for (var i = 0; i < imageZones.length; i++) {
          final z = imageZones[i];
          bool isWaiting =
              z.result?.complianceStatusEnum ==
              ComplianceStatusEnum.waitingResult;
          imageZones[i] = z.copyWith(
            sampleImages: z.sampleImages
                .map<SampleImageEntity>(
                  (img) => img.copyWith(
                    isAllowEdit: requestData?.isAllowEdit,
                    isWaitingResult: isWaiting,
                  ),
                )
                .toList(),
          );
        }
        imageZones.refresh();
      }
      for (var zone in result) {
        final zc = ZoneController(
          zone: zone,
          reasonList: _reasons,
          samplingResultImageGarnitureUseCase: samplingResultImageGarniture,
          samplingSentApprovalImageUseCase: samplingSentApprovalImageUseCase,
          promotionAivComplaintUseCase: promotionAivComplaintUseCase,
          requestDataModel: _requestData.value,
          getPromotionAivComplaintReasonUseCase:
              getPromotionAivComplaintReasonUseCase,
          samplingConfirmImageUseCase: samplingConfirmImageUseCase,
        );
        zoneControllers.add(zc);
      }
      hideLoadingIndicator();
    } on BaseErrorEntity catch (error) {
      hideLoadingIndicator();
      if (error.statusCode == 1002) {
        await CaptureMethodChannel.logOut();
        return;
      }
      showSnackBar(description: error.message ?? '');
    }
  }

  Future<String?> _uploadImage(
    Uint8List bytes,
    String? planogramCode,
    int? planogramId,
    double lat,
    double lng,
  ) async {
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
        planogramId: planogramId,
        imageType: ImageType.sampling,
        img: base64Encode(bytes),
        urlImg: null,
        fileName: null,
        fileExtension: FileExtension.jpeg.type,
        latitude: lat,
        longitude: lng,
      );
      final result = await samplingUploadImageUseCase.call(request);
      if (result.id != null && result.id! > 0) {
        debugPrint("_uploadImage: ${result.systemMessage}");
        hideLoadingIndicator();
        if (result.systemMessage != null && result.systemMessage!.isNotEmpty) {
          showSuccessSnackBar(description: "Thành công");
        }

        /// Image url
        return result.systemMessage;
      } else {
        hideLoadingIndicator();
        showSnackBar(description: result.message ?? '');
        return null;
      }
    } on BaseErrorEntity catch (error) {
      hideLoadingIndicator();
      if (error.statusCode == 1002) {
        showSnackBar(description: error.message ?? '');
        await CaptureMethodChannel.logOut();
        return null;
      }
      showSnackBar(description: error.message ?? '');
      return null;
    }
  }

  Future<bool> _deleteImage(
    String? urlImg,
    String? planogramCode,
    int? planogramId,
  ) async {
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
        planogramId: planogramId,
        imageType: ImageType.sampling,
        img: null,
        urlImg: urlImg,
        fileName: null,
        fileExtension: FileExtension.jpeg.type,
      );
      final result = await samplingCancelImageUseCase.call(request);
      if (result.id != null && result.id! > 0) {
        hideLoadingIndicator();
        debugPrint("_deleteImage: ${result.message}");
        return true;
      } else {
        hideLoadingIndicator();
        showSnackBar(description: result.message ?? '');
        return false;
      }
    } on BaseErrorEntity catch (error) {
      hideLoadingIndicator();
      if (error.statusCode == 1002) {
        showSnackBar(description: error.message ?? '');
        await CaptureMethodChannel.logOut();
        return false;
      }
      showSnackBar(description: error.message ?? '');
      return false;
    }
  }
}
