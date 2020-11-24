package com.walfud.bugfree.server.history

import com.walfud.bugfree.server.BaseService
import org.springframework.data.domain.Pageable
import org.springframework.stereotype.Service
import org.springframework.transaction.annotation.Transactional
import reactor.core.publisher.Flux
import reactor.core.publisher.Mono

@Service
class HistoryService : BaseService() {
    @Transactional
    fun findBy(ver: String?, buildType: String?, category: String?, pageable: Pageable): Flux<DbHistory> {
        return historyRepository.findAll()
                .filter {
                    if (ver != null && ver != it.ver) return@filter false
                    if (buildType != null && buildType != it.buildType) return@filter false
                    if (category != null && category != it.category) return@filter false
                    true
                }
                .sort { o1, o2 -> o1.createTime.compareTo(o2.createTime) }
                .skipLast(pageable.let { if (it.isPaged) it.pageNumber * it.pageSize else null } ?: 0)
                .take(pageable.let { if (it.isPaged) it.pageSize else null }?.toLong() ?: Long.MAX_VALUE)
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
}