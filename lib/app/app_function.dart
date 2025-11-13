import '../features/capture/domain/entities/capture/result_image_garniture_entity.dart';

typedef OnImageAction = void Function(int);
typedef OnViewImage = void Function(int);
typedef OnTakePicTure = Future<void> Function();
typedef OnDeleteImage = Future<void> Function(int);
typedef OnUpdateFinalResult = void Function(bool);
typedef OnGetImagePoint = void Function(ResultImageGarnitureEntity);
