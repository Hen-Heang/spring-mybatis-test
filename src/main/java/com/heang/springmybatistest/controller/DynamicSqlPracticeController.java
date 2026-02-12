package com.heang.springmybatistest.controller;

import com.heang.springmybatistest.common.api.ApiResponse;
import com.heang.springmybatistest.dto.UserRequest;
import com.heang.springmybatistest.dto.UserResponse;
import com.heang.springmybatistest.dto.UserSearchRequest;
import com.heang.springmybatistest.service.DynamicSqlPracticeService;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

/**
 * Controller for practicing Dynamic SQL operations
 * <p>
 * Test these endpoints with Postman or any REST client
 */
@RestController
@RequestMapping("/api/practice")
@RequiredArgsConstructor
@CrossOrigin(origins = "*")
public class DynamicSqlPracticeController extends BaseController {

    private final DynamicSqlPracticeService practiceService;

    // =========================================================
    // PRACTICE 1: <if> tag - Conditional filters
    // =========================================================
    /**
     * GET /api/practice/search/if
     * <p>
     * Query Parameters (all optional):
     * - username: filter by username
     * - email: filter by email
     * - status: filter by status (ACTIVE, INACTIVE, etc.)
     * - keyword: search in username and email
     * - startDate: filter by created date (format: yyyy-MM-dd)
     * - endDate: filter by created date (format: yyyy-MM-dd)
     * <p>
     * Examples:
     * GET /api/practice/search/if -> all users
     * GET /api/practice/search/if?username=john -> users with username 'john'
     * GET /api/practice/search/if?status=ACTIVE -> active users
     * GET /api/practice/search/if?keyword=test -> users with 'test' in username or email
     */
    @GetMapping("/search/if")
    public ApiResponse<List<UserResponse>> searchWithIf(UserSearchRequest request) {
        List<UserResponse> users = practiceService.searchWithIf(request);
        return ApiResponse.success(users);
    }

    // =========================================================
    // PRACTICE 2: <choose><when><otherwise> - Dynamic sorting
    // =========================================================
    /**
     * GET /api/practice/search/choose
     * <p>
     * Query Parameters:
     * - sortBy: username, email, createdAt, status (default: id)
     * - sortOrder: ASC or DESC (default: DESC)
     * - username: filter by username (optional)
     * - status: filter by status (optional)
     * <p>
     * Examples:
     * GET /api/practice/search/choose?sortBy=username&sortOrder=ASC
     * GET /api/practice/search/choose?sortBy=createdAt&sortOrder=DESC
     */
    @GetMapping("/search/choose")
    public ApiResponse<List<UserResponse>> searchWithChoose(UserSearchRequest request) {
        List<UserResponse> users = practiceService.searchWithChoose(request);
        return ApiResponse.success(users);
    }

    // =========================================================
    // PRACTICE 3: <trim> tag
    // =========================================================
    /**
     * GET /api/practice/search/trim
     * Same as /search/if it uses <trim> instead of <where>
     */
    @GetMapping("/search/trim")
    public ApiResponse<List<UserResponse>> searchWithTrim(UserSearchRequest request) {
        List<UserResponse> users = practiceService.searchWithTrim(request);
        return ApiResponse.success(users);
    }

    // =========================================================
    // PRACTICE 4: LIKE search with <bind>
    // =========================================================
    /**
     * GET /api/practice/search/keyword?keyword=test
     */
    @GetMapping("/search/keyword")
    public ApiResponse<List<UserResponse>> searchByKeyword(@RequestParam String keyword) {
        List<UserResponse> users = practiceService.searchByKeyword(keyword);
        return ApiResponse.success(users);
    }

    // =========================================================
    // PRACTICE 5: <foreach> - Find by multiple IDs
    // =========================================================
    /**
     * GET /api/practice/users/by-ids?ids=1,2,3,4,5
     */
    @GetMapping("/users/by-ids")
    public ApiResponse<List<UserResponse>> findByIds(@RequestParam List<Long> ids) {
        List<UserResponse> users = practiceService.findByIds(ids);
        return ApiResponse.success(users);
    }

    /**
     * POST /api/practice/users/by-ids
     * Body: {"ids": [1, 2, 3, 4, 5]}
     */
    @PostMapping("/users/by-ids")
    public ApiResponse<List<UserResponse>> findByIdsPost(@RequestBody Map<String, List<Long>> body) {
        List<Long> ids = body.get("ids");
        List<UserResponse> users = practiceService.findByIds(ids);
        return ApiResponse.success(users);
    }

