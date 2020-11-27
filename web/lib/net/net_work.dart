import 'dart:convert';

import 'package:app/data/pkg_data.dart';
import 'package:app/net/ci_history_listener.dart';
import 'package:http/http.dart' as http;

class NetworkUtil {
  static const String SERVER_HOST = "http://bugfree.ixiaochuan.cn:28080";

  static const String SERVER_CI_HISTORY = SERVER_HOST + "/history";

  static Future<void> loadNewestCiHistory(
      OnCIHistoryListener ciHistoryListener) async {
    try {
      var response =
          await http.get(Uri.encodeFull(SERVER_CI_HISTORY), headers: {
        // "Accept": "application/json",
      });
      var result = json.decode(response.body);
      onLoadHistorySuccess(ciHistoryListener, result);
    } catch (ex) {
      onLoadHistoryFailed(ciHistoryListener, ex);
    }
  }

  static void onLoadHistoryFailed(OnCIHistoryListener ciHistoryListener, ex) {
    if (ciHistoryListener != null) {
      ciHistoryListener.onLoadFailed(ex);
    }
  }

  static void onLoadHistorySuccess(
      OnCIHistoryListener ciHistoryListener, result) {
    if (ciHistoryListener != null) {
      ciHistoryListener.onLoadSuccess(CIPkgInfoList.fromJson(result));
    }
  }
}
