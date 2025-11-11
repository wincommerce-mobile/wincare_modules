import 'package:wincare_modules/features/capture/data/datasources/capture/capture_data_source.dart';
import 'package:wincare_modules/features/capture/data/mapper/base_mapper.dart';
import 'package:wincare_modules/features/capture/data/mapper/capture_mapper.dart';
import 'package:wincare_modules/features/capture/data/request/complaint_reason_request.dart';
import 'package:wincare_modules/features/capture/data/request/complaint_request.dart';
import 'package:wincare_modules/features/capture/data/request/image_template_request.dart';
import 'package:wincare_modules/features/capture/data/request/sampling_confirm_garniture_request.dart';
import 'package:wincare_modules/features/capture/data/request/sampling_sent_approval_garniture_request.dart';
import 'package:wincare_modules/features/capture/data/request/sampling_upload_image_request.dart';
import 'package:wincare_modules/features/capture/domain/entities/base/base_created_entity.dart';
import 'package:wincare_modules/features/capture/domain/entities/capture/complaint_reason_entity.dart';
import 'package:wincare_modules/features/capture/domain/entities/capture/image_template_entity.dart';

import '../../../../app/app_connectivity.dart';
import '../../api/base/base_error_response.dart';
import '../../domain/entities/base/base_error_entity.dart';
import '../../domain/entities/capture/result_image_garniture_entity.dart';
import '../../domain/repositories/capture_repository.dart';
import '../mapper/exception_mapper.dart';
import '../request/result_image_garniture_request.dart';

class CaptureRepositoryImpl implements CaptureRepository {
  final CaptureDataSource captureDataSource;

  CaptureRepositoryImpl({required this.captureDataSource});

  @override
  Future<ResultImageGarnitureEntity> samplingOutletResultImageGarniture(
    ResultImageGarnitureRequest request,
  ) async {
    if (await AppConnectivity.instance.isInternetAvailable()) {
      try {
        final response = await captureDataSource
            .samplingOutletResultImageGarniture(request);
        if (response == null) {
          throw BaseErrorEntity.noData();
        } else {
          final data = response.toEntity();
          return data;
        }
      } on BaseErrorResponse catch (error) {
        throw ExceptionMapper.toBaseErrorEntity(error);
      }
    } else {
      throw BaseErrorEntity.noNetworkError();
    }
  }

  @override
  Future<List<ImageTemplateEntity>> getImageTemplateGarniture(
    ImageTemplateRequest request,
  ) async {
    if (await AppConnectivity.instance.isInternetAvailable()) {
      try {
        final response = await captureDataSource.getImageTemplateGarniture(
          request,
        );
        if (response == null) {
          throw BaseErrorEntity.noData();
        } else {
          final data = response.map((e) => e.toEntity()).toList();
          return data;
        }
      } on BaseErrorResponse catch (error) {
        throw ExceptionMapper.toBaseErrorEntity(error);
      }
    } else {
      throw BaseErrorEntity.noNetworkError();
    }
  }

  @override
  Future<BaseCreatedEntity> promotionAIVComplaint(
    ComplaintRequest request,
  ) async {
    if (await AppConnectivity.instance.isInternetAvailable()) {
      try {
        final response = await captureDataSource.promotionAIVComplaint(request);
        if (response == null) {
          throw BaseErrorEntity.noData();
        } else {
          final data = response.toEntity();
          return data;
        }
      } on BaseErrorResponse catch (error) {
        throw ExceptionMapper.toBaseErrorEntity(error);
      }
    } else {
      throw BaseErrorEntity.noNetworkError();
    }
  }

  @override
  Future<List<ComplaintReasonEntity>> getPromotionAIVComplaintReason(
    ComplaintReasonRequest request,
  ) async {
    if (await AppConnectivity.instance.isInternetAvailable()) {
      try {
        final response = await captureDataSource.getPromotionAIVComplaintReason(
          request,
        );
        if (response == null) {
          throw BaseErrorEntity.noData();
        } else {
          final data = response.map((e) => e.toEntity()).toList();
          return data;
        }
      } on BaseErrorResponse catch (error) {
        throw ExceptionMapper.toBaseErrorEntity(error);
      }
    } else {
      throw BaseErrorEntity.noNetworkError();
    }
  }

  @override
  Future<BaseCreatedEntity> samplingOutletUploadImage(
    SamplingUploadImageRequest request,
  ) async {
    if (await AppConnectivity.instance.isInternetAvailable()) {
      try {
        final response = await captureDataSource.samplingOutletUploadImage(
          request,
        );
        if (response == null) {
          throw BaseErrorEntity.noData();
        } else {
          final data = response.toEntity();
          return data;
        }
      } on BaseErrorResponse catch (error) {
        throw ExceptionMapper.toBaseErrorEntity(error);
      }
    } else {
      throw BaseErrorEntity.noNetworkError();
    }
  }

  @override
  Future<BaseCreatedEntity> samplingOutletCancelImage(
    SamplingUploadImageRequest request,
  ) async {
    if (await AppConnectivity.instance.isInternetAvailable()) {
      try {
        final response = await captureDataSource.samplingOutletCancelImage(
          request,
        );
        if (response == null) {
          throw BaseErrorEntity.noData();
        } else {
          final data = response.toEntity();
          return data;
        }
      } on BaseErrorResponse catch (error) {
        throw ExceptionMapper.toBaseErrorEntity(error);
      }
    } else {
      throw BaseErrorEntity.noNetworkError();
    }
  }

  @override
  Future<BaseCreatedEntity> samplingOutletConfirmImageGarniture(
    SamplingConfirmGarnitureRequest request,
  ) async {
    if (await AppConnectivity.instance.isInternetAvailable()) {
      try {
        final response = await captureDataSource
            .samplingOutletConfirmImageGarniture(request);
        if (response == null) {
          throw BaseErrorEntity.noData();
        } else {
          final data = response.toEntity();
          return data;
        }
      } on BaseErrorResponse catch (error) {
        throw ExceptionMapper.toBaseErrorEntity(error);
      }
    } else {
      throw BaseErrorEntity.noNetworkError();
    }
  }

  @override
  Future<ResultImageGarnitureEntity> samplingOutletSentApprovalImageGarniture(
    SamplingSentApprovalGarnitureRequest request,
  ) async {
    if (await AppConnectivity.instance.isInternetAvailable()) {
      try {
        final response = await captureDataSource
            .samplingOutletSentApprovalImageGarniture(request);
        if (response == null) {
          throw BaseErrorEntity.noData();
        } else {
          final data = response.toEntity();
          return data;
        }
      } on BaseErrorResponse catch (error) {
        throw ExceptionMapper.toBaseErrorEntity(error);
      }
    } else {
      throw BaseErrorEntity.noNetworkError();
    }
  }
}
