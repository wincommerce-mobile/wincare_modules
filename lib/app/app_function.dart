import 'package:wincare_modules/features/capture/presentation/capture_controller.dart';

import '../features/capture/domain/entities/capture/image_template_entity.dart';

typedef OnImageAction = void Function(int);
typedef OnViewImage = void Function(int);
typedef OnTakePicTure = void Function();
typedef OnDeleteImage = void Function(int);
typedef OnGetImagePoint = void Function(ImageResult);
