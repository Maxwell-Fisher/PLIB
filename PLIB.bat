echo off
setlocal enabledelayedexpansion
color 0f
title PLIB - @Maxwellcrafter %= Programming Language In Batch =%
cls

set lineCount=1

:getMode
echo Would you like to load an existing file or write a new program? (load/new)
set /p mode="> "
if /i "!mode!"=="load" goto getExisting
cls
if /i "!mode!"=="new" (
goto getNew
)
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

set read=!line_%current%:$val=%a%!

if "!read:~0,3!"=="end" (
    goto end
) else if "!read:~0,3!"=="clr" (
    cls
) else if "!read:~0,4!"=="pln " (
    echo !read:~4,64!
) else if "!read:~0,4!"=="pnt " (
    <nul set /p="!read:~6,64!"
) else if "!read:~0,4!"=="got " (
    set current=!read:~4,64!
    set /a current=current-1
) else if "!read:~0,3!"=="inc" (
    set /a a+=1
) else if "!read:~0,3!"=="dec" (
    set /a a=a-=1
) else if "!read:~0,3!"=="wat" (
    ping 127.1 -n 2 > nul
) else if "!read:~0,4!"=="col " (
    color !read:~4,2!
)
goto main

:end
echo.
echo.
echo Reached end of file
pause > nul
exit
