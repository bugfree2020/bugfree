package com.walfud.bugfree.server

import com.walfud.bugfree.server.history.HistoryRepository
import com.walfud.bugfree.server.history.HistoryService
import com.walfud.bugfree.server.jenkins.JenkinsService
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.stereotype.Service

@Service
abstract class BaseService {
    @Autowired
    lateinit var historyRepository: HistoryRepository

    @Autowired
    lateinit var jenkinsService: JenkinsService
    @Autowired
    lateinit var historyService: HistoryService
}