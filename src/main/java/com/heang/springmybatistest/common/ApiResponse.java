package com.heang.springmybatistest.common;

import lombok.*;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder

public class ApiResponse<T> {

    private String resultCd;
    private String resultMsg;
    private T data;

    public static <T> ApiResponse<T> success(T data) {
        return ApiResponse.<T>builder()
                .resultCd("M0000")
                .resultMsg("Success")
                .data(data)
                .build();
    }

    public static <T> ApiResponse<T> success(String msg, T data) {
        return ApiResponse.<T>builder()
                .resultCd("M0000")
                .resultMsg(msg)
                .data(data)
                .build();
    }

    public static <T> ApiResponse<T> error(String code, String msg) {
        return ApiResponse.<T>builder()
                .resultCd(code)
                .resultMsg(msg)
                .data(null)
                .build();
    }


}
