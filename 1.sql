-- 用户表（对应用户管理模块）
CREATE TABLE `users` (
  `id` INT PRIMARY KEY AUTO_INCREMENT,
  `username` VARCHAR(50) NOT NULL UNIQUE,
  `role` VARCHAR(20) NOT NULL,
  `status` VARCHAR(10) DEFAULT 'active'
);

-- 学生表（对应学生管理模块）
CREATE TABLE `students` (
  `id` INT PRIMARY KEY AUTO_INCREMENT,
  `name` VARCHAR(50) NOT NULL,
  `major` VARCHAR(30),
  `enrollment_date` DATE
);
spring.datasource.url=jdbc:mysql://localhost:3306/university_db?useSSL=false&serverTimezone=UTC
spring.datasource.username=root
spring.datasource.password=123456
spring.datasource.driver-class-name=com.mysql.cj.jdbc.Driver
# 添加用户（对应“添加用户”按钮）
cursor.execute("INSERT INTO users (username, role) VALUES (%s, %s)", ('admin', 'super'))

# 查询用户列表（对应用户表格展示）
cursor.execute("SELECT id, username, role FROM users WHERE status='active'")
users = cursor.fetchall()
GRANT SELECT, INSERT, UPDATE ON university_db.* TO 'system_user'@'localhost' IDENTIFIED BY 'system_pwd';
