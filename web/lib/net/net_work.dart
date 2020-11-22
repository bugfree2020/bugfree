import 'dart:convert';

import 'package:app/net/ci_history_listener.dart';
import 'package:http/http.dart' as http;

class NetworkUtil {
  static String SERVER_CI_HISTORY = "https://swapi.dev/api/people";

  static Future<void> loadNewestCiHistory(
      OnCIHistoryListener ciHistoryListener) async {
    try {
      var response = await http.get(Uri.encodeFull(SERVER_CI_HISTORY),
          headers: {"Accept": "application/json"});
      var result = json.decode(response.body);
      print(result);
      if (ciHistoryListener != null) {
        ciHistoryListener.onLoadSuccess(null);
      }
    } catch (ex) {
      if (ciHistoryListener != null) {
        ciHistoryListener.onLoadFailed(ex);
      }
    }
  }
}