    // =========================================================
    // PRACTICE 6: <foreach> - Find by multiple statuses
    // =========================================================
    /**
     * GET /api/practice/users/by-statuses?statuses=ACTIVE,INACTIVE
     */
    @GetMapping("/users/by-statuses")
    public ApiResponse<List<UserResponse>> findByStatuses(@RequestParam List<String> statuses) {
        List<UserResponse> users = practiceService.findByStatuses(statuses);
        return ApiResponse.success(users);
    }

    // =========================================================
    // PRACTICE 7: <foreach> - Batch INSERT
    // =========================================================
    /**
     * POST /api/practice/users/batch
     * Body:
     * [
     *   {"username": "user1", "email": "user1@test.com", "status": "ACTIVE"},
     *   {"username": "user2", "email": "user2@test.com", "status": "ACTIVE"},
     *   {"username": "user3", "email": "user3@test.com", "status": "INACTIVE"}
     * ]
     */
    @PostMapping("/users/batch")
    public ApiResponse<Integer> batchInsert(@RequestBody List<UserRequest> users) {
        int count = practiceService.batchInsert(users);
        return ApiResponse.success(count);
    }

    // =========================================================
    // PRACTICE 8: <foreach> - Batch UPDATE status
    // =========================================================
    /**
     * PUT /api/practice/users/batch-status
     * Body: {"ids": [1, 2, 3], "status": "INACTIVE"}
     */
    @PutMapping("/users/batch-status")
    public ApiResponse<Integer> batchUpdateStatus(@RequestBody Map<String, Object> body) {
        @SuppressWarnings("unchecked")
        List<Long> ids = ((List<Integer>) body.get("ids"))
                .stream().map(Long::valueOf).toList();
        String status = (String) body.get("status");

        int count = practiceService.batchUpdateStatus(ids, status);
        return ApiResponse.success(count);
    }

    // =========================================================
    // PRACTICE 9: <foreach> - Batch DELETE
    // =========================================================
    /**
     * DELETE /api/practice/users/batch?ids=1,2,3
     */
    @DeleteMapping("/users/batch")
    public ApiResponse<Integer> batchDelete(@RequestParam List<Long> ids) {
        int count = practiceService.batchDelete(ids);
        return ApiResponse.success(count);
    }

    // =========================================================
    // PRACTICE 10: <set> - Dynamic UPDATE
    // =========================================================
    /**
     * PATCH /api/practice/users/{id}
     * Body: {"username": "new name"} <- only updates username
     * Body: {"status": "INACTIVE"} <- only updates status
     * Body: {"username": "new", "email": "new@test.com"} <- updates both
     */
    @PatchMapping("/users/{id}")
    public ApiResponse<UserResponse> dynamicUpdate(
            @PathVariable Long id,
            @RequestBody UserRequest request) {
        UserResponse user = practiceService.dynamicUpdate(id, request);
        return ApiResponse.success(user);
    }

    // =========================================================
    // PRACTICE 11: ADVANCED SEARCH - Everything combined!
    // =========================================================
    /**
     * POST /api/practice/search/advanced
     * <p>
     * This is the MAIN practice endpoint combining ALL Dynamic SQL features!
     * <p>
     * Body example:
     * {
     *   "username": "john",           // optional - LIKE search
     *   "email": "test",              // optional - LIKE search
     *   "status": "ACTIVE",           // optional - exact match
     *   "keyword": "admin",           // optional - searches username OR email
     *   "ids": [1, 2, 3],             // optional - filter by specific IDs
     *   "statuses": ["ACTIVE", "PENDING"], // optional - multiple statuses
     *   "startDate": "2024-01-01",    // optional - date range start
     *   "endDate": "2024-12-31",      // optional - date range end
     *   "sortBy": "username",         // optional - username, email, createdAt, status
     *   "sortOrder": "ASC",           // optional - ASC or DESC
     *   "page": 1,                    // optional - for pagination
     *   "size": 10                    // optional - for pagination
     * }
     */
    @PostMapping("/search/advanced")
    public ApiResponse<Map<String, Object>> advancedSearch(@RequestBody UserSearchRequest request) {
        List<UserResponse> users = practiceService.advancedSearch(request);
        int total = practiceService.countAdvancedSearch(request);

        return ApiResponse.success(Map.of(
                "users", users,
                "total", total,
                "page", request.getPage() != null ? request.getPage() : 1,
                "size", request.getSize() != null ? request.getSize() : users.size()
        ));
    }

    /**
     * GET version of advanced search for simple testing
     */
    @GetMapping("/search/advanced")
    public ApiResponse<Map<String, Object>> advancedSearchGet(UserSearchRequest request) {
        return advancedSearch(request);
    }
}
