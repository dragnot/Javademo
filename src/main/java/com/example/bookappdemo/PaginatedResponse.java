package com.example.bookappdemo;

import java.util.List;

public class PaginatedResponse<T> {
    private List<T> content;
    private int currentPage;
    private int pageSize;
    private long totalItems;
    private int totalPages;

    public PaginatedResponse(List<T> content, int currentPage, int pageSize, long totalItems) {
        this.content = content;
        this.currentPage = currentPage;
        this.pageSize = pageSize;
        this.totalItems = totalItems;
        this.totalPages = (int) Math.ceil((double) totalItems / pageSize);
    }

    public List<T> getContent() {
        return content;
    }

    public void setContent(List<T> content) {
        this.content = content;
    }

    public int getCurrentPage() {
        return currentPage;
    }

    public void setCurrentPage(int currentPage) {
        this.currentPage = currentPage;
    }

    public int getPageSize() {
        return pageSize;
    }

    public void setPageSize(int pageSize) {
        this.pageSize = pageSize;
    }

    public long getTotalItems() {
        return totalItems;
    }

    public void setTotalItems(long totalItems) {
        this.totalItems = totalItems;
    }

    public int getTotalPages() {
        return totalPages;
    }

    public void setTotalPages(int totalPages) {
        this.totalPages = totalPages;
    }

    public boolean hasNext() {
        return currentPage < totalPages;
    }

    public boolean hasPrevious() {
        return currentPage > 1;
    }
}



