package com.heang.springmybatistest.configuration;

import com.heang.springmybatistest.mapper.UserMapper;
import com.heang.springmybatistest.model.Users;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.jspecify.annotations.NonNull;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import java.util.Collections;

/**
 * Custom UserDetailsService (커스텀 사용자 인증 서비스)
 * <p>
 * Spring Security의 UserDetailsService 구현
 * MyBatis를 통해 DB에서 사용자 정보 조회
 * <p>
 * 한국 기업 프로젝트에서 가장 많이 사용되는 패턴
 */
@Service
@RequiredArgsConstructor
@Slf4j
public class CustomUserDetailsService implements UserDetailsService {

    private final UserMapper userMapper;

    /**
     * 사용자명으로 사용자 정보 로드
     * Spring Security 로그인 시 자동 호출
     *
     * @param username 로그인 아이디
     * @return UserDetails (Spring Security 인증 객체)
     * @throws UsernameNotFoundException 사용자를 찾을 수 없을 때
     */
    @Override
    public UserDetails loadUserByUsername(@NonNull String username) throws UsernameNotFoundException {
        log.debug("로그인 시도: {}", username);

        // DB에서 사용자 조회
        Users user = userMapper.selectUserByUsername(username);

        if (user == null) {
            log.warn("사용자를 찾을 수 없음: {}", username);
            throw new UsernameNotFoundException("사용자를 찾을 수 없습니다: " + username);
        }

        // 계정 상태 확인
        if (!"ACTIVE".equals(user.getStatus())) {
            log.warn("비활성화된 계정 로그인 시도: {}", username);
            throw new UsernameNotFoundException("비활성화된 계정입니다: " + username);
        }

        log.info("로그인 성공: {}, 권한: {}", username, user.getRole());

        // Spring Security UserDetails 객체 생성
        return User.builder()
                .username(user.getUsername())
                .password(user.getPassword())  // BCrypt 암호화된 비밀번호
                .authorities(Collections.singletonList(
                        new SimpleGrantedAuthority(user.getRole())  // ROLE_USER or ROLE_ADMIN
                ))
                .accountExpired(false)
                .accountLocked(false)
                .credentialsExpired(false)
                .disabled(!"ACTIVE".equals(user.getStatus()))
                .build();
    }
}
