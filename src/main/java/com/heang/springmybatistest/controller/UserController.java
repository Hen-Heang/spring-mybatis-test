package com.heang.springmybatistest.controller;

import com.heang.springmybatistest.common.api.ApiResponse;
import com.heang.springmybatistest.dto.UserRequest;
import com.heang.springmybatistest.dto.UserResponse;
import com.heang.springmybatistest.dto.UserUpdateRequest;
import com.heang.springmybatistest.service.UserService;
import jakarta.validation.Valid;
import lombok.AllArgsConstructor;
import org.springframework.web.bind.annotation.*;
import java.util.List;

@RestController
@RequestMapping("/users")
@AllArgsConstructor
@CrossOrigin(origins = "*")

public class UserController {
    private final UserService userService;

//    Create a new user
    @PostMapping
    public ApiResponse<Void> createUser(
            @Valid @RequestBody UserRequest userRequest
            ) {

        userService.createuser(userRequest);
        return ApiResponse.success(null);
    }

//    Get All Users
    @GetMapping
    public ApiResponse<List<UserResponse>> getUserList() {
        List<UserResponse> users = userService.getAllUsers();
        return ApiResponse.success(users);
    }

    @PutMapping("/{id}")
    public ApiResponse<UserResponse> updateUser(
            @PathVariable Long id,
            @Valid @RequestBody UserUpdateRequest userUpdateRequest
    ) {
        UserResponse userResponse = userService.updateUser(id, userUpdateRequest);
        return ApiResponse.success(userResponse);
    }

    @GetMapping("/{id}")
    public ApiResponse<UserResponse> getUserById(
            @PathVariable Long id
    ) {
        UserResponse userResponse = userService.getUserById(id);
        return ApiResponse.success(userResponse);
    }

    @DeleteMapping("/{id}")
    public ApiResponse<Void> deleteUser(
            @PathVariable Long id
    ) {

     userService.deleteUser(id);
        return ApiResponse.success(null);
    }
}
