package com.heang.springmybatistest.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * Product 생성/수정 요청 DTO
 */
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class ProductRequest {

    private String name;        // 상품명
    private Integer price;      // 가격
    private Integer stock;      // 재고
    private Long categoryId;    // 카테고리 ID
}
