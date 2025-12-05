package com.heang.springmybatistest.model;


import lombok.*;

import java.time.LocalDateTime;

@Getter
@Setter

@NoArgsConstructor


public class Users {

    private Long id;

    private String username;

    private String email;

    private String status;

    private LocalDateTime createdAt;


}
