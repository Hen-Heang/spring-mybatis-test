package com.heang.springmybatistest.service;


import com.heang.springmybatistest.dto.UserRequest;
import com.heang.springmybatistest.dto.UserResponse;
import com.heang.springmybatistest.mapper.UserDtoMapper;
import com.heang.springmybatistest.mapper.UserMapper;
import com.heang.springmybatistest.model.Users;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;
import java.util.List;

@Service
@AllArgsConstructor

public class UserServiceImpl implements  UserService {

    private final UserMapper userMapper;
    private final UserDtoMapper userDtoMapper;


    @Override
    public void createuser(UserRequest userRequest) {
        userMapper.insertUser(userRequest);
    }

    @Override
    public List<UserResponse> getAllUsers() {
        List<Users> users = userMapper.selectUserList();
        return userDtoMapper.toUserResponseList(users);
    }
}
