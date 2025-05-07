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

:: 将提交信息写入文件（第八行）

set "target_file=content\page\update\index.md"
set "temp_file=%temp%\temp_index.md"

:: 检查文件是否存在，不存在则创建

if not exist "%target_file%" (
    echo. > "%target_file%"
)

:: 创建临时文件并插入内容
(
    for /f "tokens=1* delims=:" %%a in ('findstr /n "^" "%target_file%"') do (
        if %%a equ 8 (
            echo %up%
        )
        echo.%%b
    )
) > "%temp_file%"

:: 如果文件行数不足8行，则追加到末尾

for /f %%i in ('type "%target_file%" ^| find /c /v ""') do set "line_count=%%i"
if %line_count% lss 8 (
    for /l %%i in (%line_count%,1,9) do (
        echo. >> "%temp_file%"
    )
    echo %up% >> "%temp_file%"
)

:: 用临时文件替换原文件（使用UTF-8编码）

powershell -command "[IO.File]::WriteAllText('%target_file%', [IO.File]::ReadAllText('%temp_file%'), [Text.Encoding]::UTF8)"

echo 提交说明已添加到 %target_file%

:: 删除临时文件

del "%temp_file%"

:: 添加所有更改

git add .

echo 成功添加所有更改

:: 提交更改

git commit -m "%commit_message%"

echo 已提交更改

:: 推送更改
git push -f web1 main
git push myserver main


echo 已推送至所有仓库的main分支
pause