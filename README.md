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
