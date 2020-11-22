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

class DataPkgInfo {

  String title;

  String branch;

  String person;

  String ver;

  String build_type;

  int category;

  String desc;

  String url_inner;

  String url_outer;

  int status;

  DataPkgInfo(this.title, this.branch, this.ver, this.category, this.build_type, this.desc,
      this.url_inner, this.url_outer, this.status, this.person);
}
