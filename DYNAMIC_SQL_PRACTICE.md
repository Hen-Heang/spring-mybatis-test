# MyBatis Dynamic SQL Practice Guide

## 📚 What You'll Learn

This practice set covers ALL major MyBatis Dynamic SQL features:

| Tag | Purpose | Example |
|-----|---------|---------|
| `<if>` | Conditional SQL | Only add WHERE clause if field is not null |
| `<choose><when><otherwise>` | Switch logic | Dynamic ORDER BY |
| `<where>` | Smart WHERE handling | Auto-removes leading AND/OR |
| `<set>` | Smart SET handling | Auto-removes trailing commas |
| `<foreach>` | Loop collections | IN clauses, batch operations |
| `<trim>` | Custom trimming | Flexible prefix/suffix handling |
| `<sql><include>` | Reusable fragments | Share common column lists |
| `<bind>` | Create variables | LIKE patterns |

---

## 🚀 How to Practice

### Step 1: Start the Application
```bash
./mvnw spring-boot:run
```

### Step 2: Test with Postman or curl

---

## 📝 Practice Exercises

### Exercise 1: `<if>` Tag - Conditional Filters

**Endpoint:** `GET /api/practice/search/if`

Try these requests:
```bash
# Get all users (no filters)
GET http://localhost:8080/api/practice/search/if

# Filter by username only
GET http://localhost:8080/api/practice/search/if?username=john

# Filter by status only
GET http://localhost:8080/api/practice/search/if?status=ACTIVE

# Filter by both
GET http://localhost:8080/api/practice/search/if?username=john&status=ACTIVE

# Search with keyword (searches username AND email)
GET http://localhost:8080/api/practice/search/if?keyword=test
```

**Study the XML:**
```xml
<where>
    <if test="username != null and username != ''">
        AND username = #{username}
    </if>
    <if test="status != null and status != ''">
        AND status = #{status}
    </if>
</where>
```

**What to notice:**
- `<where>` only adds WHERE if at least one condition is true
- `<where>` removes the leading AND automatically

---

### Exercise 2: `<choose>` Tag - Dynamic Sorting

**Endpoint:** `GET /api/practice/search/choose`

```bash
# Default sort (by id DESC)
GET http://localhost:8080/api/practice/search/choose

# Sort by username ASC
GET http://localhost:8080/api/practice/search/choose?sortBy=username&sortOrder=ASC

# Sort by email DESC
GET http://localhost:8080/api/practice/search/choose?sortBy=email&sortOrder=DESC

# Sort by created date
GET http://localhost:8080/api/practice/search/choose?sortBy=createdAt&sortOrder=ASC
```

**Study the XML:**
```xml
ORDER BY
<choose>
    <when test="sortBy == 'username'">username</when>
    <when test="sortBy == 'email'">email</when>
    <when test="sortBy == 'createdAt'">created_at</when>
    <otherwise>id</otherwise>
</choose>
```

**What to notice:**
- Only ONE `<when>` branch executes (like switch)
- `<otherwise>` is the default case

---

### Exercise 3: `<foreach>` Tag - IN Clause

**Endpoint:** `GET /api/practice/users/by-ids`

```bash
# Find users with IDs 1, 2, 3
GET http://localhost:8080/api/practice/users/by-ids?ids=1,2,3

# Find users by multiple statuses
GET http://localhost:8080/api/practice/users/by-statuses?statuses=ACTIVE,INACTIVE
```

**Study the XML:**
```xml
WHERE id IN
<foreach collection="ids" item="id" open="(" close=")" separator=",">
    #{id}
</foreach>
```

**Generated SQL:** `WHERE id IN (1, 2, 3)`

---

### Exercise 4: `<foreach>` Tag - Batch INSERT

**Endpoint:** `POST /api/practice/users/batch`

```json
POST http://localhost:8080/api/practice/users/batch
Content-Type: application/json

[
    {"username": "batch_user1", "email": "batch1@test.com", "status": "ACTIVE"},
    {"username": "batch_user2", "email": "batch2@test.com", "status": "ACTIVE"},
    {"username": "batch_user3", "email": "batch3@test.com", "status": "INACTIVE"}
]
```

**Study the XML:**
```xml
INSERT INTO users (username, email, status)
VALUES
<foreach collection="users" item="user" separator=",">
    (#{user.username}, #{user.email}, COALESCE(#{user.status}, 'ACTIVE'))
</foreach>
```

**Generated SQL:**
```sql
INSERT INTO users (username, email, status)
VALUES ('batch_user1', 'batch1@test.com', 'ACTIVE'),
       ('batch_user2', 'batch2@test.com', 'ACTIVE'),
       ('batch_user3', 'batch3@test.com', 'INACTIVE')
```

---

### Exercise 5: `<foreach>` Tag - Batch UPDATE

**Endpoint:** `PUT /api/practice/users/batch-status`

```json
PUT http://localhost:8080/api/practice/users/batch-status
Content-Type: application/json

{
    "ids": [1, 2, 3],
    "status": "INACTIVE"
}
```

