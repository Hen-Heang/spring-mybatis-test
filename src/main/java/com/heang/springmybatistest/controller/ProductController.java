package com.heang.springmybatistest.controller;

import com.heang.springmybatistest.common.api.ApiResponse;
import com.heang.springmybatistest.dto.ProductRequest;
import com.heang.springmybatistest.model.Product;
import com.heang.springmybatistest.service.ProductService;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * Product REST API Controller
 * Following User controller pattern (User 컨트롤러 패턴 따름)
 */
@RestController
@RequestMapping("/api/products")
@RequiredArgsConstructor
public class ProductController {

    private final ProductService productService;

    @GetMapping
    public ApiResponse<List<Product>> findAll() {
        List<Product> products = productService.findAll();
        return ApiResponse.success(products);
    }

    @GetMapping("/{id}")
    public ApiResponse<Product> findById(@PathVariable Long id) {
        Product product = productService.findById(id);
        return ApiResponse.success(product);
    }

    @GetMapping("/category/{categoryId}")
    public ApiResponse<List<Product>> findByCategoryId(@PathVariable Long categoryId) {
        List<Product> products = productService.findByCategoryId(categoryId);
        return ApiResponse.success(products);
    }

    @PostMapping
    public ApiResponse<Product> create(@RequestBody ProductRequest request) {
        Product product = productService.create(request);
        return ApiResponse.success(product);
    }

    @PutMapping("/{id}")
    public ApiResponse<Product> update(@PathVariable Long id, @RequestBody ProductRequest request) {
        Product product = productService.update(id, request);
        return ApiResponse.success(product);
    }

    @DeleteMapping("/{id}")
    public ApiResponse<Void> delete(@PathVariable Long id) {
        productService.delete(id);
        return ApiResponse.success(null);
    }
}
