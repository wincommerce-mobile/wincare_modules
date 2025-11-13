import 'package:dio/dio.dart';
import 'package:wincare_modules/features/capture/data/request/complaint_reason_request.dart';
import 'package:wincare_modules/features/capture/data/request/complaint_request.dart';
import 'package:wincare_modules/features/capture/data/request/image_template_request.dart';
import 'package:wincare_modules/features/capture/data/request/sampling_confirm_garniture_request.dart';
import 'package:wincare_modules/features/capture/data/request/sampling_sent_approval_garniture_request.dart';
import 'package:wincare_modules/features/capture/data/request/sampling_upload_image_request.dart';
import 'package:wincare_modules/features/capture/data/response/base_created_response.dart';
import 'package:wincare_modules/features/capture/data/response/capture/complaint_reason_response.dart';
import 'package:wincare_modules/features/capture/data/response/capture/image_template_response.dart';

import '../../../api/api_client_type.dart';
import '../../../api/base/base_error_response.dart';
import '../../../api/global_request_builder.dart';
import '../../request/result_image_garniture_request.dart';
import '../../response/capture/result_image_garniture_response.dart';
import 'capture_data_source.dart';

class CaptureDataSourceImpl implements CaptureDataSource {
  CaptureDataSourceImpl({required this.apiClient});

  final APIClientType apiClient;

  @override
  Future<ResultImageGarnitureResponse?> samplingOutletResultImageGarniture(
    ResultImageGarnitureRequest request,
  ) async {
    final req = await GlobalRequestBuilder.build<ResultImageGarnitureRequest>(
      request,
    );
    final jsonBody = req.toJson((p) => p?.toJson() ?? {});
    try {
      final response = await apiClient.samplingOutletResultImageGarniture(
        jsonBody,
      );
      if (response.data != null) {
        return response.data;
      }

      throw BaseErrorResponse.fromApiException(
        response.errorMessage,
        response.statusCode,
      );
    } on DioException catch (error) {
      throw BaseErrorResponse.fromDioException(error);
    }
  }

  @override
  Future<List<ImageTemplateResponse>?> getImageTemplateGarniture(
    ImageTemplateRequest request,
  ) async {
    final req = await GlobalRequestBuilder.build<ImageTemplateRequest>(request);
    final jsonBody = req.toJson((p) => p?.toJson() ?? {});
    try {
      final response = await apiClient.getImageTemplateGarniture(jsonBody);
      if (response.data != null) {
        return response.data;
      }

      throw BaseErrorResponse.fromApiException(
        response.errorMessage,
        response.statusCode,
      );
    } on DioException catch (error) {
      throw BaseErrorResponse.fromDioException(error);
    }
  }

  @override
  Future<BaseCreatedResponse?> promotionAIVComplaint(
    ComplaintRequest request,
  ) async {
    final req = await GlobalRequestBuilder.build<ComplaintRequest>(request);
    final jsonBody = req.toJson((p) => p?.toJson() ?? {});
    try {
      final response = await apiClient.promotionAIVComplaint(jsonBody);
      if (response.data != null) {
        return response.data;
      }

      throw BaseErrorResponse.fromApiException(
        response.errorMessage,
        response.statusCode,
      );
    } on DioException catch (error) {
      throw BaseErrorResponse.fromDioException(error);
    }
  }

  @override
  Future<List<ComplaintReasonResponse>?> getPromotionAIVComplaintReason(
    ComplaintReasonRequest request,
  ) async {
    final req = await GlobalRequestBuilder.build<ComplaintReasonRequest>(
      request,
    );
    final jsonBody = req.toJson((p) => p?.toJson() ?? {});
    try {
      final response = await apiClient.getPromotionAIVComplaintReason(jsonBody);
      if (response.data != null) {
        return response.data;
      }

      throw BaseErrorResponse.fromApiException(
        response.errorMessage,
        response.statusCode,
      );
    } on DioException catch (error) {
      throw BaseErrorResponse.fromDioException(error);
    }
  }

