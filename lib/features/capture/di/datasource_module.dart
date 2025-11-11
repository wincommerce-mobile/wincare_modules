import 'package:wincare_modules/features/capture/data/datasources/capture/capture_data_source.dart';
import 'package:wincare_modules/features/capture/data/datasources/capture/capture_data_source_impl.dart';
import 'package:wincare_modules/features/capture/data/datasources/history/history_data_source.dart';
import 'package:wincare_modules/features/capture/data/datasources/history/history_data_source_impl.dart';

import 'client_module.dart';

mixin DatasourceModule on ClientModule {
  /// CaptureDateSource
  CaptureDataSource get captureDataSource {
    return CaptureDataSourceImpl(apiClient: apiClient);
  }

  /// History
  HistoryDataSource get historyDataSource {
    return HistoryDataSourceImpl(apiClient: apiClient);
  }
}
