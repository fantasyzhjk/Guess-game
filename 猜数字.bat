@echo off&setlocal enabledelayedexpansion
title ������Ϸ
:begin
REM �����￪ʼ
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
choice /n /c SLE /m ��S��ʼ������L�鿴��߼�¼����E�˳�����
if %errorlevel%==1 goto start
if %errorlevel%==2 goto list
if %errorlevel%==3 exit
echo %errorlevel%
pause
:list
REM ��������߼�¼
cls
color 0f
if exist guess.txt (
type guess.txt
@echo.����������ء�
goto pause
)
echo ������߼�¼��
goto back
:start
REM ��ʽ��ʼ����
cls
color 0f
set max=65536
set min=1
set a=1
set /a d=%random%*%random%/16384
@echo.game started!
@echo.����һ��������Χ��1-65536֮��
:input
set /p input=
if "%input%"=="65537" (
echo "��ϲ���ҵ��ʵ��������𰸣�%d%��������������1�Σ�"
goto input
)
if %input% gtr %max% goto max
if %input% gtr %d% goto setmax
:max
if %input% gtr %max% (
echo ������Χ���˴β²ⲻ�ƣ����������룡
goto input
)
if %input% gtr %d% (
echo ̫���ˣ���Χ��%min%��%max%֮�䣡
set /a a+=1
goto input
)
if %input% gtr %min% goto setmin
:min
if %input% lss %d% (
echo ̫С�ˣ���Χ��%min%��%max%֮�䣡
set /a a+=1
goto input
)
if "%input%"=="%d%" (
REM �¶Ժ�
cls
echo YOU WIN!!!!!
echo ��һ������%a%��,��F��������B����
echo ע�����ҽ�����Ľ��ΪĿǰ��Сֵʱ�������Ч����guess�ļ��в鿴�������¼��
echo ��guess�ļ��в鿴�������¼��
)
    choice /n /c FB
if %errorlevel%==1 goto save
if %errorlevel%==2 goto begin
:end
REM ����
pause
exit
:setmin
REM ���������
set min=%input%
goto min
:setmax
REM ���������
set max=%input%
goto max
:save
REM ���guess.txt�Ƿ����
cls
if exist guess.txt (
goto setpatch
)
@echo.��ʷ��߼�¼Ϊ>guess.txt
@echo.>>guess.txt
@echo.����������ء�>>guess.txt
:setpatch
REM ��ȡguess.txt�ļ������߼�¼
set v1=patch
set i=1
for /f %%i in (guess.txt) do (
    if !i! equ 2 set !v1!=%%i
    set /a i+=1
)
REM ����
if %a% lss !%v1%! (
echo ��ǰ���Ϊ��ʷ�¼�¼���ѱ����棡
@echo.��ʷ��߼�¼Ϊ>guess.txt
@echo.%a%>>guess.txt
goto back
)
echo ��ǰ�������/������ʷ��¼��������Ч��
:back
REM ���ص���ͷ
echo ����������ء�
:pause
pause>nul
goto begin