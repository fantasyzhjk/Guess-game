@echo off&setlocal enabledelayedexpansion
title 猜数游戏
:begin
REM 从这里开始
color ce
cls
@echo.##################################################
@echo...................................................
@echo.....#........#.....#......#.......#####...........
@echo.....#........##...##.....#.#.....#.....#.....#####
@echo.....#........#.#.#.#....#####....#.....#.....#....
@echo.....#........#..#..#...#.....#...#.....#.....##...
@echo.....#######..#.....#..#.......#....###............
@echo...........................................########
@echo...................................................
@echo.##################################################
@echo.
@echo.
@echo.
choice /n /c SLE /m 按S开始猜数，L查看最高纪录，按E退出程序。
if %errorlevel%==1 goto start
if %errorlevel%==2 goto list
if %errorlevel%==3 exit
echo %errorlevel%
pause
:list
REM 这里是最高纪录
cls
color 0f
if exist guess.txt (
type guess.txt
@echo.按任意键返回。
goto pause
)
echo 暂无最高纪录。
goto back
:start
REM 正式开始猜数
cls
color 0f
set max=65536
set min=1
set a=1
set /a d=%random%*%random%/16384
@echo.game started!
@echo.输入一个数，范围在1-65536之内
:input
set /p input=
if "%input%"=="65537" (
echo "恭喜，找到彩蛋！揭晓答案：%d%（你仍需再输入1次）"
goto input
)
if %input% gtr %max% goto max
if %input% gtr %d% goto setmax
:max
if %input% gtr %max% (
echo 超出范围！此次猜测不计，请重新输入！
goto input
)
if %input% gtr %d% (
echo 太大了！范围在%min%和%max%之间！
set /a a+=1
goto input
)
if %input% gtr %min% goto setmin
:min
if %input% lss %d% (
echo 太小了！范围在%min%和%max%之间！
set /a a+=1
goto input
)
if "%input%"=="%d%" (
REM 猜对后
cls
echo YOU WIN!!!!!
echo 你一共猜了%a%次,按F保存结果，B返回
echo 注：当且仅当你的结果为目前最小值时结果才有效！在guess文件中查看你的最快纪录！
echo 在guess文件中查看你的最快纪录！
)
    choice /n /c FB
if %errorlevel%==1 goto save
if %errorlevel%==2 goto begin
:end
REM 结束
pause
exit
:setmin
REM 这里请忽略
set min=%input%
goto min
:setmax
REM 那里请忽略
set max=%input%
goto max
:save
REM 检测guess.txt是否存在
cls
if exist guess.txt (
goto setpatch
)
@echo.历史最高纪录为>guess.txt
@echo.>>guess.txt
@echo.按任意键返回。>>guess.txt
:setpatch
REM 获取guess.txt文件里的最高纪录
set v1=patch
set i=1
for /f %%i in (guess.txt) do (
    if !i! equ 2 set !v1!=%%i
    set /a i+=1
)
REM 保存
if %a% lss !%v1%! (
echo 当前结果为历史新纪录，已被保存！
@echo.历史最高纪录为>guess.txt
@echo.%a%>>guess.txt
goto back
)
echo 当前结果大于/等于历史记录，保存无效！
:back
REM 返回到开头
echo 按任意键返回。
:pause
pause>nul
goto begin