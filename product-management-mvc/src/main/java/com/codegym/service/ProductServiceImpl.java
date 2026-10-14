package com.codegym.service;

import com.codegym.model.Product;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class ProductServiceImpl implements ProductService {
    private static final Map<Integer, Product> products;

    static {
        products = new HashMap<>();
        products.put(1, new Product(1, "iPhone 15 Pro", 27990000.0, "Titan tự nhiên, chip A17 Pro mạnh mẽ", "Apple"));
        products.put(2, new Product(2, "Samsung Galaxy S24 Ultra", 29990000.0, "Galaxy AI, màn hình 6.8 inch Dynamic AMOLED 2X", "Samsung"));
        products.put(3, new Product(3, "MacBook Air M3", 26490000.0, "Màn hình 13.6 inch Liquid Retina, pin 18 giờ", "Apple"));
        products.put(4, new Product(4, "Sony WH-1000XM5", 7990000.0, "Tai nghe chống ồn chủ động không dây cao cấp", "Sony"));
        products.put(5, new Product(5, "Dell XPS 13 Plus", 34500000.0, "Core i7 1360P, màn hình OLED 3.5K cảm ứng", "Dell"));
        products.put(6, new Product(6, "iPad Pro M2", 21990000.0, "Màn hình 11 inch 120Hz Liquid Retina ProMotion", "Apple"));
    }

    @Override
    public List<Product> findAll() {
        return new ArrayList<>(products.values());
    }

    @Override
    public void save(Product product) {
        products.put(product.getId(), product);
    }

    @Override
    public Product findById(int id) {
        return products.get(id);
    }

    @Override
    public void update(int id, Product product) {
        products.put(id, product);
    }

    @Override
    public void remove(int id) {
        products.remove(id);
    }

    @Override
    public List<Product> findByName(String name) {
        List<Product> result = new ArrayList<>();
        if (name == null || name.trim().isEmpty()) {
            return findAll();
        }
        String keyword = name.trim().toLowerCase();
        for (Product product : products.values()) {
            if (product.getName().toLowerCase().contains(keyword) ||
                product.getManufacturer().toLowerCase().contains(keyword)) {
                result.add(product);
            }
        }
        return result;
    }
}
