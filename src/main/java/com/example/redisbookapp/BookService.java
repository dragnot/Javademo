package com.example.redisbookapp;

import com.example.redisbookapp.repo.RedisBookRepository;
import org.springframework.stereotype.Service;

import java.time.Instant;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.NoSuchElementException;
import java.util.Optional;

@Service
public class BookService {

    private final RedisBookRepository repo;

    public BookService(RedisBookRepository repo) {
        this.repo = repo;
    }

    public List<Book> findAll() {
        return repo.findAll();
    }

    public Optional<Book> findById(String id) {
        return repo.findById(id);
    }

    public Book updatePrice(String id, double price, User byUser){
        // First get the book from Redis and put it in a Book object
        Book book = repo.findById(id)
                .orElseThrow(() -> new NoSuchElementException("Book not found: id=" + id));
        
        // Validate book exists (book object is now loaded from Redis)
        if (book == null) {
            throw new NoSuchElementException("Book not found: id=" + id);
        }
        
        // Now update Redis with the new price
        repo.updatePrice(id, price);
        
        // Update attribution
        repo.updateAttribution(
                id,
                byUser.getUsername(),
                byUser.getFirstName(),
                byUser.getLastName(),
                DateTimeFormatter.ISO_INSTANT.format(Instant.now())
        );
        
        return repo.findById(id)
                .orElseThrow(() -> new NoSuchElementException("Book not found after update: " + id));
    }

    public Book updateInventory(String id, int inventory, User byUser){
        // First get the book from Redis and put it in a Book object
        Book book = repo.findById(id)
                .orElseThrow(() -> new NoSuchElementException("Book not found: id=" + id));
        
        // Validate book exists (book object is now loaded from Redis)
        if (book == null) {
            throw new NoSuchElementException("Book not found: id=" + id);
        }
        
        // Now update Redis with the new inventory
        repo.updateInventory(id, inventory);
        
        // Update attribution
        repo.updateAttribution(
                id,
                byUser.getUsername(),
                byUser.getFirstName(),
                byUser.getLastName(),
                DateTimeFormatter.ISO_INSTANT.format(Instant.now())
        );
        
        return repo.findById(id)
                .orElseThrow(() -> new NoSuchElementException("Book not found after update: " + id));
    }

    /** Backward-compatible combined update (optional). */
    public Book updatePriceInventory(String id, Double price, Integer inventory, User byUser) {
        if (price == null && inventory == null) {
            throw new IllegalArgumentException("Provide price and/or inventory");
        }
        
        // First get the book from Redis and put it in a Book object
        Book book = repo.findById(id)
                .orElseThrow(() -> new NoSuchElementException("Book not found: id=" + id));
        
        // Validate book exists (book object is now loaded from Redis)
        if (book == null) {
            throw new NoSuchElementException("Book not found: id=" + id);
        }
        
        // Now update Redis with the new values
        if (price != null) repo.updatePrice(id, price.doubleValue());
        if (inventory != null) repo.updateInventory(id, inventory.intValue());

        // Update attribution
        repo.updateAttribution(
                id,
                byUser.getUsername(),
                byUser.getFirstName(),
                byUser.getLastName(),
                DateTimeFormatter.ISO_INSTANT.format(Instant.now())
        );

        return repo.findById(id)
                .orElseThrow(() -> new NoSuchElementException("Book not found after update: " + id));
    }
}