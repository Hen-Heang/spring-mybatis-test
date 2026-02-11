package com.heang.springmybatistest.auth.mapper;


import com.heang.springmybatistest.auth.dto.AppUserDto;
import com.heang.springmybatistest.auth.model.AppUser;
import org.apache.ibatis.annotations.Mapper;
import org.mapstruct.ReportingPolicy;

public interface AppUserStructMapper {

    AppUserDto toDto(AppUser user);

}