  @override
  Future<BaseCreatedResponse?> samplingOutletUploadImage(
    SamplingUploadImageRequest request,
  ) async {
    final req = await GlobalRequestBuilder.build<SamplingUploadImageRequest>(
      request,
    );
    final jsonBody = req.toJson((p) => p?.toJson() ?? {});
    try {
      final response = await apiClient.samplingOutletUploadImage(jsonBody);
      if (response.data != null) {
        return response.data;
      }

      throw BaseErrorResponse.fromApiException(
        response.errorMessage,
        response.statusCode,
      );
    } on DioException catch (error) {
      throw BaseErrorResponse.fromDioException(error);
    }
  }

  @override
  Future<BaseCreatedResponse?> samplingOutletCancelImage(
    SamplingUploadImageRequest request,
  ) async {
    final req = await GlobalRequestBuilder.build<SamplingUploadImageRequest>(
      request,
    );
    final jsonBody = req.toJson((p) => p?.toJson() ?? {});
    try {
      final response = await apiClient.samplingOutletCancelImage(jsonBody);
      if (response.data != null) {
        return response.data;
      }

      throw BaseErrorResponse.fromApiException(
        response.errorMessage,
        response.statusCode,
      );
    } on DioException catch (error) {
      throw BaseErrorResponse.fromDioException(error);
    }
  }

  @override
  Future<BaseCreatedResponse?> samplingOutletConfirmImageGarniture(
    SamplingConfirmGarnitureRequest request,
  ) async {
    final req =
        await GlobalRequestBuilder.build<SamplingConfirmGarnitureRequest>(
          request,
        );
    final jsonBody = req.toJson((p) => p?.toJson() ?? {});
    try {
      final response = await apiClient.samplingOutletConfirmImageGarniture(
        jsonBody,
      );
      if (response.data != null) {
        return response.data;
      }
      final message =
          (response.errorMessage != null && response.errorMessage!.isNotEmpty)
          ? response.errorMessage
          : response.statusName;
      throw BaseErrorResponse.fromApiException(message, response.statusCode);
    } on DioException catch (error) {
      throw BaseErrorResponse.fromDioException(error);
    }
  }

  @override
  Future<BaseCreatedResponse?> samplingOutletSentApprovalImageGarniture(
    SamplingSentApprovalGarnitureRequest request,
  ) async {
    final req =
        await GlobalRequestBuilder.build<SamplingSentApprovalGarnitureRequest>(
          request,
        );
    final jsonBody = req.toJson((p) => p?.toJson() ?? {});
    try {
      final response = await apiClient.samplingOutletSentApprovalImageGarniture(
        jsonBody,
      );

      if (response.data != null) {
        return response.data;
      }

      throw BaseErrorResponse.fromApiException(
        response.errorMessage,
        response.statusCode,
      );
    } on DioException catch (error) {
      throw BaseErrorResponse.fromDioException(error);
    }
  }
}

