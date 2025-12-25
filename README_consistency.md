说明 — 一致性检查与运行步骤

文件：consistency_checks.sql
用途：在测试或本地数据库上运行一组通用的一致性检查，输出问题样本供人工审核。

运行前注意事项：
- 强烈建议在测试库或数据库备份上运行，避免误操作。
- 在运行前请把 SQL 文件中的示例表名/列名替换为你的实际表名/列名。
- 如果数据库较大，先只在关键表上运行或加上 LIMIT 以查看样本。

在 Windows PowerShell 上运行（示例）：
```powershell
# 进入包含文件的目录
cd "d:/校园/SLLL"

# 直接运行 SQL 并把输出保存到文本文件（替换 your_db_name）
mysql -u root -p your_db_name < consistency_checks.sql > consistency_results.txt
```

如果输出较多，建议压缩或只提取部分结果：
```powershell
# 运行并压缩结果
mysql -u root -p your_db_name < consistency_checks.sql | gzip > consistency_results.txt.gz
```

后续流程建议：
1) 把生成的 `consistency_results.txt`（或 `.gz`）发回给我，我将基于结果生成具体的修复/迁移脚本。
2) 对关键问题先在测试库用事务化 SQL 验证修复效果，并保留数据快照。 
3) 在确认无误后把迁移脚本应用到生产库（先备份）。

若你愿意，我可以把部分查询替换为你实际的表/列名并生成针对性的修复脚本（需你把 `consistency_results.txt` 或部分表结构发来）。
