//package com.heang.springmybatistest.config;
//
//import org.springframework.context.annotation.Bean;
//import org.springframework.context.annotation.Configuration;
//import org.springframework.security.authentication.AuthenticationManager;
//import org.springframework.security.authentication.ProviderManager;
//import org.springframework.security.authentication.dao.DaoAuthenticationProvider;
//import org.springframework.security.config.annotation.web.builders.HttpSecurity;
//import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
//import org.springframework.security.config.annotation.web.configurers.AbstractHttpConfigurer;
//import org.springframework.security.core.userdetails.UserDetailsService;
//import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
//import org.springframework.security.crypto.password.PasswordEncoder;
//import org.springframework.security.web.SecurityFilterChain;
//
///**
// * Spring Security Configuration (스프링 시큐리티 설정)
// */
//@Configuration
//@EnableWebSecurity
//public class SecurityConfig {
//
//    @Bean
//    public PasswordEncoder passwordEncoder() {
//        return new BCryptPasswordEncoder();
//    }
//
//    @Bean
//    public AuthenticationManager authenticationManager(
//            UserDetailsService userDetailsService,
//            PasswordEncoder passwordEncoder) {
//        DaoAuthenticationProvider authProvider = new DaoAuthenticationProvider(userDetailsService);
//        authProvider.setPasswordEncoder(passwordEncoder);
//        return new ProviderManager(authProvider);
//    }
//
//    @Bean
//    public SecurityFilterChain securityFilterChain(HttpSecurity http) throws Exception {
//        http
//            .csrf(AbstractHttpConfigurer::disable)
//
//            .authorizeHttpRequests(auth -> auth
//                .requestMatchers("/css/**", "/js/**", "/images/**", "/favicon.ico").permitAll()
//                .requestMatchers("/login.html", "/auth/**").permitAll()
//                .requestMatchers("/error").permitAll()
//                .requestMatchers("/swagger-ui/**", "/v3/api-docs/**").permitAll()
//                .anyRequest().authenticated()
//            )
//
//            .formLogin(form -> form
//                .loginPage("/login.html")
//                .loginProcessingUrl("/auth/login-process")
//                .usernameParameter("username")
//                .passwordParameter("password")
//                .defaultSuccessUrl("/dashboard", true)
//                .failureUrl("/login.html?error=true")
//                .permitAll()
//            )
//
//            .logout(logout -> logout
//                .logoutUrl("/auth/logout")
//                .logoutSuccessUrl("/login.html?logout=true")
//                .invalidateHttpSession(true)
//                .deleteCookies("JSESSIONID")
//                .permitAll()
//            );
//
//        return http.build();
//    }
//}
