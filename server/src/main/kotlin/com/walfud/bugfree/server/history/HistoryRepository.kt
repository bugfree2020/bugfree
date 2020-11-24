package com.walfud.bugfree.server.history

import org.springframework.data.r2dbc.repository.Modifying
import org.springframework.data.r2dbc.repository.Query
import org.springframework.data.repository.reactive.ReactiveCrudRepository
import reactor.core.publisher.Mono
import java.time.LocalDateTime

interface HistoryRepository : ReactiveCrudRepository<DbHistory, Long> {
    @Modifying
    @Query("""
                INSERT INTO `history`
                (id, jenkins_id, name, branch, ver, build_type, category, content, url_inner, url_outer, result, who, extra, create_time, update_time)
                VALUES
                (:id, :jenkinsId, :name, :branch, :ver, :buildType, :category, :content, :urlInner, :urlOuter, :result, :who, :extra, :createTime, :updateTime)
        """)
    fun insert(id: String, jenkinsId: String, name: String, branch: String, ver: String, buildType: String, category: String, content: String, urlInner: String, urlOuter: String, result: Int, who: String, extra: String?, createTime: LocalDateTime, updateTime: LocalDateTime): Mono<Int>
}