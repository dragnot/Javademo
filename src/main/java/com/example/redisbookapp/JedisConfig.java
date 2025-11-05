package com.example.redisbookapp;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import redis.clients.jedis.JedisPool;
import redis.clients.jedis.JedisPoolConfig;

@Configuration
public class JedisConfig {
    @Value("${app.redis.host:localhost}") private String host;
    @Value("${app.redis.port:6379}") private int port;
    @Bean public JedisPool jedisPool() {
        JedisPoolConfig cfg = new JedisPoolConfig();
        cfg.setMaxTotal(16); cfg.setMaxIdle(8); cfg.setMinIdle(1);
        return new JedisPool(cfg, host, port);
    }
}
