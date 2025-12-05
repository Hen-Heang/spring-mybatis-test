package com.heang.springmybatistest.mapper;

import com.heang.springmybatistest.dto.UserRequest;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;


@Mapper
public interface UserMapper {
    void insertUser(UserRequest userRequest);


}
