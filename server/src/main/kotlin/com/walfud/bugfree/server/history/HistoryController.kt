package com.walfud.bugfree.server.history

import com.walfud.bugfree.server.PAGE_SIZE
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.data.domain.Pageable
import org.springframework.data.domain.Sort
import org.springframework.data.web.PageableDefault
import org.springframework.web.bind.annotation.GetMapping
import org.springframework.web.bind.annotation.PostMapping
import org.springframework.web.bind.annotation.RequestMapping
import org.springframework.web.bind.annotation.RestController
import reactor.core.publisher.Flux
import reactor.core.publisher.Mono
import java.time.Duration
import java.time.LocalDateTime
import java.time.ZoneOffset

@RestController
@RequestMapping("/history")
class HistoryController @Autowired constructor(
        val historyService: HistoryService,
) {

    @GetMapping(produces = ["application/json;charset=UTF-8"])
    fun history(ver: String?, buildType: String?, category: String?, @PageableDefault(size = PAGE_SIZE, sort = ["timestamp"], direction = Sort.Direction.DESC) pageable: Pageable): Flux<HistoryResponse> {
        return historyService.findBy(ver, buildType, category, pageable)
                .map(HistoryResponse::fromDbHistory)
    }

    @GetMapping(path = ["/version"], produces = ["application/json;charset=UTF-8"])
    fun mainVersion(): Mono<List<String>> {
        return historyService.findMainVer()
                .collectList()
    }

    @PostMapping("/sync")
    fun sync(from: Long = 0): Flux<DbHistory> = historyService.syncFromJenkins(LocalDateTime.ofEpochSecond(from, 0, ZoneOffset.UTC))

    @PostMapping("/syncRecent")
    fun syncRecent(): Flux<DbHistory> = sync(System.currentTimeMillis() / 1000 - Duration.ofHours(1).toSeconds())
}

data class HistoryResponse(
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
        fun fromDbHistory(dbHistory: DbHistory): HistoryResponse = HistoryResponse(
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