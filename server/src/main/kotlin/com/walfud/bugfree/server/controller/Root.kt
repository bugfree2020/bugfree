package com.walfud.bugfree.server.controller

import org.springframework.web.bind.annotation.GetMapping
import org.springframework.web.bind.annotation.RestController

@RestController
class Root {

    @GetMapping
    fun hello(): String {
        return "hello, bugfree!"
    }

}