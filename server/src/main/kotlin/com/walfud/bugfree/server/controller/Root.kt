package com.walfud.bugfree.server.controller

import org.springframework.web.bind.annotation.GetMapping
import org.springframework.web.bind.annotation.RestController

@RestController
class Root {

    @GetMapping
    fun hello(): String {
        return "hello, bugfree!"
    }

    @GetMapping("/history")
    suspend fun history(ver: String?, buildType: String?, category: Int?, page: Int?): List<HistoryResponseItem> {
        return listOf(
                HistoryResponseItem(
                        "dev/1.60",
                        "1.60.0.001",
                        "preview",
                        HistoryResponseItem.CATEGORY_LIVE,
                        """
                            礼物交互优化问题修复
                        """,
                        "http://bugfree.ixiaochuan.cn/job/zuiyou_oversea/412/artifact/build/1.59.0.206.apk",
                        "https://apk.izuiyou.com/cocofun/android/1.59.0.206.apk",
                        HistoryResponseItem.STATUS_OK,
                        "Hetao",
                        1605533664,
                ),
                HistoryResponseItem(
                        "feature/adjust_v2",
                        "1.59.0.111",
                        "preview",
                        HistoryResponseItem.CATEGORY_MAIN,
                        """
                            fix 微调 (details)
                            add 发帖加上来源 (details)
                            add 修改版本号 (details)
                            1.59的我的页面功能基本完成 (details)
                            登录用户拉取数据 (details)
                            提升版本号 (details)
                            add 添加点赞重试机制及点赞状态优先展示 (details)
                            红点添加AB，GpsAdid添加自取以及打点上报，adjust集成签名v2 (details)
                            配置adjust的v2包问题 (details)
                        """,
                        "http://bugfree.ixiaochuan.cn/job/zuiyou_oversea/410/artifact/build/1.59.0.111.apk",
                        "https://apk.izuiyou.com/cocofun/android/1.59.0.111.apk",
                        HistoryResponseItem.STATUS_OK,
                        "wuhongbo",
                        1605523664,
                ),
                HistoryResponseItem(
                        "dev/1.59",
                        "1.59.0",
                        "release",
                        HistoryResponseItem.CATEGORY_INTEGRATED,
                        """
                            1.修改资料重名后的提示
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
                        "http://bugfree.ixiaochuan.cn/job/zuiyou_oversea/410/artifact/build/1.59.0.apk",
                        "https://apk.izuiyou.com/cocofun/android/1.59.0.apk",
                        HistoryResponseItem.STATUS_OK,
                        "wuhongbo",
                        1605513664,
                ),
        )
    }

}

data class HistoryResponseItem(
        val branch: String,
        val ver: String,
        val buildType: String,
        val category: Int,
        val desc: String,
        val urlInner: String,
        val urlOuter: String,
        val status: Int,
        val who: String,
        val timestamp: Long,
) {
    companion object {
        const val CATEGORY_INTEGRATED = 0
        const val CATEGORY_MAIN = 1
        const val CATEGORY_LIVE = 5

        const val STATUS_OK = 0
        const val STATUS_FAIL = 1
        const val STATUS_CANCEL = 5
    }
}