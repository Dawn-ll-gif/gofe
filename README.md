# 大学校园网站信息管理系统

这是一个基于PHP和MySQL开发的大学校园网站信息管理系统，包含前端展示页面和后端管理系统。

## 功能特点

### 前端展示功能
- 学校首页展示
- 学校新闻动态
- 学校简介
- 招生就业信息
- 校园环境展示

### 后端管理功能
- 用户管理：管理学生、教师和管理员账号
- 新闻管理：发布、编辑和删除新闻信息
- 学校简介管理：管理学校历史、办学愿景、组织架构和师资力量
- 招生就业管理：管理招生信息、就业信息和政策法规
- 校园环境管理：管理校园图片和环境介绍
- 系统设置：管理网站基本信息和联系方式

## 技术栈

- **前端**：HTML5, CSS3, JavaScript, Font Awesome
- **后端**：PHP 7.0+
- **数据库**：MySQL 5.5+
- **工具库**：CKEditor（富文本编辑器）

## 安装与配置

### 1. 环境要求
- PHP 7.0 或更高版本
- MySQL 5.5 或更高版本
- Web服务器（Apache或Nginx）

### 2. 数据库设置

#### 方法一：使用phpMyAdmin导入
1. 创建一个名为`campus_website`的数据库
2. 导入`database.sql`文件到数据库中

#### 方法二：使用命令行导入
```bash
# 创建数据库
mysql -u root -p -e "CREATE DATABASE IF NOT EXISTS campus_website;"

# 导入数据库表结构和示例数据
mysql -u root -p campus_website < database.sql
```

### 3. 配置文件

修改`php/db_connect.php`文件，根据您的MySQL配置修改数据库连接信息：

```php
<?php
$servername = "localhost";
$username = "root";        // 您的MySQL用户名
$password = "password";    // 您的MySQL密码
$dbname = "campus_website";

// 创建连接
$conn = mysqli_connect($servername, $username, $password, $dbname);

// 检查连接
if (!$conn) {
    die("连接失败: " . mysqli_connect_error());
}
?>
```

### 4. 文件权限设置

确保`uploads/`目录具有写入权限：

```bash
chmod -R 777 uploads/
```

## 使用说明

### 1. 访问前端网站

直接在浏览器中访问网站根目录：
```
http://localhost/校园/SLLL/
```

### 2. 访问管理系统

在浏览器中访问管理系统登录页面：
```
http://localhost/校园/SLLL/admin/login.html
```

### 3. 管理员登录

默认管理员账号：
- **用户名**：admin
- **密码**：password123

### 4. 管理功能说明

#### 用户管理
- 查看所有用户列表
- 添加新用户
- 删除用户

#### 新闻管理
- 发布新新闻
- 编辑现有新闻
- 删除新闻
- 支持添加新闻图片

#### 学校简介管理
- 添加学校简介内容
- 编辑简介内容
- 按分类管理（历史、愿景、组织架构、师资力量）

#### 招生就业管理
- 添加招生就业信息
- 编辑现有信息
- 支持上传附件文件
- 按分类管理（招生信息、就业信息、政策法规）

#### 校园环境管理
- 上传校园图片
- 编辑图片信息
- 按分类管理（教学楼、图书馆、实验室、运动场地、宿舍、其他）

#### 系统设置
- 修改网站名称
- 修改网站描述
- 修改联系方式

## 文件结构

```
├── index.html              # 网站首页
├── news.html               # 新闻页面
├── about.html              # 学校简介页面
├── admissions.html         # 招生就业页面
├── campus.html             # 校园环境页面
├── contact.html            # 联系我们页面
├── database.sql            # 数据库表结构和示例数据
├── README.md               # 项目说明文档
├── css/
│   └── style.css           # 网站样式文件
├── images/
│   └── [图片资源文件]     # 网站图片资源
├── js/
│   └── scripts.js          # 网站JavaScript文件
├── php/
│   ├── db_connect.php      # 数据库连接配置
│   ├── login.php           # 用户登录处理
│   └── admin_login.php     # 管理员登录处理
├── admin/
│   ├── login.html          # 管理员登录页面
│   ├── index.php           # 管理系统首页
│   ├── users.php           # 用户管理页面
│   ├── news.php            # 新闻管理页面
│   ├── about.php           # 学校简介管理页面
│   ├── admissions.php      # 招生就业管理页面
│   ├── campus.php          # 校园环境管理页面
│   ├── settings.php        # 系统设置页面
│   └── logout.php          # 退出登录页面
└── uploads/                # 上传文件存储目录
```

## 安全建议

1. 请务必修改默认管理员密码
2. 不要在生产环境中使用弱密码
3. 定期备份数据库
4. 限制管理系统的访问IP
5. 保持PHP和MySQL版本最新

## 更新日志

- v1.0.0 (2023-11-10)
  - 初始版本发布
  - 实现完整的前端展示功能
  - 实现完整的后端管理功能

## 许可证

本项目采用MIT许可证。

## 联系方式

如有问题或建议，请联系：
- 邮箱：admin@campus.edu
- 电话：010-12345678
