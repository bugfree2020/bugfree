package com.walfud.bugfree.server.root

import org.springframework.web.bind.annotation.GetMapping
import org.springframework.web.bind.annotation.RestController

@RestController
class Root {

    @GetMapping("hello")
    fun hello(): String {
        return "hello, bugfree!"
    }

//    @GetMapping
//    fun health(): String {
//        TODO("db")
//    }

}