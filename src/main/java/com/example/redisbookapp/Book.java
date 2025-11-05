package com.example.redisbookapp;

public class Book {
    private String id;
    private String name;
    private String author;
    private String isbn;
    private String category;
    private Integer inventory;
    private Double price;

    // Attribution fields
    private String lastUpdatedByUsername;
    private String lastUpdatedByFirstName;
    private String lastUpdatedByLastName;
    private String lastUpdatedAt; // ISO-8601 string

    public String getId(){return id;}
    public void setId(String id){this.id=id;}

    public String getName(){return name;}
    public void setName(String name){this.name=name;}

    public String getAuthor(){return author;}
    public void setAuthor(String author){this.author=author;}

    public String getIsbn(){return isbn;}
    public void setIsbn(String isbn){this.isbn=isbn;}

    public String getCategory(){return category;}
    public void setCategory(String category){this.category=category;}

    public Integer getInventory(){return inventory;}
    public void setInventory(Integer inventory){this.inventory=inventory;}

    public Double getPrice(){return price;}
    public void setPrice(Double price){this.price=price;}

    public String getLastUpdatedByUsername(){return lastUpdatedByUsername;}
    public void setLastUpdatedByUsername(String v){this.lastUpdatedByUsername=v;}

    public String getLastUpdatedByFirstName(){return lastUpdatedByFirstName;}
    public void setLastUpdatedByFirstName(String v){this.lastUpdatedByFirstName=v;}

    public String getLastUpdatedByLastName(){return lastUpdatedByLastName;}
    public void setLastUpdatedByLastName(String v){this.lastUpdatedByLastName=v;}

    public String getLastUpdatedAt(){return lastUpdatedAt;}
    public void setLastUpdatedAt(String v){this.lastUpdatedAt=v;}
}