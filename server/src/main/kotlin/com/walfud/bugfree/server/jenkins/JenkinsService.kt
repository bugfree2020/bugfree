package com.walfud.bugfree.server.jenkins

import com.cdancy.jenkins.rest.JenkinsClient
import com.fasterxml.jackson.databind.ObjectMapper
import com.walfud.bugfree.server.BaseService
import com.walfud.bugfree.server.history.*
import org.slf4j.LoggerFactory
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.stereotype.Service
import reactor.core.publisher.Flux
import reactor.core.scheduler.Schedulers
import java.time.LocalDateTime
import java.time.ZoneOffset
import java.util.*

const val JOB_NAME = "zuiyou_oversea"
const val PARAM_BRANCH = "BRANCH"
const val PARAM_BUILD_TYPE = "BUILD_TYPE"
const val PARAM_CATEGORY = "BUSINESS"
const val PARAM_CONTENT = "DESC"

@Service
class JenkinsService @Autowired constructor(
        private val jenkinsClient: JenkinsClient,
        private val objectMapper: ObjectMapper,
) : BaseService() {
    companion object {
        private val logger = LoggerFactory.getLogger(JenkinsService::class.java)
    }

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
                .doOnNext { logger.debug(it.toString()) }
                .map { buildInfo ->
                    val params = buildInfo.actions().singleOrNull { it.parameters().isNotEmpty() }?.parameters()
                    val branch = params?.singleOrNull { it.name() == PARAM_BRANCH }?.value() ?: ""
                    val ver = buildInfo.artifacts().firstOrNull { it.fileName().contains(".apk") }?.fileName()?.substringBefore(".apk")
                            ?: ""
                    val buildType = params?.singleOrNull { it.name() == PARAM_BUILD_TYPE }?.value() ?: ""
                    val category = params?.singleOrNull { it.name() == PARAM_CATEGORY }?.value() ?: ""
                    val content = params?.singleOrNull { it.name() == PARAM_CONTENT }?.value() ?: ""
                    val apkRelPath = buildInfo.artifacts().firstOrNull { it.fileName().contains(".apk") }?.relativePath()
                    val innerUrl = if (buildInfo.result() == "SUCCESS") {
                        val buildNum = buildInfo.number()
                        "http://bugfree.ixiaochuan.cn/job/zuiyou_oversea/$buildNum/artifact/$apkRelPath"
                    } else {
                        ""
                    }
                    val outerUrl = if (buildInfo.result() == "SUCCESS") {
                        val apkFilename = buildInfo.artifacts().firstOrNull { it.fileName().contains(".apk") }?.fileName()
                        "https://apk.izuiyou.com/cocofun/android/$apkFilename"
                    } else {
                        ""
                    }
                    val result = when (buildInfo.result()) {
                        "SUCCESS" -> HISTORY_RESULT_OK
                        "FAILURE" -> HISTORY_RESULT_FAIL
                        "ABORTED" -> HISTORY_RESULT_CANCEL
                        else -> HISTORY_RESULT_UNKNOWN
                    }
                    val cause = buildInfo.actions().singleOrNull { it.causes().isNotEmpty() }?.causes()
                    val who = cause?.singleOrNull { it.userName().isNotEmpty() }?.userName() ?: ""
                    val createTime = LocalDateTime.ofEpochSecond(buildInfo.timestamp() / 1000, 0, ZoneOffset.UTC)

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
                            createTime,
                            LocalDateTime.now(),
                    )
                }
                .doOnNext { logger.debug(objectMapper.writeValueAsString(it)) }
    }
}

