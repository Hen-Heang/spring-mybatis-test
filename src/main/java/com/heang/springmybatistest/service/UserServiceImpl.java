package com.heang.springmybatistest.service;


import com.heang.springmybatistest.dto.UserRequest;
import com.heang.springmybatistest.mapper.UserMapper;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;

@Service
@AllArgsConstructor

public class UserServiceImpl implements  UserService {

    private final UserMapper userMapper;


    @Override
    public void createuser(UserRequest userRequest) {
        userMapper.insertUser(userRequest);
    }
}
