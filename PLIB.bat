echo off
setlocal enabledelayedexpansion
color 0f
title PLIB - @Maxwellcrafter && rem (Programming Language In Batch)
cls

set lineCount=1

:getMode
echo Would you like to load an existing file or write a new program? (load/new)
set /p mode="> "
if /i "!mode!"=="load" goto getExisting
if /i "!mode!"=="new" cls && goto getNew
cls
echo Unknown option "!mode!", please enter either LOAD or NEW
goto getMode

:getExisting
cls
echo Files: 
for %%f in (*.plib) do (
if "%%~xf"==".plib" set file=%%f
echo !file:~0,-5!
)
echo.
echo Type the name of the file that you want to run:
set /p fileChoice="> "
if not exist "!fileChoice!.plib" set fileChoice=!fileChoice:~0,-5!
if not exist "!fileChoice!.plib" goto getExisting
for /f "tokens=*" %%a in (!fileChoice!.plib) do (
set line_!lineCount!=%%a
if "%%a"=="end" goto go
set /a lineCount=lineCount+1
)
goto go
rem goto getExisting

:getNew
set current=000!lineCount!
set current=!current:~-4!
set /p input="!current!> "
set line_!lineCount!=!input!
if "!input!"=="end" goto go
set /a lineCount=lineCount+1
goto getNew

:go
cls
set current=0

set a=0

:main
set /a current=current+1

if "!line_%current%!"=="" goto main
if "!line_%current%:~0,3!"=="end" goto end
if "!line_%current%:~0,5!"=="clear" cls && goto main
if "!line_%current%:~0,8!"=="println " echo !line_%current%:~8,64! && goto main
if "!line_%current%:~0,6!"=="print " echo|set /p="!line_%current%:~6,64!" && goto main
if "!line_%current%:~0,5!"=="goto " set current=!line_%current%:~5,64! && set /a current=current-1 && goto main
if "!line_%current%:~0,3!"=="inc" set /a a=a+1 && goto main
if "!line_%current%:~0,3!"=="dec" set /a a=a-1 && goto main
if "!line_%current%:~0,3!"=="val" echo|set /p="!a!" && goto main
if "!line_%current%:~0,4!"=="wait" ping 127.1 -n 2 > nul && goto main

rem echo Unknown command "!line_%current%!"

goto main

:end
echo.
echo.
echo Reached end of file
pause > nul
exit
