package com.heang.springmybatistest.service;


import com.heang.springmybatistest.dto.UserRequest;
import com.heang.springmybatistest.dto.UserResponse;
import com.heang.springmybatistest.dto.UserUpdateRequest;
import com.heang.springmybatistest.mapper.UserDtoMapper;
import com.heang.springmybatistest.mapper.UserMapper;
import com.heang.springmybatistest.model.Users;
import jakarta.validation.Valid;
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

    @Override
    public Users selectUserById(Long id) {
        return null;
    }

    @Override
    public UserResponse updateUser(Long id, @Valid UserUpdateRequest userUpdateRequest) {

//        Update user logic to be implemented
        userMapper.updateUser(id, userUpdateRequest);

        Users getUserUpdate = userMapper.selectUserById(id);
        return userDtoMapper.toUserResponse(getUserUpdate);
    }

    @Override
    public UserResponse getUserById(Long id) {
        Users user = userMapper.selectUserById(id);
        if (user == null) {
            throw new RuntimeException("User not found with id: " + id);
        }
            return userDtoMapper.toUserResponse(user);
}

    @Override
    public void deleteUser(Long id) {
        // Delete user logic to be implemented
        Users userExist = userMapper.selectUserById(id);
        if(userExist == null){
            throw new RuntimeException("User not found with id: " + id);

        }
        userMapper.deleteUser(id);
    }
}
