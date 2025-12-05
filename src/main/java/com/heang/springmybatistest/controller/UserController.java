package com.heang.springmybatistest.controller;

import com.heang.springmybatistest.common.ApiResponse;
import com.heang.springmybatistest.dto.UserRequest;
import com.heang.springmybatistest.service.UserService;
import jakarta.validation.Valid;
import lombok.AllArgsConstructor;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/users")
@AllArgsConstructor

public class UserController {
    private final UserService userService;

//    Create new user
    @PostMapping
    public ApiResponse<Void> createUser(
            @Valid @RequestBody UserRequest userRequest
            ) {
        userService.createuser(userRequest);
        return ApiResponse.success("User created successfully", null);

    }



}
