-- consistency_checks.sql
-- 在使用前：替换示例表名/列名为你的实际值；建议在测试库运行
-- 运行方式（PowerShell）：
-- mysql -u root -p your_db_name < consistency_checks.sql > consistency_results.txt

-- 1) 列出所有表的行数（快速概览）
SELECT TABLE_NAME, TABLE_ROWS
FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_SCHEMA = DATABASE();

-- 2) 查找存在外键引用但父表缺失的孤立子行示例
-- 替换 child_table, parent_table, fk_col
SELECT c.*
FROM child_table c
LEFT JOIN parent_table p ON c.fk_col = p.id
WHERE c.fk_col IS NOT NULL AND p.id IS NULL
LIMIT 100;

-- 3) 查找重复的唯一键候选（示例：users.username）
SELECT username, COUNT(*) cnt
FROM users
GROUP BY username
HAVING cnt > 1
LIMIT 100;

-- 4) 查找 NULL 或非法格式（示例：email）
SELECT id, email FROM users WHERE email IS NULL OR email NOT LIKE '%@%'
LIMIT 100;

-- 5) 查找违背期望范围或类型的值（示例：age）
SELECT id, age FROM users WHERE age IS NULL OR age < 0 OR age > 200 LIMIT 100;

-- 6) 列出每个外键值的引用计数（可帮助发现异常）
-- 替换 child_table, fk_col
SELECT fk_col, COUNT(*) cnt FROM child_table GROUP BY fk_col ORDER BY cnt DESC LIMIT 100;

-- 7) 查找可能需要唯一索引的重复组合示例（示例：orders (user_id, order_no)）
SELECT user_id, order_no, COUNT(*) cnt
FROM orders
GROUP BY user_id, order_no
HAVING cnt > 1
LIMIT 100;

-- 8) 检查时间类字段异常（示例：created_at>NOW 或 在非常久之前）
SELECT id, created_at FROM some_table WHERE created_at > NOW() OR created_at < '1970-01-01' LIMIT 100;

-- 9) 检查外键完整性（列出可能需要父表的子表行数统计）
-- 依次替换 parent_table/child_table/fk_col 并运行
-- SELECT COUNT(*) AS orphan_cnt FROM child_table c LEFT JOIN parent_table p ON c.fk_col = p.id WHERE c.fk_col IS NOT NULL AND p.id IS NULL;

-- 10) 输出表级统计（索引数、列数）
SELECT TABLE_NAME, COUNT(COLUMN_NAME) AS columns_count
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_SCHEMA = DATABASE()
GROUP BY TABLE_NAME
ORDER BY columns_count DESC;

-- 11) 事务化示例：删除孤立子行（请先人工审核）
-- START TRANSACTION;
-- DELETE c FROM child_table c LEFT JOIN parent_table p ON c.fk_col = p.id WHERE c.fk_col IS NOT NULL AND p.id IS NULL LIMIT 1000;
-- COMMIT;

-- 12) 生成示例修复建议输出（文本说明，用于人工复核）
SELECT 'REVIEW: orphan child rows in child_table referencing parent_table' AS note;

-- 结束
