package com.example.bookappdemo;

import org.springframework.stereotype.Service;
import redis.clients.jedis.Jedis;
import redis.clients.jedis.JedisPool;

import java.time.Instant;
import java.time.format.DateTimeFormatter;
import java.util.UUID;

@Service
public class SessionService {

    private final JedisPool pool;
    private static final int SESSION_TIMEOUT = 3600; // 1 hour in seconds

    public SessionService(JedisPool pool) {
        this.pool = pool;
    }

    private <T> T withJedis(RedisCall<T> call) {
        try (Jedis j = pool.getResource()) {
            return call.run(j);
        }
    }

    private interface RedisCall<T> {
        T run(Jedis j);
    }

    /**
     * Create a new session for the user
     */
    public String createSession(String username, String firstName, String lastName) {
        String sessionId = UUID.randomUUID().toString();
        String sessionKey = "session:" + sessionId;
        
        return withJedis(j -> {
            j.hset(sessionKey, "username", username);
            j.hset(sessionKey, "firstName", firstName != null ? firstName : "");
            j.hset(sessionKey, "lastName", lastName != null ? lastName : "");
            j.hset(sessionKey, "createdAt", DateTimeFormatter.ISO_INSTANT.format(Instant.now()));
            j.expire(sessionKey, SESSION_TIMEOUT);
            return sessionId;
        });
    }

    /**
     * Get user from session
     */
    public User getUserFromSession(String sessionId) {
        if (sessionId == null || sessionId.isBlank()) {
            return null;
        }
        
        String sessionKey = "session:" + sessionId;
        return withJedis(j -> {
            if (!j.exists(sessionKey)) {
                return null;
            }
            
            String username = j.hget(sessionKey, "username");
            String firstName = j.hget(sessionKey, "firstName");
            String lastName = j.hget(sessionKey, "lastName");
            
            if (username == null || username.isBlank()) {
                return null;
            }
            
            // Refresh session expiry
            j.expire(sessionKey, SESSION_TIMEOUT);
            
            return new User(username, firstName, lastName);
        });
    }

    /**
     * Delete session
     */
    public void deleteSession(String sessionId) {
        if (sessionId == null || sessionId.isBlank()) {
            return;
        }
        
        String sessionKey = "session:" + sessionId;
        withJedis(j -> {
            j.del(sessionKey);
            return null;
        });
    }

    /**
     * Check if session exists and is valid
     */
    public boolean isValidSession(String sessionId) {
        if (sessionId == null || sessionId.isBlank()) {
            return false;
        }
        
        String sessionKey = "session:" + sessionId;
        return withJedis(j -> j.exists(sessionKey));
    }
}



