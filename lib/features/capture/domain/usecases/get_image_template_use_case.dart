import 'package:wincare_modules/features/capture/data/request/image_template_request.dart';
import 'package:wincare_modules/features/capture/domain/entities/capture/image_template_entity.dart';
import 'package:wincare_modules/features/capture/domain/repositories/capture_repository.dart';

import '../entities/base/base_error_entity.dart';

class GetImageTemplateUseCase {
  final CaptureRepository repository;

  GetImageTemplateUseCase({required this.repository});

  Future<List<ImageTemplateEntity>> call(ImageTemplateRequest request) async {
    try {
      return await repository.getImageTemplateGarniture(request);
    } on BaseErrorEntity catch (_) {
      rethrow;
    }
  }
}
