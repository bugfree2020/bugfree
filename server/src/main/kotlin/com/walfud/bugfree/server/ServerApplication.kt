package com.walfud.bugfree.server

import io.r2dbc.pool.ConnectionPool
import io.r2dbc.pool.ConnectionPoolConfiguration
import io.r2dbc.pool.PoolingConnectionFactoryProvider.MAX_SIZE
import io.r2dbc.spi.ConnectionFactories
import io.r2dbc.spi.ConnectionFactory
import io.r2dbc.spi.ConnectionFactoryOptions
import io.r2dbc.spi.ConnectionFactoryOptions.*
import org.springframework.boot.autoconfigure.SpringBootApplication
import org.springframework.boot.runApplication
import org.springframework.context.annotation.Bean
import org.springframework.context.annotation.Configuration
import org.springframework.data.r2dbc.config.AbstractR2dbcConfiguration
import java.time.Duration

@SpringBootApplication
class ServerApplication

fun main(args: Array<String>) {
    runApplication<ServerApplication>(*args)
}

@Configuration
class R2dbcConfiguration : AbstractR2dbcConfiguration() {

    @Bean
    override fun connectionFactory(): ConnectionFactory {
        val connFactory = ConnectionFactories.get(
                ConnectionFactoryOptions.builder()
                        .option(DRIVER, "pool")
                        .option(PROTOCOL, "mysql")
                        .option(HOST, "127.0.0.1")
                        .option(PORT, 3306)
                        .option(USER, "test")
                        .option(PASSWORD, "123456")
                        .option(DATABASE, "bugfree")
                        .option(MAX_SIZE, 30)
                        .build()
        )
        val connConfig = ConnectionPoolConfiguration.builder(connFactory)
                .maxIdleTime(Duration.ofMinutes(10))
                .initialSize(5)
                .maxSize(30)
                .maxCreateConnectionTime(Duration.ofSeconds(1))
                .build()

        return ConnectionPool(connConfig)
    }

}