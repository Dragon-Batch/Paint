@echo off
setlocal enabledelayedexpansion

echo @echo off^&start /b test1.bat >test1.bat
for /l %%x in (0 1 400) do (
    set "Var_In_Y=batbox.exe"
    for /l %%y in (0 1 100) do (
        set "Var_In_Y=!Var_In_Y! /g %%x %%y /a 32 /c 0x00 /a 32 /c 0xaa"
    )
    echo !Var_In_Y!>>test1.bat
)