import 'package:app/data/pkg_data.dart';

abstract class OnCIHistoryListener {
  void onLoadSuccess(DataPkgInfo data);

  void onLoadFailed(Exception exception);
}
