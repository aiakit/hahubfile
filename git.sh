#!/bin/bash

# 确保脚本执行过程中出错时立即停止
set -e

# 提示用户输入提交信息（如果未通过参数传入）
COMMIT_MSG=${1:-"update"}

# 1. 创建一个无历史的临时分支
git checkout --orphan temp_branch

# 2. 添加所有文件到暂存区（忽略.gitignore中指定的文件）
git add .

# 3. 提交当前变更（这会成为唯一的提交）
git commit -m "$COMMIT_MSG"

# 4. 删除原来的主分支（假设主分支名为main，若为master则替换）
git branch -D main

# 5. 将临时分支重命名为主分支
git branch -m main

# 6. 强制推送到远程，覆盖所有历史
git push --force origin main

# 7. 提示操作完成
echo "✅ 提交完成，远程仓库已只保留本次提交历史"