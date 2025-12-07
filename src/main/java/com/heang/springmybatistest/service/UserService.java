package com.heang.springmybatistest.service;

import com.heang.springmybatistest.dto.UserRequest;
import com.heang.springmybatistest.dto.UserResponse;
import com.heang.springmybatistest.dto.UserUpdateRequest;
import com.heang.springmybatistest.model.Users;
import jakarta.validation.Valid;

import java.util.List;

public interface UserService {
    void createuser(@Valid UserRequest userRequest);

    List<UserResponse> getAllUsers();

    Users selectUserById(Long id);

    UserResponse updateUser(Long id , UserUpdateRequest userUpdateRequest);

    UserResponse getUserById(Long id);

    void deleteUser(Long id);
}
