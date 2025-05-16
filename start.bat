CHCP 65001
@echo off

setlocal enabledelayedexpansion

:: 使用PowerShell获取标准时间戳（兼容所有语言环境）

for /f "delims=" %%t in ('powershell -Command "Get-Date -Format 'yyyy-MM-dd HH:mm:ss.fff'"') do (
    set "timestamp=%%t"
)

echo 正在获取时间戳...
:: 替换冒号为点号并移除毫秒（保留到秒）
set "timestamp=!timestamp:~0,-4!"

echo 时间已获取 %timestamp% 

:: 获取提交说明
set /p commit_message=提交说明: 
set "up=- [%timestamp%] %commit_message%"

echo 将添加 %up%

:: 添加所有更改

git add .

echo 成功添加所有更改

:: 提交更改

git commit -m "%commit_message%"

echo 已提交更改

:: 推送更改
git push web main
git push myserver main 


echo 已推送至所有仓库的main分支
pause