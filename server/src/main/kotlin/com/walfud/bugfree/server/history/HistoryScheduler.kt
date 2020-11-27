package com.walfud.bugfree.server.history

import org.springframework.beans.factory.annotation.Autowired
import org.springframework.scheduling.annotation.Scheduled
import org.springframework.stereotype.Component
import reactor.core.publisher.Flux
import java.time.LocalDateTime

@Component
class HistoryScheduler @Autowired constructor(
        private val historyService: HistoryService,
) {

    @Scheduled(cron = "0 0 0 * * *")
    fun fullSyncPerDay(): Flux<DbHistory> = historyService.syncFromJenkins(LocalDateTime.MIN)

}