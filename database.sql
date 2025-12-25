-- ============================================
-- 华夏大学官网数据库
-- MySQL 数据库脚本
-- ============================================

-- 创建数据库
CREATE DATABASE IF NOT EXISTS university_website DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

USE university_website;

-- ============================================
-- 用户表
-- ============================================
CREATE TABLE IF NOT EXISTS users (
    id INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(50) UNIQUE NOT NULL COMMENT '用户名',
    password VARCHAR(255) NOT NULL COMMENT '密码(加密)',
    email VARCHAR(100) UNIQUE COMMENT '邮箱',
    phone VARCHAR(20) COMMENT '电话',
    real_name VARCHAR(50) NOT NULL COMMENT '真实姓名',
    role ENUM('student', 'teacher', 'admin') NOT NULL DEFAULT 'student' COMMENT '角色',
    avatar VARCHAR(255) COMMENT '头像URL',
    status TINYINT NOT NULL DEFAULT 1 COMMENT '状态: 1-正常, 0-禁用',
    last_login_at DATETIME COMMENT '最后登录时间',
    last_login_ip VARCHAR(50) COMMENT '最后登录IP',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    INDEX idx_username (username),
    INDEX idx_role (role),
    INDEX idx_status (status)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='用户表';

-- ============================================
-- 新闻文章表
-- ============================================
CREATE TABLE IF NOT EXISTS news (
    id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(200) NOT NULL COMMENT '标题',
    category VARCHAR(50) NOT NULL COMMENT '分类',
    content TEXT NOT NULL COMMENT '内容',
    image VARCHAR(255) COMMENT '图片URL',
    author_id INT COMMENT '作者ID',
    views INT DEFAULT 0 COMMENT '浏览量',
    status TINYINT NOT NULL DEFAULT 1 COMMENT '状态: 1-已发布, 0-草稿',
    published_at DATETIME COMMENT '发布时间',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    FOREIGN KEY (author_id) REFERENCES users(id) ON DELETE SET NULL,
    INDEX idx_category (category),
    INDEX idx_status (status),
    INDEX idx_published_at (published_at)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='新闻文章表';

-- ============================================
-- 学院表
-- ============================================
CREATE TABLE IF NOT EXISTS colleges (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL COMMENT '学院名称',
    code VARCHAR(20) UNIQUE NOT NULL COMMENT '学院代码',
    description TEXT COMMENT '学院简介',
    dean VARCHAR(50) COMMENT '院长姓名',
    phone VARCHAR(20) COMMENT '联系电话',
    address VARCHAR(200) COMMENT '办公地址',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    INDEX idx_code (code)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='学院表';

-- ============================================
-- 专业表
-- ============================================
CREATE TABLE IF NOT EXISTS majors (
    id INT PRIMARY KEY AUTO_INCREMENT,
    college_id INT NOT NULL COMMENT '所属学院ID',
    name VARCHAR(100) NOT NULL COMMENT '专业名称',
    code VARCHAR(20) UNIQUE NOT NULL COMMENT '专业代码',
    degree_type ENUM('bachelor', 'master', 'doctor') NOT NULL COMMENT '学位类型',
    description TEXT COMMENT '专业简介',
    duration TINYINT COMMENT '学制年限',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    FOREIGN KEY (college_id) REFERENCES colleges(id) ON DELETE CASCADE,
    INDEX idx_college (college_id),
    INDEX idx_code (code)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='专业表';

-- ============================================
-- 学生表
-- ============================================
CREATE TABLE IF NOT EXISTS students (
    id INT PRIMARY KEY AUTO_INCREMENT,
    student_id VARCHAR(20) UNIQUE NOT NULL COMMENT '学号',
    user_id INT UNIQUE COMMENT '关联用户ID',
    name VARCHAR(50) NOT NULL COMMENT '姓名',
    gender ENUM('male', 'female') COMMENT '性别',
    birth_date DATE COMMENT '出生日期',
    id_card VARCHAR(18) COMMENT '身份证号',
    college_id INT COMMENT '所属学院ID',
    major_id INT COMMENT '所属专业ID',
    grade VARCHAR(20) COMMENT '年级',
    class VARCHAR(50) COMMENT '班级',
    address VARCHAR(200) COMMENT '家庭住址',
    phone VARCHAR(20) COMMENT '联系电话',
    email VARCHAR(100) COMMENT '邮箱',
    enrollment_date DATE COMMENT '入学日期',
    graduation_date DATE COMMENT '毕业日期',
    status TINYINT DEFAULT 1 COMMENT '状态: 1-在读, 2-毕业, 3-退学',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE SET NULL,
    FOREIGN KEY (college_id) REFERENCES colleges(id) ON DELETE SET NULL,
    FOREIGN KEY (major_id) REFERENCES majors(id) ON DELETE SET NULL,
    INDEX idx_student_id (student_id),
    INDEX idx_college (college_id),
    INDEX idx_major (major_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='学生表';

-- ============================================
-- 教师表
-- ============================================
CREATE TABLE IF NOT EXISTS teachers (
    id INT PRIMARY KEY AUTO_INCREMENT,
    teacher_id VARCHAR(20) UNIQUE NOT NULL COMMENT '工号',
    user_id INT UNIQUE COMMENT '关联用户ID',
    name VARCHAR(50) NOT NULL COMMENT '姓名',
    gender ENUM('male', 'female') COMMENT '性别',
    birth_date DATE COMMENT '出生日期',
    id_card VARCHAR(18) COMMENT '身份证号',
    college_id INT COMMENT '所属学院ID',
    title VARCHAR(50) COMMENT '职称',
    education VARCHAR(50) COMMENT '学历',
    degree VARCHAR(50) COMMENT '学位',
    research_area VARCHAR(200) COMMENT '研究方向',
    phone VARCHAR(20) COMMENT '联系电话',
    email VARCHAR(100) COMMENT '邮箱',
    hire_date DATE COMMENT '入职日期',
    status TINYINT DEFAULT 1 COMMENT '状态: 1-在职, 2-离职',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE SET NULL,
    FOREIGN KEY (college_id) REFERENCES colleges(id) ON DELETE SET NULL,
    INDEX idx_teacher_id (teacher_id),
    INDEX idx_college (college_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='教师表';

-- ============================================
-- 课程表
-- ============================================
CREATE TABLE IF NOT EXISTS courses (
    id INT PRIMARY KEY AUTO_INCREMENT,
    course_code VARCHAR(20) UNIQUE NOT NULL COMMENT '课程编号',
    name VARCHAR(100) NOT NULL COMMENT '课程名称',
    english_name VARCHAR(100) COMMENT '英文名称',
    credits DECIMAL(3,1) NOT NULL COMMENT '学分',
    hours TINYINT NOT NULL COMMENT '学时',
    type ENUM('required', 'elective', 'practical') NOT NULL COMMENT '课程类型',
    college_id INT COMMENT '所属学院ID',
    description TEXT COMMENT '课程简介',
    prerequisite VARCHAR(200) COMMENT '先修课程',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    FOREIGN KEY (college_id) REFERENCES colleges(id) ON DELETE SET NULL,
    INDEX idx_code (course_code),
    INDEX idx_college (college_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='课程表';

-- ============================================
-- 课程安排表
-- ============================================
CREATE TABLE IF NOT EXISTS course_schedules (
    id INT PRIMARY KEY AUTO_INCREMENT,
    course_id INT NOT NULL COMMENT '课程ID',
    teacher_id INT NOT NULL COMMENT '教师ID',
    semester VARCHAR(20) NOT NULL COMMENT '学期',
    weekday TINYINT NOT NULL COMMENT '星期几: 1-7',
    period_start TINYINT NOT NULL COMMENT '开始节次',
    period_end TINYINT NOT NULL COMMENT '结束节次',
    location VARCHAR(100) COMMENT '上课地点',
    max_students INT COMMENT '最大人数',
    current_students INT DEFAULT 0 COMMENT '当前人数',
    status TINYINT DEFAULT 1 COMMENT '状态: 1-开课, 0-停课',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    FOREIGN KEY (course_id) REFERENCES courses(id) ON DELETE CASCADE,
    FOREIGN KEY (teacher_id) REFERENCES teachers(id) ON DELETE CASCADE,
    INDEX idx_course (course_id),
    INDEX idx_teacher (teacher_id),
    INDEX idx_semester (semester)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='课程安排表';

-- ============================================
-- 选课记录表
-- ============================================
CREATE TABLE IF NOT EXISTS enrollments (
    id INT PRIMARY KEY AUTO_INCREMENT,
    student_id INT NOT NULL COMMENT '学生ID',
    schedule_id INT NOT NULL COMMENT '课程安排ID',
    score DECIMAL(5,2) COMMENT '成绩',
    grade VARCHAR(10) COMMENT '等级',
    semester VARCHAR(20) NOT NULL COMMENT '学期',
    status TINYINT DEFAULT 1 COMMENT '状态: 1-正常, 2-退选',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    FOREIGN KEY (student_id) REFERENCES students(id) ON DELETE CASCADE,
    FOREIGN KEY (schedule_id) REFERENCES course_schedules(id) ON DELETE CASCADE,
    UNIQUE KEY unique_enrollment (student_id, schedule_id),
    INDEX idx_student (student_id),
    INDEX idx_schedule (schedule_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='选课记录表';

-- ============================================
-- 公告表
-- ============================================
CREATE TABLE IF NOT EXISTS notices (
    id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(200) NOT NULL COMMENT '标题',
    content TEXT NOT NULL COMMENT '内容',
    type ENUM('important', 'notice', 'update') NOT NULL COMMENT '类型',
    priority TINYINT DEFAULT 0 COMMENT '优先级',
    status TINYINT DEFAULT 1 COMMENT '状态: 1-显示, 0-隐藏',
    publisher_id INT COMMENT '发布者ID',
    publish_at DATETIME COMMENT '发布时间',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    FOREIGN KEY (publisher_id) REFERENCES users(id) ON DELETE SET NULL,
    INDEX idx_type (type),
    INDEX idx_status (status)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='公告表';

-- ============================================
-- 系统设置表
-- ============================================
CREATE TABLE IF NOT EXISTS settings (
    id INT PRIMARY KEY AUTO_INCREMENT,
    key_name VARCHAR(100) UNIQUE NOT NULL COMMENT '设置键',
    value TEXT COMMENT '设置值',
    description VARCHAR(200) COMMENT '描述',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='系统设置表';

-- ============================================
-- 访问日志表
-- ============================================
CREATE TABLE IF NOT EXISTS access_logs (
    id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT COMMENT '用户ID',
    ip VARCHAR(50) COMMENT 'IP地址',
    user_agent VARCHAR(500) COMMENT '浏览器信息',
    path VARCHAR(200) COMMENT '访问路径',
    method VARCHAR(10) COMMENT '请求方法',
    status_code INT COMMENT '状态码',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE SET NULL,
    INDEX idx_user (user_id),
    INDEX idx_ip (ip),
    INDEX idx_created_at (created_at)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='访问日志表';

-- ============================================
-- 插入初始数据
-- ============================================

-- 插入默认管理员
INSERT INTO users (username, password, real_name, role, status) VALUES
('admin', '$2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lhWy', '系统管理员', 'admin', 1);
-- 密码是: admin123 (使用bcrypt加密)

-- 插入默认教师
INSERT INTO users (username, password, email, real_name, role, status) VALUES
('teacher1', '$2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lhWy', 'teacher1@huaxia.edu.cn', '李四', 'teacher', 1),
('teacher2', '$2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lhWy', 'teacher2@huaxia.edu.cn', '王五', 'teacher', 1);

-- 插入默认学生
INSERT INTO users (username, password, email, real_name, role, status) VALUES
('student1', '$2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lhWy', 'student1@huaxia.edu.cn', '张三', 'student', 1),
('student2', '$2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lhWy', 'student2@huaxia.edu.cn', '赵六', 'student', 1);

-- 插入学院
INSERT INTO colleges (name, code, description, dean) VALUES
('计算机学院', 'CS', '计算机学院致力于培养计算机科学领域的优秀人才', '李四'),
('机械工程学院', 'ME', '机械工程学院是学校的重点学院之一', '王五'),
('外国语学院', 'FL', '外国语学院培养多语种人才', '赵七'),
('经济管理学院', 'EM', '经济管理学院涵盖经济与管理两大领域', '钱八');

-- 插入专业
INSERT INTO majors (college_id, name, code, degree_type, duration) VALUES
(1, '计算机科学与技术', 'CS01', 'bachelor', 4),
(1, '软件工程', 'CS02', 'bachelor', 4),
(2, '机械设计制造及其自动化', 'ME01', 'bachelor', 4),
(3, '英语', 'FL01', 'bachelor', 4),
(4, '工商管理', 'EM01', 'bachelor', 4);

-- 插入教师
INSERT INTO teachers (teacher_id, user_id, name, college_id, title, gender) VALUES
('T001', 2, '李四', 1, '教授', 'male'),
('T002', 3, '王五', 2, '副教授', 'male');

-- 插入学生
INSERT INTO students (student_id, user_id, name, gender, college_id, major_id, grade, enrollment_date) VALUES
('2024001', 4, '张三', 'male', 1, 1, '2024级', '2024-09-01'),
('2024002', 5, '赵六', 'female', 2, 3, '2024级', '2024-09-01');

-- 插入课程
INSERT INTO courses (course_code, name, credits, hours, type, college_id) VALUES
('C001', '数据结构与算法', 4.0, 64, 'required', 1),
('C002', '数据库原理', 3.5, 56, 'required', 1),
('C003', '计算机网络', 3.0, 48, 'required', 1),
('C004', '机械原理', 4.0, 64, 'required', 2);

-- 插入新闻
INSERT INTO news (title, category, content, author_id, status, published_at) VALUES
('华夏大学入选"双一流"建设高校名单', '学校新闻', '近日，教育部公布新一轮"双一流"建设高校名单，华夏大学多个学科成功入选。', 1, 1, '2024-12-20 10:00:00'),
('我校举办国际学术研讨会', '学术动态', '来自20多个国家和地区的专家学者齐聚华夏大学，共同探讨前沿科技发展。', 1, 1, '2024-12-18 14:30:00'),
('2025年研究生招生简章发布', '招生信息', '华夏大学2025年硕士研究生招生专业目录及报考指南现已公布，欢迎报考。', 1, 1, '2024-12-15 09:00:00');

-- 插入公告
INSERT INTO notices (title, content, type, priority, status, publish_at) VALUES
('系统维护通知', '系统将于2024年12月25日凌晨2:00-6:00进行维护，期间无法访问。', 'important', 1, 1, '2024-12-23 10:00:00'),
('新学期选课安排', '2025年春季学期选课时间为2025年1月5日-1月10日，请同学们注意时间。', 'notice', 0, 1, '2024-12-22 15:00:00'),
('系统功能升级公告', '教务系统新增在线选课、成绩查询等功能。', 'update', 0, 1, '2024-12-20 11:00:00');

-- 插入系统设置
INSERT INTO settings (key_name, value, description) VALUES
('site_title', '华夏大学', '网站标题'),
('site_description', '华夏大学是一所历史悠久、声誉卓著的综合性大学。', '网站描述'),
('contact_phone', '010-12345678', '联系电话'),
('contact_email', 'info@huaxia.edu.cn', '联系邮箱'),
('contact_address', '北京市海淀区XX路123号', '联系地址');

-- 完成
-- ============================================
-- 数据库创建完成！
-- ============================================
