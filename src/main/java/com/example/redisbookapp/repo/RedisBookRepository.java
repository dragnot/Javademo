package com.example.redisbookapp.repo;

import com.example.redisbookapp.Book;
import org.springframework.stereotype.Repository;
import redis.clients.jedis.Jedis;
import redis.clients.jedis.JedisPool;
import redis.clients.jedis.params.ScanParams;
import redis.clients.jedis.resps.ScanResult;

import java.util.*;
import java.util.stream.Collectors;

@Repository
public class RedisBookRepository {

    private final JedisPool pool;

    public RedisBookRepository(JedisPool pool) {
        this.pool = pool;
    }

    // ----- low-level helpers -----
    private <T> T withJedis(RedisCall<T> call){
        try (Jedis j = pool.getResource()){
            return call.run(j);
        }
    }

    private interface RedisCall<T> { T run(Jedis j); }

    private String key(String id){ return "book:" + id; }

    private Map<String,String> readHash(String id){
        return withJedis(j -> j.hgetAll(key(id)));
    }

    private void hset(String id, String field, String value){
        withJedis(j -> { j.hset(key(id), field, value); return null; });
    }

    public boolean exists(String id){
        return withJedis(j -> j.exists(key(id)));
    }

    private List<String> scanIds() {
        return withJedis(j -> {
            String cursor = ScanParams.SCAN_POINTER_START;
            List<String> ids = new ArrayList<>();
            ScanParams params = new ScanParams().match("book:*").count(500);
            do {
                ScanResult<String> res = j.scan(cursor, params);
                for (String k : res.getResult()) {
                    if (k.startsWith("book:")) ids.add(k.substring(5));
                }
                cursor = res.getCursor();
            } while (!"0".equals(cursor));
            return ids.stream().distinct().collect(Collectors.toList());
        });
    }

    // ----- domain read -----
    public Optional<Book> findById(String id) {
        Map<String,String> h = readHash(id);
        if (h == null || h.isEmpty()) return Optional.empty();
        return Optional.of(map(id, h));
    }

    public List<Book> findAll() {
        List<String> ids = scanIds();
        return withJedis(j -> {
            List<Book> out = new ArrayList<>(ids.size());
            for (String id : ids) {
                Map<String,String> h = j.hgetAll(key(id));
                if (h != null && !h.isEmpty()) out.add(map(id, h));
            }
            out.sort(Comparator.comparingInt(b -> {
                try { return Integer.parseInt(b.getId()); }
                catch (Exception e) { return Integer.MAX_VALUE; }
            }));
            return out;
        });
    }

    // ----- domain write -----
    public void updatePrice(String id, double price) {
        // First get the book from Redis to ensure it exists and we have the full object
        Optional<Book> bookOpt = findById(id);
        if (bookOpt.isEmpty()) {
            throw new NoSuchElementException("Book not found: id=" + id);
        }
        // Now update the price
        hset(id, "price", String.valueOf(price));
    }

    public void updateInventory(String id, int inventory) {
        // First get the book from Redis to ensure it exists and we have the full object
        Optional<Book> bookOpt = findById(id);
        if (bookOpt.isEmpty()) {
            throw new NoSuchElementException("Book not found: id=" + id);
        }
        // Now update the inventory
        hset(id, "inventory", String.valueOf(inventory));
    }

    public void updateAttribution(String id, String username, String firstName, String lastName, String isoTs) {
        withJedis(j -> {
            Map<String,String> fields = new HashMap<>();
            fields.put("lastUpdatedByUsername", username == null ? "" : username);
            fields.put("lastUpdatedByFirstName", firstName == null ? "" : firstName);
            fields.put("lastUpdatedByLastName",  lastName == null ? "" : lastName);
            fields.put("lastUpdatedAt",          isoTs == null ? "" : isoTs);
            j.hset(key(id), fields);
            return null;
        });
    }

    // ----- mapping -----
    private Book map(String id, Map<String,String> m) {
        Book b = new Book();
        b.setId(id);
        b.setName(m.getOrDefault("name",""));
        b.setAuthor(m.getOrDefault("author",""));
        b.setIsbn(m.getOrDefault("isbn",""));
        b.setCategory(m.getOrDefault("category",""));
        try { b.setInventory(Integer.parseInt(m.getOrDefault("inventory","0"))); }
        catch (Exception e) { b.setInventory(0); }
        try { b.setPrice(Double.parseDouble(m.getOrDefault("price","0"))); }
        catch (Exception e) { b.setPrice(0.0); }

        b.setLastUpdatedByUsername(m.getOrDefault("lastUpdatedByUsername",""));
        b.setLastUpdatedByFirstName(m.getOrDefault("lastUpdatedByFirstName",""));
        b.setLastUpdatedByLastName(m.getOrDefault("lastUpdatedByLastName",""));
        b.setLastUpdatedAt(m.getOrDefault("lastUpdatedAt",""));
        return b;
    }
}