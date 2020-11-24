package com.walfud.bugfree.server.history

import com.walfud.bugfree.server.PAGE_SIZE
import com.walfud.bugfree.server.jenkins.JenkinsService
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.data.domain.Pageable
import org.springframework.data.domain.Sort
import org.springframework.data.web.PageableDefault
import org.springframework.web.bind.annotation.GetMapping
import org.springframework.web.bind.annotation.PostMapping
import org.springframework.web.bind.annotation.RequestMapping
import org.springframework.web.bind.annotation.RestController
import reactor.core.publisher.Flux
import java.time.ZoneOffset

@RestController
@RequestMapping("/history")
class HistoryController @Autowired constructor(
        val historyService: HistoryService,
        val jenkinsService: JenkinsService,
) {

    @GetMapping(produces = ["application/json;charset=UTF-8"])
    fun history(ver: String?, buildType: String?, category: String?, @PageableDefault(value = 0, sort = ["timestamp"], direction = Sort.Direction.DESC) pageable: Pageable?): Flux<HistoryResponseItem>? {
        return historyService.findBy(ver, buildType, category, pageable ?: Pageable.unpaged())
                ?.map(HistoryResponseItem::fromDbHistory)
    }

    @PostMapping("/sync")
    fun sync(): Flux<DbHistory> {
        val syncTask = jenkinsService.loadHistory()
                .flatMap { historyService.insertIfAbsent(it) }
        val historyTask = historyService.findBy(null, null, null, Pageable.unpaged())

        return syncTask.thenMany(historyTask)
    }
}

data class HistoryResponseItem(
        val branch: String,
        val ver: String,
        val buildType: String,
        val category: String,
        val desc: String,
        val urlInner: String,
        val urlOuter: String,
        val result: Int,
        val who: String,
        val timestamp: Long,
) {
    companion object {
        fun fromDbHistory(dbHistory: DbHistory): HistoryResponseItem = HistoryResponseItem(
                dbHistory.branch,
                dbHistory.ver,
                dbHistory.buildType,
                dbHistory.category,
                dbHistory.content,
                dbHistory.urlInner,
                dbHistory.urlOuter,
                dbHistory.result,
                dbHistory.who,
                dbHistory.createTime.toEpochSecond(ZoneOffset.UTC),
        )
    }
}