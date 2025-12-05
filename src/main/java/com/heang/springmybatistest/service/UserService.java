package com.heang.springmybatistest.service;

import com.heang.springmybatistest.dto.UserRequest;
import jakarta.validation.Valid;

public interface UserService {
    void createuser(@Valid UserRequest userRequest);
}
