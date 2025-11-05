package com.example.redisbookapp;

import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api/books")
public class BookController {

    private final BookService svc;
    private final SessionService sessionService;
    private static final String SESSION_COOKIE_NAME = "BOOK_SESSION";

    public BookController(BookService svc, SessionService sessionService) {
        this.svc = svc;
        this.sessionService = sessionService;
    }

    // ---------- Reads ----------
    @GetMapping
    public List<Book> list(){
        return svc.findAll();
    }

    @GetMapping("/{id}")
    public Book get(@PathVariable String id){
        return svc.findById(id).orElseThrow(() -> new IllegalArgumentException("Not found: " + id));
    }

    // ---------- Split updates ----------
    @PutMapping("/{id}/price")
    public Book updatePrice(@PathVariable String id, 
                           @RequestBody Map<String, Object> body,
                           @CookieValue(value = SESSION_COOKIE_NAME, required = false) String sessionId) {
        if (!body.containsKey("price")) {
            throw new IllegalArgumentException("Missing 'price' in request body");
        }
        
        User user = sessionService.getUserFromSession(sessionId);
        
        if (user == null) {
            throw new IllegalArgumentException("Invalid or expired session");
        }
        
        double price = Double.parseDouble(body.get("price").toString());
        return svc.updatePrice(id, price, user);
    }

    @PutMapping("/{id}/inventory")
    public Book updateInventory(@PathVariable String id, 
                               @RequestBody Map<String, Object> body,
                               @CookieValue(value = SESSION_COOKIE_NAME, required = false) String sessionId) {
        if (!body.containsKey("inventory")) {
            throw new IllegalArgumentException("Missing 'inventory' in request body");
        }
        
        User user = sessionService.getUserFromSession(sessionId);
        if (user == null) {
            throw new IllegalArgumentException("Invalid or expired session");
        }
        
        int inventory = Integer.parseInt(body.get("inventory").toString());
        return svc.updateInventory(id, inventory, user);
    }

    // ---------- Backward compatible combined update ----------
    @PutMapping("/{id}")
    public Book updatePriceInventory(@PathVariable String id, 
                                    @RequestBody Map<String, Object> body,
                                    @CookieValue(value = SESSION_COOKIE_NAME, required = false) String sessionId) {
        Double price = body.containsKey("price") ? Double.valueOf(body.get("price").toString()) : null;
        Integer inv  = body.containsKey("inventory") ? Integer.valueOf(body.get("inventory").toString()) : null;

        User user = sessionService.getUserFromSession(sessionId);
        if (user == null) {
            throw new IllegalArgumentException("Invalid or expired session");
        }

        return svc.updatePriceInventory(id, price, inv, user);
    }

    @ResponseStatus(HttpStatus.BAD_REQUEST)
    @ExceptionHandler({ IllegalArgumentException.class })
    public Map<String, String> handleBadRequest(IllegalArgumentException ex) {
        return Map.of("error", ex.getMessage());
    }

}