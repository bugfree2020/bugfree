import 'package:app/data/pkg_data.dart';

class FakeResponsitory {
/*
  static List<DataPkgInfo> testDatas = [
    DataPkgInfo(
        "Cocofun Android",
        "dev/1.60",
        "1.60.1",
        0,
        "release",
        """1.修改资料重名后的提示
2.我的”页面任务中心入口
3.红点登录case ab + fix 红点未登录间隔bug，fix 底部有红点，上面没有红点问题
4.发帖来源添加统计
5.点赞优化
6.fix 私信创建空白无法删除问题
7.fix 弱网双击点赞弹层动画缓慢问题
8.合并直播
9.点赞实验组b添加点赞动效
10.release 终包
11.targetSdkVersion = 29


""",
        "https://www.baidu.com",
        "https://www.sina.com.cn",
        5,
        "cocoyoung"),
    DataPkgInfo(
        "Cocofun IOS",
        "dev/1.69.2",
        "1.61.1",
        2,
        "debug",
        """1.修改资料重名后的提示
2.我的”页面任务中心入口
3.红点登录case ab + fix 红点未登录间隔bug，fix 底部有红点，上面没有红点问题
4.发帖来源添加统计
5.点赞优化
6.fix 私信创建空白无法删除问题
7.fix 弱网双击点赞弹层动画缓慢问题
8.合并直播



""",
        "https://www.baidu.com",
        "https://www.sina.com.cn",
        1,
        "wuhongbo"),
      DataPkgInfo(
          "Cocofun Android",
          "dev/1.60",
          "1.60.1",
          1,
          "release",
          """1.修改资料重名后的提示
2.我的”页面任务中心入口
3.红点登录case ab + fix 红点未登录间隔bug，fix 底部有红点，上面没有红点问题
4.发帖来源添加统计
5.点赞优化
6.fix 私信创建空白无法删除问题
7.fix 弱网双击点赞弹层动画缓慢问题
8.合并直播
9.点赞实验组b添加点赞动效
10.release 终包
11.targetSdkVersion = 29


""",
          "https://www.baidu.com",
          "https://www.sina.com.cn",
          0,
          "cocoyoung"),
      DataPkgInfo(
          "Cocofun Android",
          "dev/1.60",
          "1.60.1",
          0,
          "release",
          """1.修改资料重名后的提示
2.我的”页面任务中心入口
3.红点登录case ab + fix 红点未登录间隔bug，fix 底部有红点，上面没有红点问题
4.发帖来源添加统计
5.点赞优化
6.fix 私信创建空白无法删除问题
7.fix 弱网双击点赞弹层动画缓慢问题
8.合并直播
9.点赞实验组b添加点赞动效
10.release 终包
11.targetSdkVersion = 29


""",
          "https://www.baidu.com",
          "https://www.sina.com.cn",
          5,
          "cocoyoung"),
      DataPkgInfo(
          "Cocofun IOS",
          "dev/1.69.2",
          "1.61.1",
          2,
          "debug",
          """1.修改资料重名后的提示
2.我的”页面任务中心入口
3.红点登录case ab + fix 红点未登录间隔bug，fix 底部有红点，上面没有红点问题
4.发帖来源添加统计
5.点赞优化
6.fix 私信创建空白无法删除问题
7.fix 弱网双击点赞弹层动画缓慢问题
8.合并直播



""",
          "https://www.baidu.com",
          "https://www.sina.com.cn",
          1,
          "wuhongbo"),
      DataPkgInfo(
          "Cocofun Android",
          "dev/1.60",
          "1.60.1",
          1,
          "release",
          """1.修改资料重名后的提示
2.我的”页面任务中心入口
3.红点登录case ab + fix 红点未登录间隔bug，fix 底部有红点，上面没有红点问题
4.发帖来源添加统计
5.点赞优化
6.fix 私信创建空白无法删除问题
7.fix 弱网双击点赞弹层动画缓慢问题
8.合并直播
9.点赞实验组b添加点赞动效
10.release 终包
11.targetSdkVersion = 29


""",
          "https://www.baidu.com",
          "https://www.sina.com.cn",
          0,
          "cocoyoung"),
      DataPkgInfo(
          "Cocofun Android",
          "dev/1.60",
          "1.60.1",
          0,
          "release",
          """1.修改资料重名后的提示
2.我的”页面任务中心入口
3.红点登录case ab + fix 红点未登录间隔bug，fix 底部有红点，上面没有红点问题
4.发帖来源添加统计
5.点赞优化
6.fix 私信创建空白无法删除问题
7.fix 弱网双击点赞弹层动画缓慢问题
8.合并直播
9.点赞实验组b添加点赞动效
10.release 终包
11.targetSdkVersion = 29


""",
          "https://www.baidu.com",
          "https://www.sina.com.cn",
          5,
          "cocoyoung"),
      DataPkgInfo(
          "Cocofun IOS",
          "dev/1.69.2",
          "1.61.1",
          2,
          "debug",
          """1.修改资料重名后的提示
2.我的”页面任务中心入口
3.红点登录case ab + fix 红点未登录间隔bug，fix 底部有红点，上面没有红点问题
4.发帖来源添加统计
5.点赞优化
6.fix 私信创建空白无法删除问题
7.fix 弱网双击点赞弹层动画缓慢问题
8.合并直播



""",
          "https://www.baidu.com",
          "https://www.sina.com.cn",
          1,
          "wuhongbo"),
      DataPkgInfo(
          "Cocofun Android",
          "dev/1.60",
          "1.60.1",
          1,
          "release",
          """1.修改资料重名后的提示
2.我的”页面任务中心入口
3.红点登录case ab + fix 红点未登录间隔bug，fix 底部有红点，上面没有红点问题
4.发帖来源添加统计
5.点赞优化
6.fix 私信创建空白无法删除问题
7.fix 弱网双击点赞弹层动画缓慢问题
8.合并直播
9.点赞实验组b添加点赞动效
10.release 终包
11.targetSdkVersion = 29
8.合并直播
9.点赞实验组b添加点赞动效
10.release 终包
11.targetSdkVersion = 29
8.合并直播
9.点赞实验组b添加点赞动效
10.release 终包
11.targetSdkVersion = 29


""",
          "https://www.baidu.com",
          "https://www.sina.com.cn",
          0,
          "cocoyoung"),
      DataPkgInfo(
          "Cocofun Android",
          "dev/1.60",
          "1.60.1",
          0,
          "release",
          """1.修改资料重名后的提示
2.我的”页面任务中心入口
3.红点登录case ab + fix 红点未登录间隔bug，fix 底部有红点，上面没有红点问题
4.发帖来源添加统计
5.点赞优化
6.fix 私信创建空白无法删除问题
7.fix 弱网双击点赞弹层动画缓慢问题
8.合并直播
9.点赞实验组b添加点赞动效
10.release 终包
11.targetSdkVersion = 29


""",
          "https://www.baidu.com",
          "https://www.sina.com.cn",
          5,
          "cocoyoung"),
      DataPkgInfo(
          "Cocofun IOS",
          "dev/1.69.2",
          "1.61.1",
          2,
          "debug",
          """1.修改资料重名后的提示
2.我的”页面任务中心入口
3.红点登录case ab + fix 红点未登录间隔bug，fix 底部有红点，上面没有红点问题
4.发帖来源添加统计
5.点赞优化
6.fix 私信创建空白无法删除问题
7.fix 弱网双击点赞弹层动画缓慢问题
8.合并直播



""",
          "https://www.baidu.com",
          "https://www.sina.com.cn",
          1,
          "wuhongbo"),
      DataPkgInfo(
          "Cocofun Android",
          "dev/1.60",
          "1.60.1",
          1,
          "release",
          """1.修改资料重名后的提示
2.我的”页面任务中心入口
3.红点登录case ab + fix 红点未登录间隔bug，fix 底部有红点，上面没有红点问题
4.发帖来源添加统计
5.点赞优化
6.fix 私信创建空白无法删除问题
7.fix 弱网双击点赞弹层动画缓慢问题
8.合并直播
9.点赞实验组b添加点赞动效
10.release 终包
11.targetSdkVersion = 29


""",
          "https://www.baidu.com",
          "https://www.sina.com.cn",
          0,
          "cocoyoung"),
      DataPkgInfo(
          "Cocofun Android",
          "dev/1.60",
          "1.60.1",
          0,
          "release",
          """1.修改资料重名后的提示
2.我的”页面任务中心入口
3.红点登录case ab + fix 红点未登录间隔bug，fix 底部有红点，上面没有红点问题
4.发帖来源添加统计
5.点赞优化
6.fix 私信创建空白无法删除问题
7.fix 弱网双击点赞弹层动画缓慢问题
8.合并直播
9.点赞实验组b添加点赞动效
10.release 终包
11.targetSdkVersion = 29


""",
          "https://www.baidu.com",
          "https://www.sina.com.cn",
          5,
          "cocoyoung"),
      DataPkgInfo(
          "Cocofun IOS",
          "dev/1.69.2",
          "1.61.1",
          2,
          "debug",
          """1.修改资料重名后的提示
2.我的”页面任务中心入口
3.红点登录case ab + fix 红点未登录间隔bug，fix 底部有红点，上面没有红点问题
4.发帖来源添加统计
5.点赞优化
6.fix 私信创建空白无法删除问题
7.fix 弱网双击点赞弹层动画缓慢问题
8.合并直播



""",
          "https://www.baidu.com",
          "https://www.sina.com.cn",
          1,
          "wuhongbo"),
      DataPkgInfo(
          "Cocofun Android",
          "dev/1.60",
          "1.60.1",
          1,
          "release",
          """1.修改资料重名后的提示
2.我的”页面任务中心入口
3.红点登录case ab + fix 红点未登录间隔bug，fix 底部有红点，上面没有红点问题
4.发帖来源添加统计
5.点赞优化
6.fix 私信创建空白无法删除问题
7.fix 弱网双击点赞弹层动画缓慢问题
8.合并直播
9.点赞实验组b添加点赞动效
10.release 终包
11.targetSdkVersion = 29


""",
          "https://www.baidu.com",
          "https://www.sina.com.cn",
          0,
          "cocoyoung"),
      DataPkgInfo(
          "Cocofun Android",
          "dev/1.60",
          "1.60.1",
          0,
          "release",
          """1.修改资料重名后的提示
2.我的”页面任务中心入口
3.红点登录case ab + fix 红点未登录间隔bug，fix 底部有红点，上面没有红点问题
4.发帖来源添加统计
5.点赞优化
6.fix 私信创建空白无法删除问题
7.fix 弱网双击点赞弹层动画缓慢问题
8.合并直播
9.点赞实验组b添加点赞动效
10.release 终包
11.targetSdkVersion = 29


""",
          "https://www.baidu.com",
          "https://www.sina.com.cn",
          5,
          "cocoyoung"),
      DataPkgInfo(
          "Cocofun IOS",
          "dev/1.69.2",
          "1.61.1",
          2,
          "debug",
          """1.修改资料重名后的提示
2.我的”页面任务中心入口
3.红点登录case ab + fix 红点未登录间隔bug，fix 底部有红点，上面没有红点问题
4.发帖来源添加统计
5.点赞优化
6.fix 私信创建空白无法删除问题
7.fix 弱网双击点赞弹层动画缓慢问题
8.合并直播



""",
          "https://www.baidu.com",
          "https://www.sina.com.cn",
          1,
          "wuhongbo"),
      DataPkgInfo(
          "Cocofun Android",
          "dev/1.60",
          "1.60.1",
          1,
          "release",
          """1.修改资料重名后的提示
2.我的”页面任务中心入口
3.红点登录case ab + fix 红点未登录间隔bug，fix 底部有红点，上面没有红点问题
4.发帖来源添加统计
5.点赞优化
6.fix 私信创建空白无法删除问题
7.fix 弱网双击点赞弹层动画缓慢问题
8.合并直播
9.点赞实验组b添加点赞动效
10.release 终包
11.targetSdkVersion = 29


""",
          "https://www.baidu.com",
          "https://www.sina.com.cn",
          0,
          "cocoyoung"),
  ];
*/
}
