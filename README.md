# 🚀 Spring MyBatis Test Project

> 한국 기업 프로젝트 표준 스택으로 배우는 웹 개발  
> Learning Web Development with Korean Enterprise Standard Stack

![Java](https://img.shields.io/badge/Java-17-orange)
![Spring Boot](https://img.shields.io/badge/Spring%20Boot-4.0.0-green)
![MyBatis](https://img.shields.io/badge/MyBatis-4.0.0-blue)
![jQuery](https://img.shields.io/badge/jQuery-3.7.1-blue)
![PostgreSQL](https://img.shields.io/badge/PostgreSQL-Latest-blue)

---

## 📋 Table of Contents
- [About Project](#-about-project)
- [Tech Stack](#-tech-stack)
- [Project Structure](#-project-structure)
- [Getting Started](#-getting-started)
- [Features](#-features)
- [API Endpoints](#-api-endpoints)
- [SQL Fundamentals Reference](#-sql-fundamentals-reference)
- [MyBatis Dynamic SQL Reference](#-mybatis-dynamic-sql-reference)
- [Learning Roadmap](#-learning-roadmap)
- [Study Resources](#-study-resources)

---

## 📌 About Project

This project is a **User Management System** built with the standard Korean enterprise stack:
- **Spring Boot** - Backend framework
- **MyBatis** - SQL Mapper
- **JSP** - View template
- **jQuery AJAX** - Frontend interaction
- **PostgreSQL** - Database

This stack is commonly used in:
- 🏛️ Korean Government Projects (전자정부 표준프레임워크)
- 🏢 Large Enterprise SI Projects (삼성SDS, LG CNS, SK C&C)
- 🏦 Financial Systems (Banks, Insurance)

---

## 🛠 Tech Stack

### Backend
| Technology | Version | Description |
|------------|---------|-------------|
| Java | 17 | Programming Language |
| Spring Boot | 4.0.0 | Web Framework |
| MyBatis | 4.0.0 | SQL Mapper |
| PostgreSQL | Latest | Database |
| Lombok | Latest | Boilerplate Reduction |

### Frontend
| Technology | Version | Description |
|------------|---------|-------------|
| JSP | 3.0 | View Template |
| JSTL | Jakarta | JSP Tag Library |
| jQuery | 3.7.1 | JavaScript Library |
| CSS3 | - | Styling |

---

## 📁 Project Structure

```
spring-mybatis-test/
├── src/main/java/com/heang/springmybatistest/
│   ├── SpringMybatisTestApplication.java    # Main Application
│   ├── common/
│   │   └── ApiResponse.java                 # API Response Wrapper
│   ├── config/
│   │   └── CorsConfig.java                  # CORS Configuration
│   ├── controller/
│   │   ├── UserController.java              # REST API Controller
│   │   └── ViewController.java              # View Controller (JSP)
│   ├── dto/
│   │   ├── UserRequest.java                 # Create User DTO
│   │   ├── UserUpdateRequest.java           # Update User DTO
│   │   └── UserResponse.java                # Response DTO
│   ├── mapper/
│   │   └── UserMapper.java                  # MyBatis Mapper Interface
│   ├── model/
│   │   └── Users.java                       # Entity
│   └── service/
│       ├── UserService.java                 # Service Interface
│       └── UserServiceImpl.java             # Service Implementation
│
├── src/main/resources/
│   ├── application.properties               # App Configuration
│   └── mapper/
│       └── UserMapper.xml                   # MyBatis SQL Mapper
│
├── src/main/webapp/
│   ├── css/
│   │   └── style.css                        # Common Styles
│   ├── js/
│   │   ├── user-api.js                      # jQuery AJAX API Service
│   │   └── common.js                        # Common JS Utilities
│   └── WEB-INF/views/
│       ├── users.jsp                        # Create User Page
│       └── user-list.jsp                    # User List Page
│
└── pom.xml                                  # Maven Dependencies
```

---

## 🚀 Getting Started

### Prerequisites
- Java 17 or higher
- Maven
- PostgreSQL

### Database Setup
```sql
CREATE DATABASE postgres;

CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    username VARCHAR(100) NOT NULL,
    email VARCHAR(150) NOT NULL,
    status VARCHAR(20),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
```

### Configuration
Edit `src/main/resources/application.properties`:
```properties
spring.datasource.url=jdbc:postgresql://localhost:5432/postgres
spring.datasource.username=postgres
spring.datasource.password=your_password
```

### Run Application
```bash
# Using Maven Wrapper
./mvnw spring-boot:run

# Or on Windows
mvnw.cmd spring-boot:run
```

### Access Application
- **Create User Page**: http://localhost:8080/
- **User List Page**: http://localhost:8080/user-list
- **Swagger API Docs**: http://localhost:8080/swagger-ui.html

---

## ✨ Features

### User Management
| Feature | Description | URL |
|---------|-------------|-----|
| Create User | Add new user | `GET /` |
| View All Users | List with statistics | `GET /user-list` |
| View User | User detail modal | Click "View" button |
| Edit User | Update user info | Click "Edit" button |
| Delete User | Remove user | Click "Delete" button |

### UI Features
- ✅ Responsive design
- ✅ Modal dialogs
- ✅ Form validation
- ✅ Status badges
- ✅ Statistics cards
- ✅ AJAX (no page reload)

---

## 🔌 API Endpoints

### User APIs
| Method | Endpoint | Description |
|--------|----------|-------------|
| `GET` | `/users` | Get all users |
| `GET` | `/users/{id}` | Get user by ID |
| `POST` | `/users` | Create new user |
| `PUT` | `/users/{id}` | Update user |
| `DELETE` | `/users/{id}` | Delete user |

### Request/Response Examples

#### Create User
```javascript
// Request
POST /users
Content-Type: application/json

{
    "username": "john",
    "email": "john@example.com",
    "status": "active"
}

// Response
{
    "resultCd": "M0000",
    "resultMsg": "User created successfully",
    "data": null
}
```

#### Get All Users
```javascript
// Request
GET /users

// Response
{
    "resultCd": "M0000",
    "resultMsg": "Success",
    "data": [
        {
            "id": 1,
            "username": "john",
            "email": "john@example.com",
            "status": "active",
            "createdAt": "2024-01-15T10:30:00"
        }
    ]
}
```

---

## 📖 SQL Fundamentals Reference

> Master SQL basics first, then Dynamic SQL becomes easy!

### 🎯 SQL Statement Types

| Type | Purpose | Example |
|------|---------|---------|
| **SELECT** | Read data | `SELECT * FROM users` |
| **INSERT** | Create data | `INSERT INTO users VALUES (...)` |
| **UPDATE** | Modify data | `UPDATE users SET name = 'new'` |
| **DELETE** | Remove data | `DELETE FROM users WHERE id = 1` |

---

### 1️⃣ SELECT - Reading Data

**Basic Structure:**
```sql
SELECT columns      -- What columns to get
FROM table          -- From which table
WHERE condition     -- Filter rows
ORDER BY column     -- Sort results
LIMIT number        -- Limit rows returned
```

**Examples:**
```sql
-- Get all columns, all rows
SELECT * FROM users;

-- Get specific columns
SELECT id, username, email FROM users;

-- Get with alias (rename column in result)
SELECT username AS name, email AS mail FROM users;
```

**When to use SELECT:**
- Display data on screen
- Check if data exists
- Get data for processing

---

### 2️⃣ WHERE - Filtering Data

**Why use WHERE:**  
Without WHERE, you get ALL rows. WHERE filters to get only what you need.

**Comparison Operators:**
| Operator | Meaning | Example |
|----------|---------|---------|
| `=` | Equal | `WHERE status = 'ACTIVE'` |
| `!=` or `<>` | Not equal | `WHERE status != 'DELETED'` |
| `>` | Greater than | `WHERE age > 18` |
| `<` | Less than | `WHERE price < 100` |
| `>=` | Greater or equal | `WHERE age >= 18` |
| `<=` | Less or equal | `WHERE price <= 100` |

**Examples:**
```sql
-- Exact match
SELECT * FROM users WHERE status = 'ACTIVE';

-- Multiple conditions with AND (both must be true)
SELECT * FROM users WHERE status = 'ACTIVE' AND age >= 18;

-- Multiple conditions with OR (either can be true)
SELECT * FROM users WHERE status = 'ACTIVE' OR status = 'PENDING';

-- Combine AND and OR (use parentheses!)
SELECT * FROM users 
WHERE status = 'ACTIVE' AND (age >= 18 OR role = 'ADMIN');
```

---

### 3️⃣ LIKE - Pattern Matching

**Why use LIKE:**  
When you need partial matching (search), not exact match.

**Wildcards:**
| Wildcard | Meaning | Example |
|----------|---------|---------|
| `%` | Any characters (0 or more) | `'%john%'` matches "john", "johnny", "big john" |
| `_` | Exactly one character | `'j_hn'` matches "john", "jahn" |

**Examples:**
```sql
-- Starts with 'john'
SELECT * FROM users WHERE username LIKE 'john%';
-- Matches: john, johnny, john_doe

-- Ends with '@gmail.com'
SELECT * FROM users WHERE email LIKE '%@gmail.com';
-- Matches: test@gmail.com, user@gmail.com

-- Contains 'admin'
SELECT * FROM users WHERE username LIKE '%admin%';
-- Matches: admin, superadmin, admin123

-- Exactly 4 characters starting with 'j'
SELECT * FROM users WHERE username LIKE 'j___';
-- Matches: john, jack, jane
```

**When to use LIKE:**
- Search functionality
- Email domain filtering
- Username pattern matching

---

### 4️⃣ IN - Multiple Values

**Why use IN:**  
Cleaner than multiple OR conditions.

```sql
-- Instead of this (ugly):
SELECT * FROM users 
WHERE status = 'ACTIVE' OR status = 'PENDING' OR status = 'REVIEW';

-- Use IN (clean):
SELECT * FROM users 
WHERE status IN ('ACTIVE', 'PENDING', 'REVIEW');
```

**More Examples:**
```sql
-- Find users by multiple IDs
SELECT * FROM users WHERE id IN (1, 2, 3, 4, 5);

-- NOT IN - exclude these values
SELECT * FROM users WHERE status NOT IN ('DELETED', 'BANNED');
```

**When to use IN:**
- Filter by list of IDs
- Filter by multiple status values
- When you have 3+ OR conditions for same column

---

### 5️⃣ BETWEEN - Range

**Why use BETWEEN:**  
Cleaner for range conditions.

```sql
-- Instead of this:
SELECT * FROM users WHERE age >= 18 AND age <= 30;

-- Use BETWEEN:
SELECT * FROM users WHERE age BETWEEN 18 AND 30;
```

**Date Range Example:**
```sql
-- Users created in 2024
SELECT * FROM users 
WHERE created_at BETWEEN '2024-01-01' AND '2024-12-31';
```

**When to use BETWEEN:**
- Age ranges
- Date ranges
- Price ranges

---

### 6️⃣ ORDER BY - Sorting

**Why use ORDER BY:**  
Control the order of results (newest first, alphabetical, etc.)

**Direction:**
| Direction | Meaning | Example |
|-----------|---------|---------|
| `ASC` | Ascending (A→Z, 1→9) | Default |
| `DESC` | Descending (Z→A, 9→1) | Newest first |

**Examples:**
```sql
-- Sort by username A-Z
SELECT * FROM users ORDER BY username ASC;

-- Sort by created date (newest first)
SELECT * FROM users ORDER BY created_at DESC;

-- Multiple sort columns
SELECT * FROM users ORDER BY status ASC, created_at DESC;
-- First sorts by status, then by date within each status
```

**When to use ORDER BY:**
- Show newest items first
- Alphabetical listing
- Ranking/leaderboard

---

### 7️⃣ LIMIT & OFFSET - Pagination

**Why use LIMIT/OFFSET:**  
Don't load all 10,000 rows at once! Load page by page.

```sql
-- Get first 10 rows
SELECT * FROM users LIMIT 10;

-- Get rows 11-20 (page 2, 10 per page)
SELECT * FROM users LIMIT 10 OFFSET 10;

-- Get rows 21-30 (page 3)
SELECT * FROM users LIMIT 10 OFFSET 20;
```

**Pagination Formula:**
```
OFFSET = (page_number - 1) * page_size

Page 1: LIMIT 10 OFFSET 0   (rows 1-10)
Page 2: LIMIT 10 OFFSET 10  (rows 11-20)
Page 3: LIMIT 10 OFFSET 20  (rows 21-30)
```

**When to use LIMIT/OFFSET:**
- Pagination (page 1, 2, 3...)
- "Load more" button
- Top N results (Top 10 users)

---

### 8️⃣ INSERT - Creating Data

**Basic Structure:**
```sql
INSERT INTO table (column1, column2, column3)
VALUES (value1, value2, value3);
```

**Examples:**
```sql
-- Insert single row
INSERT INTO users (username, email, status)
VALUES ('john', 'john@test.com', 'ACTIVE');

-- Insert multiple rows (batch insert)
INSERT INTO users (username, email, status)
VALUES 
    ('user1', 'user1@test.com', 'ACTIVE'),
    ('user2', 'user2@test.com', 'ACTIVE'),
    ('user3', 'user3@test.com', 'PENDING');
```

**When to use INSERT:**
- User registration
- Creating new records
- Bulk data import

---

### 9️⃣ UPDATE - Modifying Data

**Basic Structure:**
```sql
UPDATE table
SET column1 = value1, column2 = value2
WHERE condition;
```

**⚠️ ALWAYS use WHERE with UPDATE!** Without WHERE, ALL rows get updated!

**Examples:**
```sql
-- Update single field
UPDATE users SET status = 'INACTIVE' WHERE id = 1;

-- Update multiple fields
UPDATE users 
SET username = 'new_name', email = 'new@test.com'
WHERE id = 1;

-- Update multiple rows
UPDATE users SET status = 'INACTIVE' WHERE status = 'PENDING';

-- ❌ DANGEROUS - updates ALL rows!
UPDATE users SET status = 'DELETED';  -- Don't do this!
```

**When to use UPDATE:**
- Edit user profile
- Change status
- Bulk status change

---

### 🔟 DELETE - Removing Data

**Basic Structure:**
```sql
DELETE FROM table WHERE condition;
```

**⚠️ ALWAYS use WHERE with DELETE!** Without WHERE, ALL rows get deleted!

**Examples:**
```sql
-- Delete single row
DELETE FROM users WHERE id = 1;

-- Delete multiple rows
DELETE FROM users WHERE status = 'DELETED';

-- Delete by list of IDs
DELETE FROM users WHERE id IN (1, 2, 3);

-- ❌ DANGEROUS - deletes ALL rows!
DELETE FROM users;  -- Don't do this!
```

**When to use DELETE:**
- Remove user account
- Clean up old data
- Remove invalid records

---

### 📊 JOIN - Combining Tables

**Why use JOIN:**  
Get data from multiple related tables.

**Example Tables:**
```
users table:          orders table:
+----+----------+     +----+---------+--------+
| id | username |     | id | user_id | amount |
+----+----------+     +----+---------+--------+
| 1  | john     |     | 1  | 1       | 100    |
| 2  | jane     |     | 2  | 1       | 200    |
+----+----------+     | 3  | 2       | 150    |
                      +----+---------+--------+
```

**INNER JOIN - Only matching rows:**
```sql
SELECT users.username, orders.amount
FROM users
INNER JOIN orders ON users.id = orders.user_id;

-- Result: john-100, john-200, jane-150
```

**LEFT JOIN - All from left table + matching from right:**
```sql
SELECT users.username, orders.amount
FROM users
LEFT JOIN orders ON users.id = orders.user_id;

-- If user has no orders, amount will be NULL
```

**When to use JOIN:**
- User with their orders
- Product with category name
- Any related data from multiple tables

---

### 📈 Aggregate Functions

**Why use Aggregates:**  
Calculate summaries (count, total, average).

| Function | Purpose | Example |
|----------|---------|---------|
| `COUNT()` | Count rows | `COUNT(*)` |
| `SUM()` | Total | `SUM(amount)` |
| `AVG()` | Average | `AVG(price)` |
| `MAX()` | Maximum | `MAX(salary)` |
| `MIN()` | Minimum | `MIN(age)` |

**Examples:**
```sql
-- Count all users
SELECT COUNT(*) FROM users;

-- Count active users
SELECT COUNT(*) FROM users WHERE status = 'ACTIVE';

-- Sum of all order amounts
SELECT SUM(amount) FROM orders;

-- Average order amount
SELECT AVG(amount) FROM orders;
```

---

### 📊 GROUP BY - Grouping Results

**Why use GROUP BY:**  
Get aggregates per group (count per status, sum per user).

```sql
-- Count users by status
SELECT status, COUNT(*) as count
FROM users
GROUP BY status;

-- Result:
-- ACTIVE   | 50
-- INACTIVE | 20
-- PENDING  | 10
```

**With HAVING (filter groups):**
```sql
-- Statuses with more than 10 users
SELECT status, COUNT(*) as count
FROM users
GROUP BY status
HAVING COUNT(*) > 10;
```

**WHERE vs HAVING:**
- `WHERE` - filters rows BEFORE grouping
- `HAVING` - filters groups AFTER grouping

---

### 🔄 Complete Query Order

```sql
SELECT columns                    -- 5. What to show
FROM table                        -- 1. Which table
JOIN other_table ON condition     -- 2. Combine tables
WHERE condition                   -- 3. Filter rows
GROUP BY column                   -- 4. Group rows
HAVING condition                  -- 6. Filter groups
ORDER BY column                   -- 7. Sort results
LIMIT number OFFSET number        -- 8. Pagination
```

**Execution Order (how database processes):**
1. FROM / JOIN
2. WHERE
3. GROUP BY
4. HAVING
5. SELECT
6. ORDER BY
7. LIMIT / OFFSET

---

### 📋 SQL Cheat Sheet

```sql
-- 🔍 SELECT (Read)
SELECT * FROM users;
SELECT id, name FROM users WHERE status = 'ACTIVE';
SELECT * FROM users WHERE name LIKE '%john%';
SELECT * FROM users WHERE id IN (1, 2, 3);
SELECT * FROM users WHERE age BETWEEN 18 AND 30;
SELECT * FROM users ORDER BY created_at DESC;
SELECT * FROM users LIMIT 10 OFFSET 20;

-- ➕ INSERT (Create)
INSERT INTO users (name, email) VALUES ('john', 'j@test.com');

-- ✏️ UPDATE (Modify) - Always use WHERE!
UPDATE users SET status = 'INACTIVE' WHERE id = 1;

-- ❌ DELETE (Remove) - Always use WHERE!
DELETE FROM users WHERE id = 1;

-- 📊 Aggregates
SELECT COUNT(*) FROM users;
SELECT status, COUNT(*) FROM users GROUP BY status;

-- 🔗 JOIN
SELECT u.name, o.amount 
FROM users u 
JOIN orders o ON u.id = o.user_id;
```

---

## 🔥 MyBatis Dynamic SQL Reference

> Quick reference for all Dynamic SQL features - copy & use!

### Overview Table

| Tag | Purpose | When to Use |
|-----|---------|-------------|
| `<if>` | Conditional SQL | Optional WHERE conditions |
| `<choose><when><otherwise>` | Switch logic | Mutually exclusive conditions |
| `<where>` | Smart WHERE | Auto-handle AND/OR prefix |
| `<set>` | Smart SET | Dynamic UPDATE fields |
| `<foreach>` | Loop | IN clause, batch operations |
| `<trim>` | Custom trimming | Advanced prefix/suffix control |
| `<sql>` + `<include>` | Reusable | Shared column lists |
| `<bind>` | Variables | LIKE patterns |

---

### 1️⃣ `<if>` - Conditional Filter

**Use Case:** Add WHERE condition only if value exists

```xml
<select id="searchUsers" resultMap="UserMap">
    SELECT * FROM users
    <where>
        <if test="username != null and username != ''">
            AND username = #{username}
        </if>
        <if test="email != null and email != ''">
            AND email = #{email}
        </if>
        <if test="status != null">
            AND status = #{status}
        </if>
    </where>
</select>
```

**Generated SQL (if username="john", email=null, status="ACTIVE"):**
```sql
SELECT * FROM users WHERE username = 'john' AND status = 'ACTIVE'
```

**Key Points:**
- `<where>` automatically removes leading `AND`/`OR`
- Only adds `WHERE` if at least one condition is true
- Use `and` for null check: `test="value != null and value != ''"`

---

### 2️⃣ `<choose><when><otherwise>` - Switch Logic

**Use Case:** Only ONE condition should apply (mutually exclusive)

```xml
<select id="findUsers" resultMap="UserMap">
    SELECT * FROM users
    WHERE status =
    <choose>
        <when test="status == 'ACTIVE'">
            'ACTIVE'
        </when>
        <when test="status == 'INACTIVE'">
            'INACTIVE'
        </when>
        <otherwise>
            'PENDING'
        </otherwise>
    </choose>
</select>
```

**Common Pattern - Dynamic ORDER BY:**
```xml
ORDER BY
<choose>
    <when test="sortBy == 'username'">username</when>
    <when test="sortBy == 'email'">email</when>
    <when test="sortBy == 'createdAt'">created_at</when>
    <otherwise>id</otherwise>
</choose>
<choose>
    <when test="sortOrder == 'ASC'">ASC</when>
    <otherwise>DESC</otherwise>
</choose>
```

---

### 3️⃣ `<foreach>` - Loop Collections

**Use Case 1: IN Clause**
```xml
<select id="findByIds" resultMap="UserMap">
    SELECT * FROM users
    WHERE id IN
    <foreach collection="ids" item="id" open="(" close=")" separator=",">
        #{id}
    </foreach>
</select>
```

**Generated SQL:** `SELECT * FROM users WHERE id IN (1, 2, 3, 4, 5)`

**Use Case 2: Batch INSERT**
```xml
<insert id="batchInsert">
    INSERT INTO users (username, email, status)
    VALUES
    <foreach collection="users" item="user" separator=",">
        (#{user.username}, #{user.email}, #{user.status})
    </foreach>
</insert>
```

**Generated SQL:**
```sql
INSERT INTO users (username, email, status)
VALUES ('user1', 'a@test.com', 'ACTIVE'),
       ('user2', 'b@test.com', 'ACTIVE'),
       ('user3', 'c@test.com', 'INACTIVE')
```

**Use Case 3: Batch UPDATE**
```xml
<update id="batchUpdateStatus">
    UPDATE users
    SET status = #{status}
    WHERE id IN
    <foreach collection="ids" item="id" open="(" close=")" separator=",">
        #{id}
    </foreach>
</update>
```

**Use Case 4: Batch DELETE**
```xml
<delete id="batchDelete">
    DELETE FROM users
    WHERE id IN
    <foreach collection="ids" item="id" open="(" close=")" separator=",">
        #{id}
    </foreach>
</delete>
```

**`<foreach>` Attributes:**
| Attribute | Description | Example |
|-----------|-------------|---------|
| `collection` | Parameter name | `"ids"`, `"users"`, `"list"` |
| `item` | Current element variable | `"id"`, `"user"` |
| `index` | Current index (optional) | `"idx"` |
| `open` | Opening character | `"("` |
| `close` | Closing character | `")"` |
| `separator` | Between elements | `","` |

---

### 4️⃣ `<set>` - Dynamic UPDATE

**Use Case:** Update only non-null fields

```xml
<update id="dynamicUpdate">
    UPDATE users
    <set>
        <if test="username != null and username != ''">
            username = #{username},
        </if>
        <if test="email != null and email != ''">
            email = #{email},
        </if>
        <if test="status != null">
            status = #{status},
        </if>
    </set>
    WHERE id = #{id}
</update>
```

**If username="john", email=null, status="ACTIVE":**
```sql
UPDATE users SET username = 'john', status = 'ACTIVE' WHERE id = 1
```

**Key Points:**
- `<set>` automatically removes trailing commas
- Only adds `SET` if at least one field is present

---

### 5️⃣ `<trim>` - Custom Trimming

**Use Case:** More control than `<where>` or `<set>`

**Alternative to `<where>`:**
```xml
<trim prefix="WHERE" prefixOverrides="AND |OR ">
    <if test="username != null">
        AND username = #{username}
    </if>
    <if test="email != null">
        AND email = #{email}
    </if>
</trim>
```

**Alternative to `<set>`:**
```xml
<trim prefix="SET" suffixOverrides=",">
    <if test="username != null">
        username = #{username},
    </if>
    <if test="email != null">
        email = #{email},
    </if>
</trim>
```

**`<trim>` Attributes:**
| Attribute | Description |
|-----------|-------------|
| `prefix` | Add at beginning if content exists |
| `suffix` | Add at end if content exists |
| `prefixOverrides` | Remove from beginning (pipe `\|` separated) |
| `suffixOverrides` | Remove from end |

---

### 6️⃣ `<sql>` + `<include>` - Reusable Fragments

**Use Case:** Avoid repeating column lists

```xml
<!-- Define reusable fragment -->
<sql id="userColumns">
    id, username, email, status, created_at
</sql>

<sql id="activeCondition">
    AND status = 'ACTIVE'
</sql>

<!-- Use fragment -->
<select id="findAll" resultMap="UserMap">
    SELECT <include refid="userColumns"/>
    FROM users
    ORDER BY id DESC
</select>

<select id="findActiveUsers" resultMap="UserMap">
    SELECT <include refid="userColumns"/>
    FROM users
    WHERE 1=1
    <include refid="activeCondition"/>
</select>
```

---

### 7️⃣ `<bind>` - Create Variables

**Use Case:** LIKE patterns, computed values

```xml
<select id="searchByKeyword" resultMap="UserMap">
    <bind name="pattern" value="'%' + keyword + '%'"/>
    
    SELECT * FROM users
    WHERE username LIKE #{pattern}
       OR email LIKE #{pattern}
</select>
```

**Alternative (without bind):**
```xml
WHERE username LIKE CONCAT('%', #{keyword}, '%')
```

---

### 📋 Complete Example - Advanced Search

```xml
<select id="advancedSearch" resultMap="UserMap">
    SELECT <include refid="userColumns"/>
    FROM users
    <where>
        <!-- Simple conditions -->
        <if test="username != null and username != ''">
            AND username LIKE CONCAT('%', #{username}, '%')
        </if>
        <if test="status != null">
            AND status = #{status}
        </if>
        
        <!-- Date range -->
        <if test="startDate != null">
            AND created_at &gt;= #{startDate}
        </if>
        <if test="endDate != null">
            AND created_at &lt;= #{endDate}
        </if>
        
        <!-- Multiple values (IN clause) -->
        <if test="ids != null and ids.size() > 0">
            AND id IN
            <foreach collection="ids" item="id" open="(" close=")" separator=",">
                #{id}
            </foreach>
        </if>
        
        <if test="statuses != null and statuses.size() > 0">
            AND status IN
            <foreach collection="statuses" item="st" open="(" close=")" separator=",">
                #{st}
            </foreach>
        </if>
    </where>
    
    <!-- Dynamic sorting -->
    ORDER BY
    <choose>
        <when test="sortBy == 'username'">username</when>
        <when test="sortBy == 'email'">email</when>
        <otherwise>id</otherwise>
    </choose>
    <choose>
        <when test="sortOrder == 'ASC'">ASC</when>
        <otherwise>DESC</otherwise>
    </choose>
    
    <!-- Pagination -->
    <if test="size != null and offset != null">
        LIMIT #{size} OFFSET #{offset}
    </if>
</select>
```

---

### ⚠️ Special Characters in XML

| Character | XML Escape | Description |
|-----------|------------|-------------|
| `<` | `&lt;` | Less than |
| `>` | `&gt;` | Greater than |
| `&` | `&amp;` | Ampersand |
| `"` | `&quot;` | Double quote |
| `'` | `&apos;` | Single quote |

**Example:**
```xml
<!-- Wrong -->
<if test="age < 18">

<!-- Correct -->
<if test="age &lt; 18">
```

---

### 🔧 Enable SQL Logging

Add to `application.properties`:
```properties
# Show SQL statements
logging.level.com.heang.springmybatistest.mapper=DEBUG

# Show SQL with parameter values
mybatis.configuration.log-impl=org.apache.ibatis.logging.stdout.StdOutImpl
```

---

### 📁 Practice Files

| File | Description |
|------|-------------|
| `mapper/DynamicSqlPracticeMapper.xml` | All examples with comments |
| `mapper/DynamicSqlPracticeMapper.java` | Mapper interface |
| `service/DynamicSqlPracticeServiceImpl.java` | Service with explanations |
| `controller/DynamicSqlPracticeController.java` | REST endpoints to test |
| `dto/UserSearchRequest.java` | Search request DTO |

---

## 📚 Learning Roadmap

### Why This Stack? (왜 이 기술 스택인가?)

**Spring + MyBatis + JSP + jQuery** is the standard in Korean enterprise because:

| Reason | Explanation |
|--------|-------------|
| 🏛️ **Government Standard** | eGovFrame (전자정부 표준프레임워크) is based on Spring |
| 🏢 **SI Companies** | Samsung SDS, LG CNS standardized on this |
| 👨‍💻 **Developer Pool** | Most Korean developers trained on this stack |
| 🔒 **Stability** | Proven over 15+ years |
| 📊 **Oracle Compatible** | MyBatis works well with Oracle DB |

---

### 🇰🇷 Deep Dive: Why Korean Enterprise Uses This Stack

#### 1. Historical Background (역사적 배경)

**Early 2000s - Java Dominance**
- Korean government strongly promoted **Java** for public sector projects
- **전자정부 표준프레임워크 (eGovFrame)** was built on Spring
- All government projects were required to use this stack
- This became the de facto standard for enterprise development

**The Stack Evolution:**
```
1990s: Pure Servlets + JSP
2000s: Struts + JSP + JDBC
2005+: Spring + MyBatis + JSP + jQuery  ← Current Standard
2015+: Spring Boot + JPA (slowly adopting)
```

---

#### 2. Why Each Technology? (각 기술 선택 이유)

##### 🌱 Spring Framework
| Reason | Explanation |
|--------|-------------|
| **Government Standard** | eGovFrame is based on Spring |
| **Enterprise Features** | Transaction, Security, AOP |
| **Large Community** | Many Korean developers know it |
| **Stability** | Proven over 15+ years |

##### 🗄️ MyBatis (vs JPA/Hibernate)
| Reason | Explanation |
|--------|-------------|
| **SQL Control** | Korean developers prefer writing raw SQL |
| **Complex Queries** | Many legacy systems have complex joins |
| **Oracle Compatibility** | Most Korean enterprises use Oracle DB |
| **Learning Curve** | Easier to learn than JPA |
| **Performance Tuning** | Direct SQL optimization possible |

```xml
<!-- MyBatis allows direct SQL control -->
<select id="getUsers" resultType="User">
    SELECT * FROM users 
    WHERE status = #{status}
    AND created_at > SYSDATE - 30  <!-- Oracle specific -->
</select>
```

##### 📄 JSP (vs Thymeleaf, React)
| Reason | Explanation |
|--------|-------------|
| **Server-Side Rendering** | Traditional approach, well understood |
| **JSTL Tags** | Easy HTML generation |
| **Legacy Systems** | Many existing systems use JSP |
| **No Build Process** | No npm, webpack needed |
| **Government Compliance** | eGovFrame uses JSP |

##### 💻 jQuery (vs React, Vue)
| Reason | Explanation |
|--------|-------------|
| **DOM Manipulation** | Simple and direct |
| **AJAX Support** | Easy $.ajax() calls |
| **Plugin Ecosystem** | Many UI plugins available |
| **No Build Tools** | Just include via CDN |
| **Wide Browser Support** | Works on old browsers (IE) |
| **Fast Development** | Quick to implement features |

---

#### 3. Korean IT Industry Characteristics (한국 IT 산업 특성)

##### 🏢 Large Enterprise Culture
- **SI Companies** (삼성SDS, LG CNS, SK C&C) dominate the market
- Standardized tech stacks across projects
- Risk-averse: prefer proven technologies
- Long-term maintenance contracts (5-10 years)

##### 👨‍💼 Developer Workforce
- Most developers trained on this stack in academies (학원)
- Job postings require Spring + MyBatis experience
- Easier to find replacement developers
- Consistent code style across teams

##### 📋 Typical Project Requirements
```
Korean Enterprise Project Requirements:
✅ Must use eGovFrame (Spring-based)
✅ Must support Internet Explorer (legacy)
✅ Must connect to Oracle Database
✅ Must integrate with 공인인증서 (digital certificates)
✅ Must follow 행정안전부 guidelines
```

---

#### 4. Comparison: Traditional vs Modern Stack

| Aspect | Traditional (Korea) | Modern (Global) |
|--------|---------------------|-----------------|
| Backend | Spring MVC | Spring Boot |
| ORM | MyBatis (SQL) | JPA/Hibernate |
| View | JSP | React/Vue/Thymeleaf |
| Frontend | jQuery | React/Vue |
| Database | Oracle | PostgreSQL/MySQL |
| Build | Maven/Ant | Gradle |
| API Style | Form Submit | REST API |

---

#### 5. Why It's Still Used in 2024-2026

##### ✅ Advantages
1. **Stability** - Proven over many years
2. **Maintainability** - Easy to find developers
3. **Government Compliance** - Required for public projects
4. **Legacy Integration** - Works with old systems
5. **No Build Complexity** - No npm, webpack issues

##### ❌ Disadvantages
1. **Outdated** - Not following modern trends
2. **Poor UX** - Full page reloads
3. **Hard to Test** - Tightly coupled code
4. **Security Risks** - XSS vulnerabilities with JSP
5. **Talent Shortage** - Young developers prefer React/Vue

---

#### 6. The Future (미래 전망)

##### Gradual Transition
```
Current: Spring + MyBatis + JSP + jQuery
    ↓
Phase 1: Spring Boot + MyBatis + JSP + jQuery
    ↓
Phase 2: Spring Boot + MyBatis/JPA + Thymeleaf + Vue
    ↓
Future:  Spring Boot + JPA + React/Vue (SPA)
```

##### New Government Standard (2024+)
- 전자정부 표준프레임워크 4.0 now supports:
  - Spring Boot
  - JPA (optional)
  - Vue.js (optional)
  - REST API

---

#### 7. Summary (요약)

**Spring + MyBatis + JSP + jQuery** is popular in Korea because:

| # | Reason |
|---|--------|
| 1 | 🏛️ **Government mandated** it through eGovFrame |
| 2 | 🏢 **Large SI companies** standardized on it |
| 3 | 👨‍💻 **Developer availability** - many trained on this stack |
| 4 | 🔒 **Risk aversion** - enterprises prefer proven tech |
| 5 | 🔄 **Legacy systems** - need to maintain old code |
| 6 | 💰 **Cost efficiency** - no need for specialized React/Vue developers |

> **For your career:** This stack is highly valuable for working in Korean enterprise/government projects. Understanding it well will give you many job opportunities! 🚀

---

### Phase 1: Master Fundamentals (1-2 months)

#### Java Core
```
Must Know:
├── OOP - Class, Interface, Inheritance
├── Collections - List, Map, Set
├── Exception Handling - try/catch
├── Stream API - filter, map, collect
└── Lambda - () -> {}
```

#### SQL Mastery
```sql
-- Practice these patterns!
SELECT u.*, COUNT(o.id) as order_count
FROM users u
LEFT JOIN orders o ON u.id = o.user_id
WHERE u.status = 'active'
GROUP BY u.id
HAVING COUNT(o.id) > 5
ORDER BY order_count DESC;
```

---

### Phase 2: Deep Dive (2-3 months)

#### Spring Framework
| Concept | Annotation | Purpose |
|---------|------------|---------|
| IoC/DI | `@Autowired`, `@Component` | Object management |
| MVC | `@Controller`, `@RequestMapping` | Web layer |
| REST | `@RestController`, `@RequestBody` | API development |
| Transaction | `@Transactional` | Data integrity |

#### MyBatis Dynamic SQL
```xml
<!-- Dynamic WHERE clause -->
<select id="searchUsers" resultType="User">
    SELECT * FROM users
    <where>
        <if test="username != null">
            AND username LIKE '%' || #{username} || '%'
        </if>
        <if test="status != null">
            AND status = #{status}
        </if>
    </where>
</select>

<!-- IN clause with foreach -->
<select id="getUsersByIds" resultType="User">
    SELECT * FROM users
    WHERE id IN
    <foreach collection="ids" item="id" open="(" separator="," close=")">
        #{id}
    </foreach>
</select>
```

#### JSP & JSTL
```jsp
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<!-- Loop with status -->
<c:forEach var="user" items="${users}" varStatus="status">
    <tr class="${status.index % 2 == 0 ? 'even' : 'odd'}">
        <td>${status.count}</td>
        <td><c:out value="${user.username}"/></td>
    </tr>
</c:forEach>

<!-- Date formatting -->
<fmt:formatDate value="${user.createdAt}" pattern="yyyy-MM-dd HH:mm"/>

<!-- Number formatting -->
<fmt:formatNumber value="${amount}" pattern="#,###"/>원
```

#### jQuery AJAX
```javascript
// Standard AJAX pattern
$.ajax({
    url: '/users',
    type: 'GET',
    dataType: 'json',
    success: function(result) {
        if (result.data) {
            renderTable(result.data);
        }
    },
    error: function(xhr, status, error) {
        alert('Error: ' + error);
    }
});

// POST with JSON
$.ajax({
    url: '/users',
    type: 'POST',
    contentType: 'application/json',
    data: JSON.stringify({
        username: $('#username').val(),
        email: $('#email').val()
    }),
    success: function(result) {
        alert('Success!');
    }
});
```

---

### Phase 3: Enterprise Patterns (2-3 months)

#### Practice Projects
```
1. 게시판 (Board System)
   ├── 글 목록 (페이징, 검색)
   ├── 글 작성/수정/삭제
   ├── 댓글 기능
   └── 파일 첨부

2. 직원 관리 (Employee Management)
   ├── 직원 CRUD
   ├── 부서 관리
   ├── 로그인/권한
   └── 엑셀 다운로드

3. 주문 관리 (Order Management)
   ├── 상품 관리
   ├── 주문 처리
   └── 매출 통계
```

---

### Skills Checklist

#### Junior Level (1년차)
- [ ] CRUD 구현
- [ ] MyBatis XML Mapper
- [ ] JSP + JSTL
- [ ] jQuery AJAX
- [ ] 페이징 처리
- [ ] 기본 검색

#### Mid Level (2-3년차)
- [ ] 복잡한 JOIN 쿼리
- [ ] Spring Security
- [ ] Transaction 관리
- [ ] Exception Handling
- [ ] 파일 업로드/다운로드
- [ ] 엑셀 처리 (Apache POI)

#### Senior Level (4년차+)
- [ ] 시스템 설계
- [ ] 성능 최적화
- [ ] 코드 리뷰
- [ ] 기술 선택/의사결정

---

## 📖 Study Resources

### Korean Resources (한국어)
| Type | Resource | Link |
|------|----------|------|
| Framework | 전자정부 표준프레임워크 | https://www.egovframe.go.kr |
| Courses | 인프런 | https://www.inflearn.com |
| Community | OKKY | https://okky.kr |
| YouTube | 뉴렉처 | Search on YouTube |

### English Resources
| Type | Resource | Link |
|------|----------|------|
| Spring | Baeldung | https://www.baeldung.com |
| MyBatis | Official Docs | https://mybatis.org/mybatis-3 |
| jQuery | API Docs | https://api.jquery.com |

---

## 💡 Tips for Learning

### Daily Practice Routine
```
Morning (1-2 hours):
├── Read documentation/tutorial
└── Learn new concept

Afternoon (2-3 hours):
├── Code practice
├── Build features
└── Debug issues

Evening (1 hour):
├── Review what you learned
└── Plan tomorrow
```

### Key Advice
```
1. 매일 코딩하세요 (Code every day)
2. 에러를 두려워하지 마세요 (Don't fear errors)
3. 프로젝트에 기능 추가하세요 (Keep adding features)
4. GitHub에 올리세요 (Build your portfolio)
```

---

## 🔗 Useful Links

- [Spring Boot Documentation](https://docs.spring.io/spring-boot/docs/current/reference/html/)
- [MyBatis Documentation](https://mybatis.org/mybatis-3/)
- [jQuery API](https://api.jquery.com/)
- [전자정부 표준프레임워크](https://www.egovframe.go.kr/)

---

## 📝 License

This project is for learning purposes.

---

## 👨‍💻 Author

Created for learning Korean Enterprise Web Development Stack.

**화이팅! 🚀**

---

*Last Updated: 2026-02-03*
