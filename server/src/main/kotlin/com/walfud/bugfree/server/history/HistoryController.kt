package com.walfud.bugfree.server.history

import com.walfud.bugfree.server.PAGE_SIZE
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.web.bind.annotation.GetMapping
import org.springframework.web.bind.annotation.RequestMapping
import org.springframework.web.bind.annotation.RestController
import reactor.core.publisher.Flux

@RestController
@RequestMapping("/history")
class HistoryController @Autowired constructor(
        val historyService: HistoryService
) {

    @GetMapping
    fun history(ver: String?, buildType: String?, category: Int?, page: Int?): Flux<HistoryResponseItem>? {
        return historyService.findBy(ver, buildType, category, page?.let { page * PAGE_SIZE } ?: 0, PAGE_SIZE)
                ?.map(HistoryResponseItem::fromDbHistory)
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
        val result: Int,
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

        fun fromDbHistory(dbHistory: DbHistory): HistoryResponseItem = HistoryResponseItem(
                dbHistory.branch,
                dbHistory.ver,
                dbHistory.buildType,
                dbHistory.category,
                dbHistory.desc,
                dbHistory.urlInner,
                dbHistory.urlOuter,
                dbHistory.result,
                dbHistory.who,
                dbHistory.createTime.toInstant().epochSecond,
        )
    }
}