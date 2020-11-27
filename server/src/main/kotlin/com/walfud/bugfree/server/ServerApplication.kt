package com.walfud.bugfree.server

import org.springframework.boot.autoconfigure.SpringBootApplication
import org.springframework.boot.runApplication
import org.springframework.data.web.ReactivePageableHandlerMethodArgumentResolver
import org.springframework.data.web.ReactiveSortHandlerMethodArgumentResolver
import org.springframework.http.HttpHeaders
import org.springframework.scheduling.annotation.EnableScheduling
import org.springframework.stereotype.Component
import org.springframework.web.reactive.config.WebFluxConfigurer
import org.springframework.web.reactive.result.method.annotation.ArgumentResolverConfigurer
import org.springframework.web.server.ServerWebExchange
import org.springframework.web.server.WebFilter
import org.springframework.web.server.WebFilterChain
import reactor.core.publisher.Mono


@SpringBootApplication
@EnableScheduling
class ServerApplication

@Component
class CorsFilter : WebFilter {
    override fun filter(exchange: ServerWebExchange, chain: WebFilterChain): Mono<Void> {
        val mutatedExchange = exchange.mutate().request(exchange.request).build()
        mutatedExchange.response.headers.set(HttpHeaders.ACCESS_CONTROL_ALLOW_ORIGIN, "*")
        return chain.filter(mutatedExchange)
    }
}

@Component
class MyWebFluxConfigurer : WebFluxConfigurer {
    override fun configureArgumentResolvers(configurer: ArgumentResolverConfigurer) {
        configurer.addCustomResolver(ReactiveSortHandlerMethodArgumentResolver(), ReactivePageableHandlerMethodArgumentResolver())
    }
}

fun main(args: Array<String>) {
    runApplication<ServerApplication>(*args)
}