package com.heang.springmybatistest.auth.service;


import com.heang.springmybatistest.auth.dto.AppUserDto;
import com.heang.springmybatistest.auth.dto.AppUserRequest;
import com.heang.springmybatistest.auth.model.JwtChangePasswordRequest;
import org.apache.ibatis.javassist.NotFoundException;

public interface JwtUserDetailsService {
    AppUserDto insertUser(AppUserRequest appUserRequest);

    boolean getVerifyEmail(String email);


    AppUserDto changePassword(JwtChangePasswordRequest request) throws NotFoundException;

    String forgetPassword(Integer otp, String email, String newPassword) throws NotFoundException;
}
