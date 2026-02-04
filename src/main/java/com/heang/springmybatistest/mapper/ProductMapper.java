package com.heang.springmybatistest.mapper;

import com.heang.springmybatistest.dto.ProductRequest;
import com.heang.springmybatistest.model.Product;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * Product Mapper Interface
 * Following User mapper pattern (User 매퍼 패턴 따름)
 */
@Mapper
public interface ProductMapper {

    void insertProduct(ProductRequest productRequest);

    List<Product> selectProductList();

    Product selectProductById(Long id);

    List<Product> selectProductByCategoryId(Long categoryId);

    void updateProduct(@Param("id") Long id,
                       @Param("req") ProductRequest productRequest);

    void deleteProduct(Long id);

    int countProduct();

    int countProductByCategoryId(Long categoryId);
}
