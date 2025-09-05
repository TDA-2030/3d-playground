@echo off
chcp 65001 >nul
setlocal

:: 读取用户输入的项目名
set /p PROJECT_NAME=请输入项目名称（直接回车退出）： 

:: 检查是否为空
if "%PROJECT_NAME%"=="" (
    echo [提示] 未输入项目名称，程序退出。
    pause
    exit /b 0
)

:: 检查目录是否已存在
if exist "%PROJECT_NAME%" (
    echo [错误] 目录 "%PROJECT_NAME%" 已经存在！
    pause
    exit /b 1
)

:: 创建新目录
mkdir "%PROJECT_NAME%"
if errorlevel 1 (
    echo [错误] 创建目录失败！
    pause
    exit /b 1
)

:: 在新目录中创建 README.md（逐行重定向，避免括号分组导致的转义问题）
> "%PROJECT_NAME%\README.md" echo # %PROJECT_NAME%
>> "%PROJECT_NAME%\README.md" echo.
>> "%PROJECT_NAME%\README.md" echo ![cover](cover.png)

:: 生成空的 cover.png 占位文件
type nul > "%PROJECT_NAME%\cover.png"

:: 如果当前目录没有 README.md 就创建一个
if not exist "README.md" (
    echo [提示] 当前目录没有 README.md，正在创建...
    echo. > "README.md"
)

:: 在当前目录 README.md 追加一行链接
echo - [%PROJECT_NAME%](%PROJECT_NAME%) >> "README.md"

echo [完成] 已创建项目 "%PROJECT_NAME%" 并更新 README.md。
pause
endlocal
