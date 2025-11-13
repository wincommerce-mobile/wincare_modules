import 'package:dio/dio.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/retrofit.dart' as retrofit;
import 'package:wincare_modules/features/capture/data/response/base_created_response.dart';

import '../data/response/capture/complaint_reason_response.dart';
import '../data/response/capture/image_template_response.dart';
import '../data/response/capture/result_image_garniture_response.dart';
import '../data/response/history/image_garniture_history_response.dart';
import 'base/base_response.dart';

part 'api_client_type.g.dart';

@retrofit.RestApi()
abstract class APIClientType {
  factory APIClientType(Dio dio, {String baseUrl}) = _APIClientType;

  /// Lấy thông tin zone / hình mẫu của mỗi zone
  @retrofit.POST('/api/MCHDMS/DMSSamplingOutletScoresImageTemplateGarniture')
  Future<BaseListResponse<ImageTemplateResponse>> getImageTemplateGarniture(
    @retrofit.Body() Map<String, dynamic> body,
  );

  /// Chụp hình và gửi hình lên API
  @retrofit.POST('/api/MCHDMS/DMSSamplingOutletUploadImage')
  Future<BaseResponse<BaseCreatedResponse>> samplingOutletUploadImage(
    @retrofit.Body() Map<String, dynamic> body,
  );

  /// Xoá ảnh
  @retrofit.POST('/api/MCHDMS/DMSSamplingOutletCancelImage')
  Future<BaseResponse<BaseCreatedResponse>> samplingOutletCancelImage(
    @retrofit.Body() Map<String, dynamic> body,
  );

  /// Chấm ảnh
  @retrofit.POST('/api/MCHDMS/DMSSamplingOutletSentApprovalImageGarniture')
  Future<BaseResponse<BaseCreatedResponse>>
  samplingOutletSentApprovalImageGarniture(
    @retrofit.Body() Map<String, dynamic> body,
  );

  /// Xác nhận (Gửi bộ hình trưng bày)
  @retrofit.POST('/api/MCHDMS/DMSSamplingOutletConfirmImageGarniture')
  Future<BaseResponse<BaseCreatedResponse>> samplingOutletConfirmImageGarniture(
    @retrofit.Body() Map<String, dynamic> body,
  );

  /// Lấy lịch sử của từng bộ hình
  @retrofit.POST('/api/MCHDMS/DMSSamplingOutletHistoryImageGarniture')
  Future<BaseListResponse<ImageGarnitureHistoryResponse>>
  samplingOutletHistoryImageGarniture(
    @retrofit.Body() Map<String, dynamic> body,
  );

  /// Kết quả chấm hình (theo từng zone)
  @retrofit.POST('/api/MCHDMS/DMSSamplingOutletResultImageGarniture')
  Future<BaseResponse<ResultImageGarnitureResponse>>
  samplingOutletResultImageGarniture(
    @retrofit.Body() Map<String, dynamic> body,
  );

  /// Lấy lý do khiếu nại
  @retrofit.POST('/api/MCHDMS/DMSPromotionAIVComplaintReason')
  Future<BaseListResponse<ComplaintReasonResponse>>
  getPromotionAIVComplaintReason(@retrofit.Body() Map<String, dynamic> body);

  /// Gửi khiếu nại
  @retrofit.POST('/api/MCHDMS/DMSPromotionAIVComplaint')
  Future<BaseResponse<BaseCreatedResponse>> promotionAIVComplaint(
    @retrofit.Body() Map<String, dynamic> body,
  );
}
