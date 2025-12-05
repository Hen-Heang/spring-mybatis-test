package com.heang.springmybatistest.controller;

import com.heang.springmybatistest.common.ApiResponse;
import com.heang.springmybatistest.dto.UserRequest;
import com.heang.springmybatistest.dto.UserResponse;
import com.heang.springmybatistest.service.UserService;
import jakarta.validation.Valid;
import lombok.AllArgsConstructor;
import org.springframework.web.bind.annotation.*;
import java.util.List;

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

//    Get All Users
    @GetMapping
    public ApiResponse<List<UserResponse>> getUserList() {
        List<UserResponse> users = userService.getAllUsers();
        return ApiResponse.success(users);
    }




}
