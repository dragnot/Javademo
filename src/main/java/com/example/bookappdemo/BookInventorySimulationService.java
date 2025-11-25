package com.example.bookappdemo;

import jakarta.annotation.PostConstruct;
import jakarta.annotation.PreDestroy;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;
import java.util.Random;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.concurrent.atomic.AtomicBoolean;

@Service
public class BookInventorySimulationService {

    private static final Logger logger = LoggerFactory.getLogger(BookInventorySimulationService.class);

    private final BookService bookService;
    private final List<User> fakeUsers;
    private final Random random;
    private ExecutorService executorService;
    private final AtomicBoolean running = new AtomicBoolean(false);

    public BookInventorySimulationService(BookService bookService) {
        this.bookService = bookService;
        this.random = new Random();
        this.fakeUsers = createFakeUsers();
    }

    @PostConstruct
    public void start() {
        logger.info("Starting Book Inventory Simulation Service...");
        running.set(true);
        executorService = Executors.newSingleThreadExecutor(r -> {
            Thread t = new Thread(r, "book-inventory-simulator");
            t.setDaemon(true);
            return t;
        });

        executorService.submit(this::simulationLoop);
        logger.info("Book Inventory Simulation Service started with {} fake users", fakeUsers.size());
    }

    @PreDestroy
    public void stop() {
        logger.info("Stopping Book Inventory Simulation Service...");
        running.set(false);
        if (executorService != null) {
            executorService.shutdown();
        }
        logger.info("Book Inventory Simulation Service stopped");
    }

    private void simulationLoop() {
        while (running.get()) {
            try {
                // Wait 3 seconds
                Thread.sleep(3000);

                if (!running.get()) {
                    break;
                }

                // Get all books
                List<Book> books = bookService.findAll();

                if (books.isEmpty()) {
                    logger.debug("No books found, skipping inventory update");
                    continue;
                }

                // Randomly select a user
                User selectedUser = fakeUsers.get(random.nextInt(fakeUsers.size()));

                // Randomly select a book
                Book selectedBook = books.get(random.nextInt(books.size()));

                // Generate a random inventory change (-10 to +20)
                int currentInventory = selectedBook.getInventory() != null ? selectedBook.getInventory() : 0;
                int inventoryChange = random.nextInt(31) - 10; // -10 to +20
                int newInventory = Math.max(0, currentInventory + inventoryChange);

                // Update inventory
                // Log before attempting the update so we can trace who and what is being
                // changed
                logger.info("About to update inventory: Book ID={}, User={}, Old Inventory={}, New Inventory={}",
                        selectedBook.getId(),
                        selectedUser.getUsername(),
                        currentInventory,
                        newInventory);

                try {
                    bookService.updateInventory(selectedBook.getId(), newInventory, selectedUser);
                    logger.info("Simulated inventory update: Book ID={}, User={}, Old Inventory={}, New Inventory={}",
                            selectedBook.getId(),
                            selectedUser.getUsername(),
                            currentInventory,
                            newInventory);
                } catch (Exception e) {
                    logger.error("Error updating inventory for book {}: {}", selectedBook.getId(), e.getMessage());
                }

            } catch (InterruptedException e) {
                Thread.currentThread().interrupt();
                logger.info("Simulation thread interrupted");
                break;
            } catch (Exception e) {
                logger.error("Error in simulation loop: {}", e.getMessage(), e);
            }
        }
    }

    private List<User> createFakeUsers() {
        List<User> users = new ArrayList<>();

        users.add(new User("alice_smith", "Alice", "Smith"));
        users.add(new User("bob_jones", "Bob", "Jones"));
        users.add(new User("charlie_brown", "Charlie", "Brown"));
        users.add(new User("diana_prince", "Diana", "Prince"));
        users.add(new User("edward_norton", "Edward", "Norton"));
        users.add(new User("fiona_green", "Fiona", "Green"));
        users.add(new User("george_wilson", "George", "Wilson"));
        users.add(new User("hannah_martin", "Hannah", "Martin"));
        users.add(new User("isaac_newton", "Isaac", "Newton"));
        users.add(new User("julia_roberts", "Julia", "Roberts"));

        return users;
    }
}
