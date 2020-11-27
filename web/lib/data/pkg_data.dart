/*  数据示例
    {
        branch: String. 
        ver: String. "1.50.1"
        build_type: String. "release", "preview", "debug"
        category: Int. 0 集成包, 1 主版本, 5 直播
        desc: String. 提测内容.
        url_inner: String. 内网下载地址
        url_outer: String. 外网下载地址
        status: Int. 0 成功, 1 失败, 5 取消
    }
 */
import 'dart:convert';

class CIPkgInfoList {
  List<DataPkgInfo> data;

  CIPkgInfoList.fromJson(jsonRes) {
    data = List();
    for (var dataItem in jsonRes == null ? [] : jsonRes) {
      String title = dataItem['title'];
      String branch = dataItem['branch'];
      String ver = dataItem['ver'];
      String category = dataItem['category'];
      String buildType = dataItem['buildType'];
      String desc = dataItem['desc'];
      String urlInner = dataItem['url_inner'];
      String urlOuter = dataItem['url_outer'];
      int result = dataItem['result'];
      String who = dataItem['who'];
      data.add(DataPkgInfo("Cocofun Android", branch, ver, category, buildType, desc,
          urlInner, urlOuter, result, who));
    }
  }

  String utf8convert(String text) {
    List<int> bytes = text.toString().codeUnits;
    return utf8.decode(bytes);
  }

  @override
  String toString() {
    return 'CIPkgInfoList{data: $data}';
  }
}

class DataPkgInfo {
  String title;

  String branch;

  String who;

  String ver;

  String buildType;

  String category;

  String desc;

  String urlInner;

  String urlOuter;

  int result;

  int timestamp;

  DataPkgInfo(this.title, this.branch, this.ver, this.category, this.buildType,
      this.desc, this.urlInner, this.urlOuter, this.result, this.who);

  DataPkgInfo.fromJson(jsonRes) {
    this.title = jsonRes['title'];
    this.branch = jsonRes['branch'];
    this.ver = jsonRes['ver'];
    this.category = jsonRes['category'];
    this.buildType = jsonRes['buildType'];
    this.desc = jsonRes['desc'] + "\n\n\n";
    this.urlInner = jsonRes['urlInner'];
    this.buildType = jsonRes['buildType'];
    this.result = jsonRes['result'];
    this.who = jsonRes['who'];
    this.timestamp = jsonRes['timestamp'];
  }

  @override
  String toString() {
    return 'DataPkgInfo{title: $title, branch: $branch, person: $who, ver: $ver, build_type: $buildType, category: $category, desc: $desc, url_inner: $urlInner, url_outer: $urlOuter, status: $result}';
  }
}
