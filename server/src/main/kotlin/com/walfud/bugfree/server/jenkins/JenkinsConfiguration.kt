package com.walfud.bugfree.server.jenkins

import com.cdancy.jenkins.rest.JenkinsClient
import org.springframework.context.annotation.Bean
import org.springframework.stereotype.Component

@Component
class JenkinsConfiguration {
    @Bean
    fun jenkinsClient(): JenkinsClient = JenkinsClient.builder()
            .endPoint("http://172.20.20.194:8080")
            .credentials("test:123456")
            .build()
}