// class CaptureDataSourceImpl implements CaptureDataSource {
//   CaptureDataSourceImpl({required this.apiClient});
//
//   final APIClientType apiClient;
//
//   @override
//   Future<ResultImageGarnitureResponse?> samplingOutletResultImageGarniture(
//     ResultImageGarnitureRequest request,
//   ) async {
//     debugPrint(
//       "calling samplingOutletResultImageGarniture for ${request.planogramCode} at ${DateTime.now()}",
//     );
//     try {
//       final response = BaseResponse<ResultImageGarnitureResponse>.fromJson(
//         jsonDecode(MockResponse.samplingOutletResultImageGarniture),
//         (json) => ResultImageGarnitureResponse.fromJson(json),
//       );
//
//       if (response.data != null) {
//         return response.data;
//       }
//
//       throw BaseErrorResponse.fromApiException(
//         response.errorMessage,
//         response.statusCode,
//       );
//     } on DioException catch (error) {
//       throw BaseErrorResponse.fromDioException(error);
//     }
//   }
//
//   @override
//   Future<List<ImageTemplateResponse>?> getImageTemplateGarniture(
//     ImageTemplateRequest request,
//   ) async {
//     try {
//       final response = BaseListResponse<ImageTemplateResponse>.fromJson(
//         jsonDecode(MockResponse.getImageTemplateGarniture),
//         (json) => ImageTemplateResponse.fromJson(json),
//       );
//       if (response.data != null) {
//         return response.data;
//       }
//
//       throw BaseErrorResponse.fromApiException(
//         response.errorMessage,
//         response.statusCode,
//       );
//     } on DioException catch (error) {
//       throw BaseErrorResponse.fromDioException(error);
//     }
//   }
//
//   @override
//   Future<BaseCreatedResponse?> promotionAIVComplaint(
//     ComplaintRequest request,
//   ) async {
//     try {
//       final response = BaseResponse<BaseCreatedResponse>.fromJson(
//         jsonDecode(MockResponse.promotionAIVComplaint),
//         (json) => BaseCreatedResponse.fromJson(json),
//       );
//       if (response.data != null) {
//         return response.data;
//       }
//
//       throw BaseErrorResponse.fromApiException(
//         response.errorMessage,
//         response.statusCode,
//       );
//     } on DioException catch (error) {
//       throw BaseErrorResponse.fromDioException(error);
//     }
//   }
//
//   @override
//   Future<List<ComplaintReasonResponse>?> getPromotionAIVComplaintReason(
//     ComplaintReasonRequest request,
//   ) async {
//     try {
//       final response = BaseListResponse<ComplaintReasonResponse>.fromJson(
//         jsonDecode(MockResponse.getPromotionAIVComplaintReason),
//         (json) => ComplaintReasonResponse.fromJson(json),
//       );
//       if (response.data != null) {
//         return response.data;
//       }
//
//       throw BaseErrorResponse.fromApiException(
//         response.errorMessage,
//         response.statusCode,
//       );
//     } on DioException catch (error) {
//       throw BaseErrorResponse.fromDioException(error);
//     }
//   }
//
//   @override
//   Future<BaseCreatedResponse?> samplingOutletUploadImage(
//     SamplingUploadImageRequest request,
//   ) async {
//     try {
//       final response = BaseResponse<BaseCreatedResponse>.fromJson(
//         jsonDecode(MockResponse.samplingOutletUploadImage),
//         (json) => BaseCreatedResponse.fromJson(json),
//       );
//       if (response.data != null) {
//         return response.data;
//       }
//
//       throw BaseErrorResponse.fromApiException(
//         response.errorMessage,
//         response.statusCode,
//       );
//     } on DioException catch (error) {
//       throw BaseErrorResponse.fromDioException(error);
//     }
//   }
//
//   @override
//   Future<BaseCreatedResponse?> samplingOutletCancelImage(
//     SamplingUploadImageRequest request,
//   ) async {
//     try {
//       final response = BaseResponse<BaseCreatedResponse>.fromJson(
//         jsonDecode(MockResponse.samplingOutletCancelImage),
//         (json) => BaseCreatedResponse.fromJson(json),
//       );
//       if (response.data != null) {
//         return response.data;
//       }
//
//       throw BaseErrorResponse.fromApiException(
//         response.errorMessage,
//         response.statusCode,
//       );
//     } on DioException catch (error) {
//       throw BaseErrorResponse.fromDioException(error);
//     }
//   }
//
//   @override
//   Future<BaseCreatedResponse?> samplingOutletConfirmImageGarniture(
//     SamplingConfirmGarnitureRequest request,
//   ) async {
//     try {
//       final response = BaseResponse<BaseCreatedResponse>.fromJson(
//         jsonDecode(MockResponse.samplingOutletConfirmImageGarniture),
//         (json) => BaseCreatedResponse.fromJson(json),
//       );
//       if (response.data != null) {
//         return response.data;
//       }
//
//       throw BaseErrorResponse.fromApiException(
//         response.errorMessage,
//         response.statusCode,
//       );
//     } on DioException catch (error) {
//       throw BaseErrorResponse.fromDioException(error);
//     }
//   }
//
//   @override
//   Future<BaseCreatedResponse?> samplingOutletSentApprovalImageGarniture(
//     SamplingSentApprovalGarnitureRequest request,
//   ) async {
//     try {
//       final response = BaseResponse<BaseCreatedResponse>.fromJson(
//         jsonDecode(MockResponse.samplingOutletSentApprovalImageGarniture),
//         (json) => BaseCreatedResponse.fromJson(json),
//       );
//       if (response.data != null) {
//         return response.data;
//       }
//
//       throw BaseErrorResponse.fromApiException(
//         response.errorMessage,
//         response.statusCode,
//       );
//     } on DioException catch (error) {
//       throw BaseErrorResponse.fromDioException(error);
//     }
//   }
// }
