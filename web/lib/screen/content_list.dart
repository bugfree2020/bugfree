import 'dart:html';

import 'package:app/data/pkg_data.dart';
import 'package:app/net/ci_history_listener.dart';
import 'package:app/net/net_work.dart';
import 'package:app/responsiblity/TestData.dart';
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
    var isSmallScreen = widget.sizingInformation.screenSize.width / 1.4 <= 860;
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 10),
        child: GridView.builder(
          // physics: const NeverScrollableScrollPhysics(),
          itemCount: _data == null ? 0 : _data.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: isSmallScreen ? 1 : 5,
            childAspectRatio: isSmallScreen ? 0.85 : 0.74,
          ),
          itemBuilder: (context, index) {
            return getGridCard(index, isSmallScreen);
          },
        ));
  }

  Container getGridCard(int index, bool isSmallScreen) {
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
    var stateColor = Colors.green;
    if (status == 0) {
      buildStatus = "打包成功";
    } else if (status == 1) {
      stateColor = Colors.red;
      buildStatus = "打包失败";
    } else if (status == 5) {
      stateColor = Colors.purple;
      buildStatus = "打包取消";
    }
    return Container(
      width: 200,
      height: 400,
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
              Row(children: [
                Text(
                  data.title,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(width: 5),
                buildTipsButtonCustomWithShape(buildCategory, Colors.white,
                    Colors.black87, BorderRadius.circular(45)),
              ]),
              SizedBox(height: 5),
              Row(
                children: [
                  buildTipsButtonCustom(
                      data.person, Colors.white, Colors.black26),
                  SizedBox(width: 5),
                  buildTipsButtonCustom(
                      "分支:${data.branch}", Colors.white, Colors.black26),
                ],
              ),
              SizedBox(height: 5),
              Row(
                children: [
                  buildTipsButtonCustomWithShape("版本:${data.ver}", Colors.white,
                      Colors.orange, BorderRadius.circular(15)),
                  SizedBox(width: 5),
                  buildTipsButtonCustomWithShape(data.build_type, Colors.white,
                      Colors.orange, BorderRadius.circular(15)),
                  SizedBox(width: 5),
                  buildTipsButtonCustomWithShape(buildStatus, Colors.white,
                      stateColor, BorderRadius.circular(15)),
                ],
              ),
              SizedBox(height: 7),
              Container(
                padding: EdgeInsets.symmetric(vertical: 2, horizontal: 10),
                decoration: buildCardContainer(),
                child: Text(
                  _data[index].desc,
                  maxLines: isSmallScreen ? 18 : 17,
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.black87,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Container(
            child: Row(
              children: [
                buildDownloadButtom(context, '外网下载',
                    "https://apk.izuiyou.com/download/zuiyou_lite.latest.h5_share.apk"),
                Expanded(
                  flex: 1,
                  child: Text(""),
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

  MaterialButton buildTipsButtonCustomWithShape(
      String info, Color txtColor, Color bgColor, BorderRadius radius) {
    return MaterialButton(
      child: Text(info),
      textColor: txtColor,
      color: bgColor,
      shape: RoundedRectangleBorder(
        borderRadius: radius,
      ),
      onPressed: () {},
    );
  }

  MaterialButton buildTipsButtonCustom(
      String info, Color txtColor, Color bgColor) {
    return MaterialButton(
      child: Text(info),
      textColor: txtColor,
      color: bgColor,
      onPressed: () {},
    );
  }

  MaterialButton buildTipsButton(String info, Color bgColor) {
    return buildTipsButtonCustom(info, Colors.black, bgColor);
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
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
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
    print("onLoadFailed$exception");
    setState(() {
      showAlertDialog(context, null);
    });
  }

  @override
  void onLoadSuccess(CIPkgInfoList data) {
    print("onLoadSuccess");
    setState(() {
      if (data != null && data.data != null && data.data.length > 0) {
        _data = data.data;
      }
    });
  }
}
