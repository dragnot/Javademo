package com.example.redisbookapp;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.CookieValue;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class PageController {

    private final SessionService sessionService;
    private static final String SESSION_COOKIE_NAME = "BOOK_SESSION";

    public PageController(SessionService sessionService) {
        this.sessionService = sessionService;
    }

    @GetMapping("/")
    public String root(@CookieValue(value = SESSION_COOKIE_NAME, required = false) String sessionId) {
        // Check if user has valid session
        if (sessionId != null && sessionService.isValidSession(sessionId)) {
            return "redirect:/books";
        }
        return "redirect:/welcome";
    }

    @GetMapping("/books")
    public String books(@CookieValue(value = SESSION_COOKIE_NAME, required = false) String sessionId) {
        // Ensure user has valid session to access books page
        if (sessionId == null || !sessionService.isValidSession(sessionId)) {
            return "redirect:/welcome";
        }
        return "index";
    }
}
