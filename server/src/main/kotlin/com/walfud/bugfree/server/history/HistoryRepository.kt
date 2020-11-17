package com.walfud.bugfree.server.history

import org.springframework.data.relational.core.mapping.Table
import org.springframework.data.repository.reactive.ReactiveCrudRepository
import java.sql.Timestamp

const val HISTORY_RESULT_OK = 0
const val HISTORY_RESULT_FAIL = 1
const val HISTORY_RESULT_CANCEL = 5

@Table("history")
data class DbHistory(
        var id: String,
        var name: String,
        var branch: String,
        var ver: String,
        var buildType: String,
        var category: String,
        var content: String,
        var urlInner: String,
        var urlOuter: String,
        var result: Int,
        var who: String,
        var extra: String?,
        var createTime: Timestamp,
        var updateTime: Timestamp,
)

interface HistoryRepository : ReactiveCrudRepository<DbHistory, Long>