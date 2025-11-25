package com.example.bookappdemo;

import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletResponse;
import java.util.Map;

@Controller
public class WelcomeController {

    private final SessionService sessionService;
    private static final String SESSION_COOKIE_NAME = "BOOK_SESSION";

    public WelcomeController(SessionService sessionService) {
        this.sessionService = sessionService;
    }

    @GetMapping("/welcome")
    public String welcome() {
        return "welcome";
    }

    @PostMapping("/api/login")
    @ResponseBody
    public ResponseEntity<Map<String, String>> login(@RequestBody Map<String, String> request, HttpServletResponse response) {
        String username = request.get("username");
        String firstName = request.get("firstName");
        String lastName = request.get("lastName");

        if (username == null || username.trim().isEmpty()) {
            return ResponseEntity.badRequest().body(Map.of("error", "Username is required"));
        }

        // Create session
        String sessionId = sessionService.createSession(username.trim(), firstName, lastName);

        // Set session cookie
        Cookie sessionCookie = new Cookie(SESSION_COOKIE_NAME, sessionId);
        sessionCookie.setHttpOnly(true);
        sessionCookie.setPath("/");
        sessionCookie.setMaxAge(3600); // 1 hour
        response.addCookie(sessionCookie);

        return ResponseEntity.ok(Map.of(
            "success", "true",
            "username", username.trim()
        ));
    }

    @PostMapping("/api/logout")
    @ResponseBody
    public ResponseEntity<Map<String, String>> logout(@CookieValue(value = SESSION_COOKIE_NAME, required = false) String sessionId, 
                                                     HttpServletResponse response) {
        if (sessionId != null) {
            sessionService.deleteSession(sessionId);
        }

        // Clear session cookie
        Cookie sessionCookie = new Cookie(SESSION_COOKIE_NAME, "");
        sessionCookie.setHttpOnly(true);
        sessionCookie.setPath("/");
        sessionCookie.setMaxAge(0); // Delete cookie
        response.addCookie(sessionCookie);

        return ResponseEntity.ok(Map.of("success", "true"));
    }

    @GetMapping("/api/session")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> getSession(@CookieValue(value = SESSION_COOKIE_NAME, required = false) String sessionId) {
        if (sessionId == null) {
            return ResponseEntity.ok(Map.of("authenticated", false));
        }

        User user = sessionService.getUserFromSession(sessionId);
        if (user == null) {
            return ResponseEntity.ok(Map.of("authenticated", false));
        }

        return ResponseEntity.ok(Map.of(
            "authenticated", true,
            "user", Map.of(
                "username", user.getUsername(),
                "firstName", user.getFirstName() != null ? user.getFirstName() : "",
                "lastName", user.getLastName() != null ? user.getLastName() : ""
            )
        ));
    }
}



