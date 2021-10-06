%= Sets up the window =%
echo off
cls
setlocal enabledelayedexpansion
color 0f
title PLIB - @Maxwellcrafter %= Programming Language In Batch =%
set lineCount=1

:getMode %= Selects whether to make a new temporary script or load an existing program =%
echo Would you like to load an existing file or write a new program? (load/new)
set /p mode="> "
if /i "!mode!"=="load" goto getExisting
cls
if /i "!mode!"=="new" (
goto getNew
)
echo Unknown option "!mode!", please enter either LOAD or NEW
goto getMode

:getExisting %= Selects and reads an existing file into memory with some formatting =%
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
set /a lineCount=lineCount+2
goto go

:getNew %= Gets and loads user input into memory =%
set current=000!lineCount!
set current=!current:~-4!
set /p input="!current!> "
set line_!lineCount!=!input!
if "!input!"=="end" goto go
set /a lineCount=lineCount+1
goto getNew

:go
cls
set current=0 %= Sets the current line to 0 =%

set a=0 %= Sets $val to 0 =%

:main
set /a current=current+1 %= Adds 1 to current line, so that the program reads the next line down =%

if "!current!"=="!lineCount!" goto end %= Runs when the end of the file is reached if there is no end command =%

set read=!line_%current%:$val=%a%! %= Sets the current command to the line being read, and translates $val =%

if "!read:~0,3!"=="end" ( %= Ends script =%
    goto end
) else if "!read:~0,3!"=="clr" ( %= Clears console window =%
    cls
) else if "!read:~0,4!"=="pln " ( %= Prints text with a new line =%
    echo !read:~4,64!
) else if "!read:~0,4!"=="pnt " ( %= Prints text without a new line =%
    <nul set /p="!read:~4,64!"
) else if "!read:~0,4!"=="got " ( %= Goes to the specified line =%
    set current=!read:~4,64!
    set /a current=current-1
) else if "!read:~0,3!"=="inc" ( %= Adds 1 to $val =%
    set /a a+=1
) else if "!read:~0,3!"=="dec" ( %= Subtracts 1 from $val =%
    set /a a=a-=1
) else if "!read:~0,3!"=="wat" ( %= Waits for 1 second before continuing =%
    ping 127.1 -n 2 > nul
) else if "!read:~0,4!"=="col " ( %= Sets the window colour to the selected value =%
    color !read:~4,2!
) else if "!read:~0,4!"=="mth " ( %= Does math =%
    set /a output=!read:~4,64!
    echo !output!
)
goto main

:end %= This runs then the script is over =%
color 0F
echo.
echo.
echo Reached end of file
pause > nul
exit
