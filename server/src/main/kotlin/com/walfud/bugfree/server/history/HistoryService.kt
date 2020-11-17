package com.walfud.bugfree.server.history

import org.springframework.beans.factory.annotation.Autowired
import org.springframework.stereotype.Service
import reactor.core.publisher.Flux

@Service
class HistoryService @Autowired constructor(
        private val historyRepository: HistoryRepository
) {
    fun findBy(ver: String?, buildType: String?, category: String?, offset: Int, limit: Int): Flux<DbHistory>? {
        return historyRepository.findAll()
                .filter {
                    if (ver != null && ver != it.ver) return@filter false
                    if (buildType != null && buildType != it.buildType) return@filter false
                    if (category != null && category != it.category) return@filter false
                    true
                }
                .sort { o1, o2 -> o1.createTime.compareTo(o2.createTime) }
                .skipLast(offset)
                .take(limit.toLong())
    }
}