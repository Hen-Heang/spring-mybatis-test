package com.heang.springmybatistest.service;

import com.heang.springmybatistest.dto.RegisterRequest;
import com.heang.springmybatistest.mapper.UserMapper;
import com.heang.springmybatistest.model.Users;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 * Authentication Service (인증 서비스)
 * <p>
 * 회원가입, 비밀번호 변경 등 인증 관련 비즈니스 로직
 * 한국 기업 프로젝트 표준 패턴
 */
@Service
@RequiredArgsConstructor
@Slf4j
@Transactional
public class AuthService {

    private final UserMapper userMapper;
    private final PasswordEncoder passwordEncoder;

    /**
     * 회원가입
     *
     * @param request 회원가입 요청 DTO
     */
    public void register(RegisterRequest request) {
        log.info("회원가입 요청: {}", request.getUsername());

        // 1. 비밀번호 확인 일치 검증
        if (!request.isPasswordMatching()) {
            throw new IllegalArgumentException("비밀번호가 일치하지 않습니다.");
        }

        // 2. 아이디 중복 검사
        if (userMapper.countByUsername(request.getUsername()) > 0) {
            throw new IllegalArgumentException("이미 사용 중인 아이디입니다.");
        }

        // 3. 이메일 중복 검사
        if (userMapper.countByEmail(request.getEmail()) > 0) {
            throw new IllegalArgumentException("이미 사용 중인 이메일입니다.");
        }

        // 4. 비밀번호 암호화 (Bcrypt)
        String encodedPassword = passwordEncoder.encode(request.getPassword());

        // 5. 사용자 엔티티 생성
        Users user = Users.builder()
                .username(request.getUsername())
                .email(request.getEmail())
                .password(encodedPassword)
                .name(request.getName())
                .phone(request.getPhone())
                .role("ROLE_USER")    // 기본 권한: 일반 사용자
                .status("ACTIVE")      // 기본 상태: 활성
                .build();

        // 6. DB 저장
        userMapper.insertUserWithPassword(user);

        log.info("회원가입 완료: {}, ID: {}", user.getUsername(), user.getId());
    }

    /**
     * 비밀번호 변경
     *
     * @param userId 사용자 ID
     * @param currentPassword 현재 비밀번호
     * @param newPassword 새 비밀번호
     */
    public void changePassword(Long userId, String currentPassword, String newPassword) {
        log.info("비밀번호 변경 요청: userId={}", userId);

        // 1. 사용자 조회
        Users user = userMapper.selectUserById(userId);
        if (user == null) {
            throw new IllegalArgumentException("사용자를 찾을 수 없습니다.");
        }

        // 2. 현재 비밀번호 확인
        if (!passwordEncoder.matches(currentPassword, user.getPassword())) {
            throw new IllegalArgumentException("현재 비밀번호가 올바르지 않습니다.");
        }

        // 3. 새 비밀번호 암호화 및 저장
        String encodedPassword = passwordEncoder.encode(newPassword);
        userMapper.updatePassword(userId, encodedPassword);

        log.info("비밀번호 변경 완료: userId={}", userId);
    }
    
    /**
     * 아이디 중복 확인
     */
    @Transactional(readOnly = true)
    public boolean isUsernameAvailable(String username) {
        return userMapper.countByUsername(username) == 0;
    }

    /**
     * 이메일 중복 확인
     */
    @Transactional(readOnly = true)
    public boolean isEmailAvailable(String email) {
        return userMapper.countByEmail(email) == 0;
    }
}
