import 'package:app/data/pkg_data.dart';

abstract class OnCIHistoryListener {
  void onLoadSuccess(CIPkgInfoList data);

  void onLoadFailed(Exception exception);
}
