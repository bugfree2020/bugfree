package com.walfud.bugfree.server.history

import org.springframework.beans.factory.annotation.Autowired
import org.springframework.scheduling.annotation.Scheduled
import org.springframework.stereotype.Component
import reactor.core.publisher.Flux

@Component
class HistoryScheduler @Autowired constructor(
        private val historyService: HistoryService,
) {

    @Scheduled(fixedDelay = 60 * 60 * 1000)
    fun syncJenkinsHistory(): Flux<DbHistory> = historyService.syncFromJenkins()

}