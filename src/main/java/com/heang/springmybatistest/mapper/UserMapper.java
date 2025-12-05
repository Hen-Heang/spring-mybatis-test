package com.heang.springmybatistest.mapper;

import com.heang.springmybatistest.dto.UserRequest;
import com.heang.springmybatistest.model.Users;
import org.apache.ibatis.annotations.Mapper;
import java.util.List;


@Mapper
public interface UserMapper {
    void insertUser(UserRequest userRequest);
    List <Users> selectUserList();

}
