package com.heang.springmybatistest.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * Category create/update request DTO (카테고리 생성/수정 요청 DTO)
 */
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class CategoryRequest {

    private String name;  // Category name (카테고리명)
}
