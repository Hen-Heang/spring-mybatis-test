package com.heang.springmybatistest.service;

import com.heang.springmybatistest.dto.ProductRequest;
import com.heang.springmybatistest.model.Product;

import java.util.List;

/**
 * Product Service Interface
 * Following a User service pattern (User 서비스 패턴 따름)
 */
public interface ProductService {

    List<Product> findAll();

    Product findById(Long id);

    List<Product> findByCategoryId(Long categoryId);

    Product create(ProductRequest request);

    Product update(Long id, ProductRequest request);

    void delete(Long id);

    int count();
}
