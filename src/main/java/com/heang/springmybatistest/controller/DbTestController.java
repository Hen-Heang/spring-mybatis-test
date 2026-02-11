package com.heang.springmybatistest.controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class DbTestController {

    private final TestMapper testMapper;

    public DbTestController(TestMapper testMapper) {
        this.testMapper = testMapper;
    }

    @GetMapping("/db-test")
    public String dbTest() {
        return testMapper.now();
    }
}
