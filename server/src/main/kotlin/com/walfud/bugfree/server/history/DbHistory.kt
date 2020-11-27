package com.walfud.bugfree.server.history

import org.springframework.data.annotation.Id
import org.springframework.data.relational.core.mapping.Table
import java.time.LocalDateTime

const val HISTORY_RESULT_UNKNOWN = -1
const val HISTORY_RESULT_OK = 0
const val HISTORY_RESULT_FAIL = 1
const val HISTORY_RESULT_CANCEL = 5

/**
 * Just begin building, has not completed
 */
const val HISTORY_RESULT_INCOMPLETE = 10

@Table("history")
data class DbHistory(
        @Id
        var id: String,
        var jenkinsId: String,

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
        var createTime: LocalDateTime,
        var updateTime: LocalDateTime,
)