---

### Exercise 6: `<foreach>` Tag - Batch DELETE

**Endpoint:** `DELETE /api/practice/users/batch`

```bash
DELETE http://localhost:8080/api/practice/users/batch?ids=10,11,12
```

---

### Exercise 7: `<set>` Tag - Dynamic UPDATE

**Endpoint:** `PATCH /api/practice/users/{id}`

```json
# Update only username
PATCH http://localhost:8080/api/practice/users/1
{"username": "new_name"}

# Update only status
PATCH http://localhost:8080/api/practice/users/1
{"status": "INACTIVE"}

# Update multiple fields
PATCH http://localhost:8080/api/practice/users/1
{"username": "new_name", "email": "new@test.com"}
```

**Study the XML:**
```xml
UPDATE users
<set>
    <if test="req.username != null">username = #{req.username},</if>
    <if test="req.email != null">email = #{req.email},</if>
    <if test="req.status != null">status = #{req.status},</if>
</set>
WHERE id = #{id}
```

**What to notice:**
- `<set>` automatically removes trailing commas
- Only non-null fields are included

---

### Exercise 8: ADVANCED SEARCH - Everything Combined!

**Endpoint:** `POST /api/practice/search/advanced`

```json
POST http://localhost:8080/api/practice/search/advanced
Content-Type: application/json

{
    "keyword": "test",
    "statuses": ["ACTIVE", "PENDING"],
    "sortBy": "username",
    "sortOrder": "ASC",
    "page": 1,
    "size": 10
}
```

Try different combinations:
```json
// Search with date range
{
    "startDate": "2024-01-01",
    "endDate": "2024-12-31"
}

// Search by multiple IDs with sorting
{
    "ids": [1, 2, 3, 4, 5],
    "sortBy": "createdAt",
    "sortOrder": "DESC"
}

// Full search with pagination
{
    "keyword": "admin",
    "status": "ACTIVE",
    "sortBy": "email",
    "sortOrder": "ASC",
    "page": 1,
    "size": 5
}
```

---

## 📁 Files to Study

| File | Description |
|------|-------------|
| `DynamicSqlPracticeMapper.xml` | **MAIN FILE** - All Dynamic SQL examples with comments |
| `DynamicSqlPracticeMapper.java` | Mapper interface with documentation |
| `DynamicSqlPracticeServiceImpl.java` | Service with explanations for each method |
| `DynamicSqlPracticeController.java` | REST endpoints with usage examples |
| `UserSearchRequest.java` | DTO with all search/filter fields |

---

## 🎯 Key Concepts Summary

### 1. `<if>` - Include SQL conditionally
```xml
<if test="username != null and username != ''">
    AND username = #{username}
</if>
```

### 2. `<where>` - Smart WHERE clause
```xml
<where>
    <if test="...">AND condition1</if>
    <if test="...">AND condition2</if>
</where>
```
- Only adds WHERE if there's content
- Removes leading AND/OR

### 3. `<choose>` - Switch statement
```xml
<choose>
    <when test="sortBy == 'name'">name</when>
    <when test="sortBy == 'email'">email</when>
    <otherwise>id</otherwise>
</choose>
```

### 4. `<foreach>` - Loop collections
```xml
<foreach collection="ids" item="id" open="(" close=")" separator=",">
    #{id}
</foreach>
```

### 5. `<set>` - Smart SET for UPDATE
```xml
<set>
    <if test="name != null">name = #{name},</if>
    <if test="email != null">email = #{email},</if>
</set>
```
- Removes trailing commas

### 6. `<trim>` - Custom trimming
```xml
<trim prefix="WHERE" prefixOverrides="AND |OR ">
    ...conditions...
</trim>
```

### 7. `<sql>` + `<include>` - Reusable fragments
```xml
<sql id="baseColumns">id, username, email, status</sql>

<select>
    SELECT <include refid="baseColumns"/> FROM users
</select>
```

### 8. `<bind>` - Create variables
```xml
<bind name="pattern" value="'%' + keyword + '%'"/>
SELECT * FROM users WHERE username LIKE #{pattern}
```

---

## 🔧 Enable SQL Logging

Add to `application.properties`:
```properties
# Show SQL statements
logging.level.com.heang.springmybatistest.mapper=DEBUG
logging.level.org.mybatis=DEBUG

# Show SQL with parameters
mybatis.configuration.log-impl=org.apache.ibatis.logging.stdout.StdOutImpl
```

This will show you the actual SQL being generated!

---

## ✅ Practice Checklist

- [ ] Test `<if>` with different filter combinations
- [ ] Test `<choose>` with different sort options
- [ ] Test `<foreach>` with IN clause
- [ ] Test batch INSERT
- [ ] Test batch UPDATE
- [ ] Test batch DELETE
- [ ] Test `<set>` with partial updates
- [ ] Test advanced search with pagination
- [ ] Enable SQL logging and observe generated SQL
- [ ] Study the XML mapper file comments

Happy Learning! 🚀
