package com.walfud.bugfree.server.history

import com.walfud.bugfree.server.BaseService
import org.slf4j.LoggerFactory
import org.springframework.data.domain.Pageable
import org.springframework.stereotype.Service
import org.springframework.transaction.annotation.Transactional
import reactor.core.publisher.Flux
import reactor.core.publisher.Mono

@Service
class HistoryService : BaseService() {
    companion object {
        private val logger = LoggerFactory.getLogger(HistoryService::class.java)
    }

    @Transactional
    fun findBy(ver: String?, buildType: String?, category: String?, pageable: Pageable): Flux<DbHistory> {
        logger.debug("<<< findBy. ver($ver), buildType($buildType), category($category), pageable($pageable)")

        return historyRepository.findAll()
                .filter {
                    if (ver != null && ver != it.ver) return@filter false
                    if (buildType != null && buildType != it.buildType) return@filter false
                    if (category != null && category != it.category) return@filter false
                    true
                }
                .skip(if (pageable.isPaged) pageable.pageNumber * pageable.pageSize.toLong() else 0)
                .take(if (pageable.isPaged) pageable.pageSize.toLong() else Long.MAX_VALUE)
                .sort { o1, o2 -> o1.createTime.compareTo(o2.createTime) }
    }

    @Transactional
    fun insertIfAbsent(dbHistory: DbHistory): Mono<Boolean> {
        return historyRepository.findAll()
                .filter { it.jenkinsId == dbHistory.jenkinsId }
                .hasElements()
                .flatMap {
                    return@flatMap if (it) {
                        Mono.just(false)
                    } else {
                        historyRepository.insert(
                                dbHistory.id,
                                dbHistory.jenkinsId,
                                dbHistory.name,
                                dbHistory.branch,
                                dbHistory.ver,
                                dbHistory.buildType,
                                dbHistory.category,
                                dbHistory.content,
                                dbHistory.urlInner,
                                dbHistory.urlOuter,
                                dbHistory.result,
                                dbHistory.who,
                                dbHistory.extra,
                                dbHistory.createTime,
                                dbHistory.updateTime,
                        )
                                .map { true }
                    }
                }
    }

    fun syncFromJenkins(): Flux<DbHistory> {
        logger.debug("<<< syncFromJenkins. ")

        val syncTask = jenkinsService.loadHistory()
                .flatMap { historyService.insertIfAbsent(it) }
        val historyTask = historyService.findBy(null, null, null, Pageable.unpaged())

        return syncTask.thenMany(historyTask)
    }
}