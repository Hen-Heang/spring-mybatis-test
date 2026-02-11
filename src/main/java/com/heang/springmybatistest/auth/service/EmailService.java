package com.heang.springmybatistest.auth.service;

public interface EmailService {
    void sendSimpleMail(String recipient, String msgBody, String subject);

    void sendOtpEmail(String recipient, String otp, String subject);
}
