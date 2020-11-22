import 'package:app/data/pkg_data.dart';
import 'package:app/net/ci_history_listener.dart';
import 'package:app/net/net_work.dart';
import 'package:app/responsiblity/TestData.dart';
import 'package:app/widget/BadgePainter.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:flutter/rendering.dart';
import 'package:url_launcher/url_launcher.dart';

class BodyContentWidget extends StatefulWidget {
  final SizingInformation sizingInformation;

  BodyContentWidget({Key key, this.sizingInformation}) : super(key: key);

  @override
  State<StatefulWidget> createState() => ContentListScreen();
}

class ContentListScreen extends State<BodyContentWidget>
    implements OnCIHistoryListener {
  var _data = FakeResponsitory.testDatas;

  @override
  void initState() {
    super.initState();
    NetworkUtil.loadNewestCiHistory(this);
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: GridView.builder(
        // physics: const NeverScrollableScrollPhysics(),
        itemCount: _data == null ? 0 : _data.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount:
              widget.sizingInformation.screenSize.width / 1.4 <= 860 ? 2 : 5,
          childAspectRatio:
              widget.sizingInformation.screenSize.width / 1.4 <= 860
                  ? 0.4
                  : 0.8,
        ),
        itemBuilder: (context, index) {
          return Stack(
            children: <Widget>[
              getGridCard(index),
              Container(
                width: 300,
                height: 200,
                foregroundDecoration: BadgeDecoration(
                  badgeColor: Colors.green,
                  badgeSize: 70,
                  textSpan: TextSpan(
                    text: 'AWESOME',
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    ));
  }

  Container getGridCard(int index) {
    var data = _data[index];
    var category = data.category;
    String buildCategory = "";
    if (category == 0) {
      buildCategory = "集成包";
    } else if (category == 1) {
      buildCategory = "主版本";
    } else if (category == 2) {
      buildCategory = "直播";
    }
    var status = data.status;
    String buildStatus = "";
    if (status == 0) {
      buildStatus = "成功";
    } else if (status == 1) {
      buildStatus = "失败";
    } else if (status == 5) {
      buildStatus = "取消";
    }
    return Container(
      margin: EdgeInsets.only(right: 5, top: 5, bottom: 5, left: 5),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: buildCardContainer(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                data.title,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                "编译人:${data.person}",
                style: TextStyle(
                  color: Colors.grey[400],
                  fontSize: 14,
                ),
              ),
              Text(
                "版本:${data.ver}",
                style: TextStyle(
                  color: Colors.grey[400],
                  fontSize: 14,
                ),
              ),
              Text(
                "分支:${data.branch}",
                style: TextStyle(fontSize: 16, color: Colors.black),
              ),
              Text(
                "编译类型:${data.build_type}",
                style: TextStyle(fontSize: 16, color: Colors.black),
              ),
              Text(
                "编译状态:$buildStatus",
                style: TextStyle(fontSize: 16, color: Colors.black),
              ),
              Text(
                "编译渠道:$buildCategory",
                style: TextStyle(fontSize: 16, color: Colors.black),
              ),
              Text(
                _data[index].desc,
                style: TextStyle(fontSize: 14, color: Colors.red),
              ),
            ],
          ),
          Container(
            child: Row(
              children: [
                buildDownloadButtom(context, '外网下载',
                    "https://apk.izuiyou.com/download/zuiyou_lite.latest.h5_share.apk"),
                Expanded(
                  flex: 1,
                  child: Container(),
                ),
                buildDownloadButtom(context, '内网下载',
                    "https://apk.izuiyou.com/download/zuiyou_lite.latest.h5_share.apk"),
              ],
            ),
          ),
        ],
      ),
    );
  }

  BoxDecoration buildCardContainer() {
    return BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(8)),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(.2),
              blurRadius: 2,
              offset: Offset(0.5, 0.5),
              spreadRadius: 2)
        ]);
  }

  Expanded buildDownloadButtom(
      BuildContext context, String content, String url) {
    return Expanded(
      flex: 8,
      child: MaterialButton(
        child: Text(content),
        textColor: Colors.white,
        color: Colors.blue,
        padding: EdgeInsets.symmetric(vertical: 15),
        onPressed: () {
          launchDownload(context, url);
        },
      ),
    );
  }

  launchDownload(BuildContext context, var url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      showAlertDialog(context, url);
    }
  }

  showAlertDialog(BuildContext context, String url) {
    //设置按钮
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.of(context).pop(1);
      },
    );
    if (url != null && url != "") {
      url = '->$url';
    } else {
      url = "";
    }
    //设置对话框
    AlertDialog alert = AlertDialog(
      title: Text("出了点问题"),
      content: Text('链接无法访问$url'),
      actions: [
        okButton,
      ],
    );
    //显示对话框
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  void onLoadFailed(Exception exception) {
    print("onLoadFailed");
    setState(() {
      showAlertDialog(context, null);
    });
  }

  @override
  void onLoadSuccess(DataPkgInfo data) {
    print("onLoadSuccess");
    setState(() {});
  }
}
