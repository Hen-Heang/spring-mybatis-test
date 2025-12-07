package com.heang.springmybatistest.mapper;

import com.heang.springmybatistest.dto.UserRequest;
import com.heang.springmybatistest.dto.UserUpdateRequest;
import com.heang.springmybatistest.model.Users;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;


@Mapper
public interface UserMapper {
    void insertUser(UserRequest userRequest);
    List <Users> selectUserList();
    void updateUser(@Param("id") Long id,
                    @Param("req") UserUpdateRequest userRequest);
    Users selectUserById(Long id);
    void deleteUser(Long id);

}
