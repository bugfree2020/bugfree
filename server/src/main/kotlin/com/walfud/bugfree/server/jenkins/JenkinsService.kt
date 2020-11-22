package com.walfud.bugfree.server.jenkins

import com.cdancy.jenkins.rest.JenkinsClient
import com.walfud.bugfree.server.BaseService
import com.walfud.bugfree.server.history.*
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.scheduling.annotation.EnableScheduling
import org.springframework.scheduling.annotation.Scheduled
import org.springframework.stereotype.Service
import reactor.core.publisher.Flux
import reactor.core.scheduler.Schedulers
import java.sql.Timestamp
import java.time.LocalDateTime
import java.util.*

const val JOB_NAME = "zuiyou_oversea"
const val PARAM_BRANCH = "BRANCH"
const val PARAM_BUILD_TYPE = "BUILD_TYPE"
const val PARAM_CATEGORY = "BUSINESS"
const val PARAM_CONTENT = "DESC"

@Service
class JenkinsService @Autowired constructor(
        private val jenkinsClient: JenkinsClient
) : BaseService() {
    fun loadHistory(): Flux<DbHistory> {
        return Flux.just(true)
                .publishOn(Schedulers.parallel())
                .flatMap {
                    val buildInfos = jenkinsClient.api().jobsApi().jobInfo(null, JOB_NAME).builds()
                    Flux.fromIterable(buildInfos)
                }
                .map { buildInfo ->
                    jenkinsClient.api().jobsApi().buildInfo(null, JOB_NAME, buildInfo.number())
                }
                .map { buildInfo ->
                    val params = buildInfo.actions().singleOrNull { it.parameters().isNotEmpty() }?.parameters()
                    val branch = params?.singleOrNull { it.name() == PARAM_BRANCH }?.value() ?: ""
                    val ver = ""
                    val buildType = params?.singleOrNull { it.name() == PARAM_BUILD_TYPE }?.value() ?: ""
                    val category = params?.singleOrNull { it.name() == PARAM_CATEGORY }?.value() ?: ""
                    val content = params?.singleOrNull { it.name() == PARAM_CONTENT }?.value() ?: ""
                    val innerUrl = ""
                    val outerUrl = ""
                    val result = when (buildInfo.result()) {
                        "SUCCESS" -> HISTORY_RESULT_OK
                        "FAILURE" -> HISTORY_RESULT_FAIL
                        "ABORTED" -> HISTORY_RESULT_CANCEL
                        else -> HISTORY_RESULT_UNKNOWN
                    }
                    val cause = buildInfo.actions().singleOrNull { it.causes().isNotEmpty() }?.causes()
                    val who = cause?.singleOrNull { it.userName().isNotEmpty() }?.userName() ?: ""

                    DbHistory(
                            UUID.randomUUID().toString(),
                            buildInfo.id(),
                            buildInfo.displayName(),
                            branch,
                            ver,
                            buildType,
                            category,
                            content,
                            innerUrl,
                            outerUrl,
                            result,
                            who,
                            null,
                            LocalDateTime.now(),
                            LocalDateTime.now(),
                    )
                }
    }

}