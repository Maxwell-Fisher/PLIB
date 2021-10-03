echo off
setlocal enabledelayedexpansion
color 0f
title PLIB - @Maxwellcrafter && rem (Programming Language In Batch)
cls

set lineCount=1

:get
set current=000!lineCount!
set current=!current:~-4!
set /p input="!current!> "
set line_!lineCount!=!input!
if "!input!"=="end" goto go
set /a lineCount=lineCount+1
goto get

:go
cls
set current=0

set a=0

:main
set /a current=current+1


if "!line_%current%:~0,3!"=="end" goto end
if "!line_%current%:~0,5!"=="clear" cls && goto main
if "!line_%current%:~0,8!"=="println " echo !line_%current%:~8,64! && goto main
if "!line_%current%:~0,6!"=="print " echo|set /p="!line_%current%:~6,64!" && goto main
if "!line_%current%:~0,5!"=="goto " set current=!line_%current%:~5,64! && set /a current=current-1 && goto main
if "!line_%current%:~0,3!"=="inc" set /a a=a+1 && goto main
if "!line_%current%:~0,3!"=="dec" set /a a=a-1 && goto main
if "!line_%current%:~0,3!"=="val" echo|set /p="!a!" && goto main
if "!line_%current%:~0,4!"=="wait" ping 127.1 -n 2 > nul && goto main

goto main

:end
echo.
echo.
echo Reached end of file
pause > nul
exit
