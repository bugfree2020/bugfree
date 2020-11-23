package com.walfud.bugfree.server.jenkins

import com.cdancy.jenkins.rest.JenkinsClient
import org.springframework.context.annotation.Bean
import org.springframework.stereotype.Component

@Component
class JenkinsConfiguration {
    @Bean
    fun jenkinsClient(): JenkinsClient = JenkinsClient.builder()
            .endPoint("http://bugfree.ixiaochuan.cn")
            .credentials("admin:123456")
            .build()
}