import 'package:wincare_modules/features/capture/data/datasources/capture/capture_data_source.dart';
import 'package:wincare_modules/features/capture/data/request/capture_request.dart';
import 'package:wincare_modules/features/capture/domain/entities/capture/capture_entity.dart';

import '../../domain/repositories/capture_repository.dart';

class CaptureRepositoryImpl implements CaptureRepository {
  final CaptureDataSource captureDataSource;

  CaptureRepositoryImpl({required this.captureDataSource});

  @override
  Future<CaptureEntity> captureResult(CaptureRequest request) async {
    // TODO: implement captureResult
    throw UnimplementedError();
  }
}
