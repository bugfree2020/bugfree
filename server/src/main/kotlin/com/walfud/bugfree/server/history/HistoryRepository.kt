package com.walfud.bugfree.server.history

import org.springframework.data.r2dbc.repository.Query
import org.springframework.data.repository.reactive.ReactiveCrudRepository
import reactor.core.publisher.Flux
import java.sql.Timestamp


data class DbHistory(
        val id: String,
        val name: String,
        val branch: String,
        val ver: String,
        val buildType: String,
        val category: Int,
        val desc: String,
        val urlInner: String,
        val urlOuter: String,
        val result: Int,
        val who: String,
        val extra: String,
        val createTime: Timestamp,
        val updateTime: Timestamp,
)

interface HistoryRepository : ReactiveCrudRepository<DbHistory, Long>