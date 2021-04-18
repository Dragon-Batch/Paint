@echo off
setlocal enabledelayedexpansion
Mode 80,38
color 00
cls


set "Mb=Core\MakeBox.bat"
set "Cw=Core\CmdWiz.exe"
!Cw! showcursor 0
set "Sd=Core\savefiledialog.exe"
set "Bb=Core\batbox.exe"
set "Gt=Core\gotoxy.exe"
set "Fn=Core\Fn.dll"
set "Current_Tool=1"
set "MenuBG=0"
set "MenuFG=a"
set "ColorFG=a"
set "ColorBG=c"
set "MainChar=88"


call :DropDownFunctionList
call :CharactersListBorder
call :CharactersList
call :DisplayBorder
call :ColorMenu
call :ColorList

:MainPaintLoop
	for /f "tokens=1-3 delims= " %%a in ('start /b !Fn! mouse') do (
		set "X=%%b"
		set "Y=%%a"

		call :OnClick
		call :DropDownFunctions
		call :GiveChar
		call :GiveColor

		title X:!X! Y:!Y!
	)
goto MainPaintLoop


Rem Functions Below
Rem Drop Down Functions
:DropDownFunctions
if not !X! lss 0 (
	if not !Y! lss 0 (
		if not !X! gtr 53 (
			if not !Y! gtr 0 (
				Rem File Drop Down Function
				if not !X! lss 4 (
					if not !X! gtr 7 (
						!Cw! saveblock Data\File\Use-If-Save 1 2 52 27 forcecode
						!Bb! /g 60 10 /c 0x!ColorBG!!ColorFG! /d "File Drop Down"
						!Bb! /g 0 0 /c 0x!MenuBG!!MenuFG! /a 186 /a 32 /a 32 /a 32 /d "File" /a 32 /a 32 /a 32 /c 0x!MenuBG!!MenuFG! /a 186
						!Bb! /g 0 1 /c 0x!MenuBG!!MenuFG! /a 186 /c 0x8f /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /c 0x8c /d "X" /c 0x8f /a 32 /c 0x!MenuBG!!MenuFG! /a 186
						!Bb! /g 0 2 /c 0x!MenuBG!!MenuFG! /a 186 /c 0x8f /a 32 /d "New" /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /c 0x!MenuBG!!MenuFG! /a 186
						!Bb! /g 0 3 /c 0x!MenuBG!!MenuFG! /a 186 /c 0x8f /a 32 /d "Save" /a 32 /a 32 /a 32 /a 32 /a 32 /c 0x!MenuBG!!MenuFG! /a 186 /a 32
						!Bb! /g 0 4 /c 0x!MenuBG!!MenuFG! /a 186 /c 0x8f /a 32 /d "Open" /a 32 /a 32 /a 32 /a 32 /a 32 /c 0x!MenuBG!!MenuFG! /a 186
						!Bb! /g 0 5 /c 0x!MenuBG!!MenuFG! /a 186 /c 0x8f /a 32 /d "Rename" /a 32 /a 32 /a 32 /c 0x!MenuBG!!MenuFG! /a 186
						!Bb! /g 0 6 /c 0x!MenuBG!!MenuFG! /a 186 /c 0x8f /a 32 /d "Import" /a 32 /a 32 /a 32 /c 0x!MenuBG!!MenuFG! /a 186
						!Bb! /g 0 7 /c 0x!MenuBG!!MenuFG! /a 204 /c 0x!MenuBG!!MenuFG! /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 188
						:FileDropDownClickLoop
						for /f "tokens=1-3 delims= " %%a in ('start /b !Fn! mouse') do (
							set "X=%%b"
							set "Y=%%a"

							title X:!X! Y:!Y!

							Rem Exit Option
							if not !X! lss 9 (
								if not !Y! lss 1 (
									if not !X! gtr 9 (
										if not !Y! gtr 1 (
											call :DropDownFunctionList
											call :CharactersListBorder
											call :DisplayBorder
											!Gt! 1 2 "Data\File\Use-If-Save.gxy"
											exit /b
										)
									)
								)
							)
							Rem New Option
							if not !X! lss 2 (
								if not !Y! lss 2 (
									if not !X! gtr 4 (
										if not !Y! gtr 2 (		
											call :DisplayBorder
											call :DropDownFunctionlist
											!Gt! 1 2 "Data\File\Use-If-New.gxy"
											exit /b
										)
									)
								)
							)
							Rem Save Option
							if not !X! lss 2 (
								if not !Y! lss 3 (
									if not !X! gtr 5 (
										if not !Y! gtr 3 (
											:DropDownSaveLoop
											!Bb! /g 15 12 /c 0x8f /a 32 /c 0x1f /d "Save" /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /c 0x8f /a 32 
											!Bb! /g 15 13 /c 0x8f /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32
											!Bb! /g 15 14 /c 0x8f /a 32 /d "Would You Like To Save?" /a 32 /a 32 /a 32
											!Bb! /g 15 15 /c 0x8f /a 32 /a 32 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32
											!Bb! /g 15 16 /c 0x8f /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32
											!Bb! /g 15 17 /c 0x8f /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32
											!Bb! /g 16 16 /c 0x8f /a 40 /d "Y,N" /a 41 /d ":"
											set /p "TempInput1= "

											if "!TempInput1!"=="y" (
												!Bb! /g 15 12 /c 0x8f /a 32 /c 0x1f /d "Save" /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /c 0x8f /a 32 
												!Bb! /g 15 13 /c 0x8f /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32
												!Bb! /g 15 14 /c 0x8f /a 32 /d "Please Enter a Name" /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32
												!Bb! /g 15 15 /c 0x8f /a 32 /a 32 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32
												!Bb! /g 15 16 /c 0x8f /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32
												!Bb! /g 15 17 /c 0x8f /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32
												!Bb! /g 16 16 /c 0x8f /d "Name:"
												set /p "TempInput2= "

												if exist "Saves\!TempInput2!.gxy" (
													:DropDownSaveOverrideLoop
													!Bb! /g 15 12 /c 0x8f /a 32 /c 0x1f /d "Save" /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /c 0x8f /a 32 
													!Bb! /g 15 13 /c 0x8f /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32
													!Bb! /g 15 14 /c 0x8f /a 32 /d "Override Existing Save?" /a 32 /a 32 /a 32 
													!Bb! /g 15 15 /c 0x8f /a 32 /a 32 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32
													!Bb! /g 15 16 /c 0x8f /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32
													!Bb! /g 15 17 /c 0x8f /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32
													!Bb! /g 16 16 /c 0x8f /a 40 /d "Y,N" /a 41 /d ":"
													set /p "TempInput3= "

													if "!TempInput3!"=="y" (
														!Gt! 1 2 "Data\File\Use-If-Save.gxy"
														call :DropDownFunctionList
														call :DisplayBorder
														set "TempInput1="
														set "TempInput2="
														set "TempInput3="
														exit /b
													) else (
														if "!TempInput3!"=="n" (
															!Gt! 1 2 "Data\File\Use-If-Save.gxy"
															call :DropDownFunctionList
															call :DisplayBorder
															set "TempInput1="
															set "TempInput2="
															set "TempInput3="
															exit /b
														)
														call :DropDownSaveOverrideLoop
														exit /b
													)
												) else (
													type "Data\File\Use-If-Save.gxy">"Saves\!TempInput2!.gxy"
													!Gt! 1 2 "Data\File\Use-If-Save.gxy"
													call :DropDownFunctionList
													call :DisplayBorder
													set "TempInput1="
													set "TempInput2="
													set "TempInput3="
													exit /b
												)
											) else (
												if "!TempInput1!"=="n" (
													call :DropDownFunctionList
													call :DisplayBorder
													!Gt! 1 2 "Data\File\Use-If-Save.gxy"
													exit /b
												)
												call :DropDownSaveLoop
												exit /b
											)
										)
									)
								)
							)
							Rem Open Option
							if not !X! lss 2 (
								if not !Y! lss 4 (
									if not !X! gtr 5 (
										if not !Y! gtr 4 (
											:DropDownOpenLoop
											!Bb! /g 15 12 /c 0x8f /a 32 /c 0x1f /d "Open" /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /c 0x8f /a 32 
											!Bb! /g 15 13 /c 0x8f /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32
											!Bb! /g 15 14 /c 0x8f /a 32 /d "Want To Load a Save?" /a 32 /a 32 /a 32
											!Bb! /g 15 15 /c 0x8f /a 32 /a 32 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32
											!Bb! /g 15 16 /c 0x8f /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32
											!Bb! /g 15 17 /c 0x8f /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32
											!Bb! /g 16 16 /c 0x8f /a 40 /d "Y,N" /a 41 /d ":"
											set /p "TempInput1= "
											if "!TempInput1!"=="y" (
												!Bb! /g 15 12 /c 0x8f /a 32 /c 0x1f /d "Open" /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /c 0x8f /a 32 
												!Bb! /g 15 13 /c 0x8f /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32
												!Bb! /g 15 14 /c 0x8f /a 32 /d "Save Name?" /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32
												!Bb! /g 15 15 /c 0x8f /a 32 /a 32 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32
												!Bb! /g 15 16 /c 0x8f /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32
												!Bb! /g 15 17 /c 0x8f /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32
												!Bb! /g 16 16 /c 0x8f /d "Name:"
												set /p "TempInput2= "

												if exist "Saves\!TempInput2!.gxy" (
													call :DisplayBorder
													call :DropDownFunctionList

													!Gt! 1 2 "Saves\!TempInput2!.gxy"
													exit /b
												) else (
													!Bb! /g 15 12 /c 0x8f /a 32 /c 0x1f /d "Open" /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /c 0x8f /a 32 
													!Bb! /g 15 13 /c 0x8f /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32
													!Bb! /g 15 14 /c 0x8f /a 32 /d "Save Does Not Exist" /a 32 /a 32 /a 32
													!Bb! /g 15 15 /c 0x8f /a 32 /a 32 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32
													!Bb! /g 15 16 /c 0x8f /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32
													!Bb! /g 15 17 /c 0x8f /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32
													!Cw! delay 800
													call :DisplayBorder
													call :DropDownFunctionList
													!Gt! 1 2 "Data\File\Use-If-Save.gxy"
													exit /b
												)
											) else (
												if "!TempInput1!"=="n" (
													!Gt! 1 2 "Data\File\Use-If-Save.gxy"
													call :DisplayBorder
													call :DropDownFunctionList
													exit /b
												)
												call :DropDownOpenLoop
												exit /b
											)
										)
									)
								)
							)
							Rem Rename Option
							if not !X! lss 2 (
								if not !Y! lss 5 (
									if not !X! gtr 7 (
										if not !Y! gtr 5 (
											:DropDownRenameLoop1
											!Bb! /g 15 12 /c 0x8f /a 32 /c 0x1f /d "Rename" /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /c 0x8f /a 32 
											!Bb! /g 15 13 /c 0x8f /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32
											!Bb! /g 15 14 /c 0x8f /a 32 /d "Want To Rename a Save?" /a 32 /a 32
											!Bb! /g 15 15 /c 0x8f /a 32 /a 32 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32
											!Bb! /g 15 16 /c 0x8f /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 
											!Bb! /g 15 17 /c 0x8f /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32
											!Bb! /g 16 16 /c 0x8f /a 40 /d "Y,N" /a 41 /d ":"
											set /p "TempInput1= "
											if "!TempInput1!"=="y" (
												:DropDownRenameLoop2
												!Bb! /g 15 12 /c 0x8f /a 32 /c 0x1f /d "Rename" /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /c 0x8f /a 32 
												!Bb! /g 15 13 /c 0x8f /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32
												!Bb! /g 15 14 /c 0x8f /a 32 /d "Save You Want To Rename" /a 32 /a 32 /a 32
												!Bb! /g 15 15 /c 0x8f /a 32 /a 32 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32
												!Bb! /g 15 16 /c 0x8f /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32
												!Bb! /g 15 17 /c 0x8f /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32
												!Bb! /g 16 16 /c 0x8f /d "Name:"
												set /p "TempInput2= "
												if exist "Saves\!TempInput2!.gxy" (
													:DropDownRenameLoop3
													!Bb! /g 15 12 /c 0x8f /a 32 /c 0x1f /d "Rename" /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /c 0x8f /a 32 
													!Bb! /g 15 13 /c 0x8f /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32
													!Bb! /g 15 14 /c 0x8f /a 32 /d "New Save Name     " /a 32 /a 32 /a 32
													!Bb! /g 15 15 /c 0x8f /a 32 /a 32 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32
													!Bb! /g 15 16 /c 0x8f /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32
													!Bb! /g 15 17 /c 0x8f /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32
													!Bb! /g 16 16 /c 0x8f /d "Name:"
													set /p "TempInput3= "
													if not exist "Saves\!TempInput3!.gxy" (
														:DropDownRenameLoop4
														!Bb! /g 15 12 /c 0x8f /a 32 /c 0x1f /d "Rename" /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /c 0x8f /a 32 
														!Bb! /g 15 13 /c 0x8f /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32
														!Bb! /g 15 14 /c 0x8f /a 32 /d "Are You Sure?" /a 32 /a 32 /a 32
														!Bb! /g 15 15 /c 0x8f /a 32 /a 32 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32
														!Bb! /g 15 16 /c 0x8f /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32
														!Bb! /g 15 17 /c 0x8f /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32
														!Bb! /g 16 16 /c 0x8f /a 40 /d "Y,N" /a 41 /d ":"
														set /p "TempInput4= "
														if "!TempInput4!"=="y" (
															cd Saves
															Rename "!TempInput2!.gxy" "!TempInput3!.gxy"
															cd..
															call :DisplayBorder
															call :DropDownFunctionList
															!Gt! 1 2 "Data\File\Use-If-Save.gxy"
															exit /b
														) else (
															if "!TempInput4!"=="n" (
																call :DisplayBorder
																call :DropDownFunctionList
																!Gt! 1 2 "Data\File\Use-If-Save.gxy"
																exit /b
															)
															call :DropDownRenameLoop4
															exit /b
														)
													) else (
														!Bb! /g 15 12 /c 0x8f /a 32 /c 0x1f /d "Rename" /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /c 0x8f /a 32 
														!Bb! /g 15 13 /c 0x8f /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32
														!Bb! /g 15 14 /c 0x8f /a 32 /d "Name Allready Exists" /a 32 /a 32 /a 32
														!Bb! /g 15 15 /c 0x8f /a 32 /a 32 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32
														!Bb! /g 15 16 /c 0x8f /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32
														!Bb! /g 15 17 /c 0x8f /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32
														!Cw! delay 800
														call :DropDownRenameLoop3
														exit /b
													)
														
												) else (
													!Bb! /g 15 12 /c 0x8f /a 32 /c 0x1f /d "Rename" /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /c 0x8f /a 32 
													!Bb! /g 15 13 /c 0x8f /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32
													!Bb! /g 15 14 /c 0x8f /a 32 /d "Name Allready Exists" /a 32 /a 32 
													!Bb! /g 15 15 /c 0x8f /a 32 /a 32 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32
													!Bb! /g 15 16 /c 0x8f /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32
													!Bb! /g 15 17 /c 0x8f /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32
													!Cw! delay 800
													call ::DropDownRenameLoop2
													exit /b
												)

											) else (
												if "!TempInput1!"=="n" (
													call :DisplayBorder
													call :DropDownFunctionList
													!Gt! 1 2 "Data\File\Use-If-Save.gxy"
													exit /b
												)
												call :DropDownRenameLoop1
												exit /b
											)
										)
									)
								)
							)
							Rem Import Option 
							if not !X! lss 2 (
								if not !Y! lss 6 (
									if not !X! gtr 8 (
										if not !Y! gtr 2 (
											!Bb! /g 0 0
											exit /b
										)
									)
								)
							)
						)
						goto FileDropDownClickLoop
					)
				)

				Rem Settings Drop Down Function
				if not !X! lss 15 (
					if not !Y! lss 0 (
						if not !X! gtr 22 (
							if not !Y! gtr 0 (
								!Bb! /g 60 10 /c 0x!ColorBG!!ColorFG! /d "Settings Drop Down"
								exit /b
							)
						)
					)
				)
				Rem Library Drop Down Function
				if not !X! lss 30 (
					if not !Y! lss 0 (
						if not !X! gtr 36 (
							if not !Y! gtr 0 (
								!Bb! /g 60 10 /c 0x!ColorBG!!ColorFG! /d "Library Drop Down"
								exit /b
							)
						)
					)
				)
				Rem Export Drop Down Function
				if not !X! lss 44 (
					if not !Y! lss 0 (
						if not !X! gtr 36 (
							if not !Y! gtr 49 (
								!Bb! /g 60 10 /c 0x!ColorBG!!ColorFG! /d "Export Drop Down"
								exit /b
							)
						)
					)
				)
			
			)
		)
	)
) else (exit /b)

Rem Drop Down Function List
	:DropDownFunctionList
	!Bb! /g 0 0 /c 0x!MenuBG!!MenuFG! /a 186 /d "   File   " /a 186 /d "   Settings   " /a 186 /d "   Library   " /a 186 /d "   Export   " /a 186
	exit /b



Rem Display Border
	:DisplayBorder
	!Bb! /g 0 1 /c 0x!MenuBG!!MenuFG! /a 204 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 202 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 202 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 202 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 185 /g 0 2 /a 186 /g 53 2 /a 186 /g 0 3 /a 186 /g 53 3 /a 186 /g 0 4 /a 186 /g 53 4 /a 186 /g 0 5 /a 186 /g 53 5 /a 186 /g 0 6 /a 186 /g 53 6 /a 186 /g 0 7 /a 186 /g 53 7 /a 186 /g 0 8 /a 186 /g 53 8 /a 186 /g 0 9 /a 186 /g 53 9 /a 186 /g 0 10 /a 186 /g 53 10 /a 186 /g 0 11 /a 186 /g 53 11 /a 186 /g 0 12 /a 186 /g 53 12 /a 186 /g 0 13 /a 186 /g 53 13 /a 186 /g 0 14 /a 186 /g 53 14 /a 186 /g 0 15 /a 186 /g 53 15 /a 186 /g 0 16 /a 186 /g 53 16 /a 186 /g 0 17 /a 186 /g 53 17 /a 186 /g 0 18 /a 186 /g 53 18 /a 186 /g 0 19 /a 186 /g 53 19 /a 186 /g 0 20 /a 186 /g 53 20 /a 186 /g 0 21 /a 186 /g 53 21 /a 186 /g 0 22 /a 186 /g 53 22 /a 186 /g 0 23 /a 186 /g 53 23 /a 186 /g 0 24 /a 186 /g 53 24 /a 186 /g 0 25 /a 186 /g 53 25 /a 186 /g 0 26 /a 186 /g 53 26 /a 186 /g 0 27 /a 186 /g 53 27 /a 186 /g 0 28 /a 200 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 188
	exit /b



Rem Characters List Border
	:CharactersListBorder
	!Bb! /g 0 29 /c 0x!MenuBG!!MenuFG! /a 201 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 187 /a 201 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 187 /g 0 30 /a 186 /g 0 31 /a 186 /g 0 32 /a 186 /g 0 33 /a 186 /g 0 34 /a 186 /g 26 30 /a 186 /g 26 31 /a 186 /g 26 32 /a 186 /g 26 33 /a 186 /g 26 34 /a 186 /g 27 30 /a 186 /g 27 31 /a 186 /g 27 32 /a 186 /g 27 33 /a 186 /g 27 34 /a 186 /g 53 30 /a 186 /g 53 31 /a 186 /g 53 32 /a 186 /g 53 33 /a 186 /g 53 34 /a 186 /g 0 35 /a 200 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 188 /a 200 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 188 /d ""
	exit /b



Rem Characters List
	:CharactersList
	!Bb! /g 1 30 /c 0x0a /a 65 /g 3 30 /a 66 /g 5 30 /a 67 /g 7 30 /a 68 /g 9 30 /a 69 /g 11 30 /a 70 /g 13 30 /a 71 /g 15 30 /a 72 /g 17 30 /a 73 /g 19 30 /a 74 /g 21 30 /a 75 /g 23 30 /a 76 /g 25 30 /a 77 /g 1 31 /a 78 /g 3 31 /a 79 /g 5 31 /a 80 /g 7 31 /a 81 /g 9 31 /a 82 /g 11 31 /a 83 /g 13 31 /a 84 /g 15 31 /a 85 /g 17 31 /a 86 /g 19 31 /a 87 /g 21 31 /a 88 /g 23 31 /a 89 /g 25 31 /a 90 /g 1 32 /a 97 /g 3 32 /a 98 /g 5 32 /a 99 /g 7 32 /a 100 /g 9 32 /a 101 /g 11 32 /a 102 /g 13 32 /a 103 /g 15 32 /a 104 /g 17 32 /a 105 /g 19 32 /a 106 /g 21 32 /a 107 /g 23 32 /a 108 /g 25 32 /a 109 /g 1 33 /a 110 /g 3 33 /a 111 /g 5 33 /a 112 /g 7 33 /a 113 /g 9 33 /a 114 /g 11 33 /a 115 /g 13 33 /a 116 /g 15 33 /a 117 /g 17 33 /a 118 /g 19 33 /a 119 /g 21 33 /a 120 /g 23 33 /a 121 /g 25 33 /a 122 /g 1 34 /a 48 /g 3 34 /a 49 /g 5 34 /a 50 /g 7 34 /a 51 /g 9 34 /a 52 /g 11 34 /a 53 /g 13 34 /a 54 /g 15 34 /a 55 /g 17 34 /a 56 /g 19 34 /a 57 /g 28 30 /a 32 /g 30 30 /a 33 /g 32 30 /a 34 /g 34 30 /a 35 /g 36 30 /a 36 /g 38 30 /a 37 /g 40 30 /a 38 /g 42 30 /a 39 /g 44 30 /a 40 /g 46 30 /a 41 /g 48 30 /a 42 /g 50 30 /a 43 /g 52 30 /a 44 /g 28 31 /a 45 /g 30 31 /a 46 /g 32 31 /a 47 /g 34 31 /a 58 /g 36 31 /a 59 /g 38 31 /a 60 /g 40 31 /a 61 /g 42 31 /a 62 /g 44 31 /a 63 /g 46 31 /a 64 /g 48 31 /a 91 /g 50 31 /a 92 /g 52 31 /a 93 /g 28 32 /a 94 /g 30 32 /a 96 /g 32 32 /a 95 /g 34 32 /a 123 /g 36 32 /a 124 /g 38 32 /a 125 /g 40 32 /a 126 /g 42 32 /a 176 /g 44 32 /a 177 /g 46 32 /a 178 /g 48 32 /a 185 /g 50 32 /a 186 /g 52 32 /a 187 /g 28 33 /a 188 /g 30 33 /a 200 /g 32 33 /a 201 /g 34 33 /a 202 /g 36 33 /a 203 /g 38 33 /a 204 /g 40 33 /a 205 /g 42 33 /a 206 /g 44 33 /a 219 /g 46 33 /a 220 /g 48 33 /a 223 /g 50 33 /a 179 /g 52 33 /a 180 /g 28 34 /a 191 /g 30 34 /a 192 /g 32 34 /a 193 /g 34 34 /a 194 /g 36 34 /a 195 /g 38 34 /a 196 /g 40 34 /a 197 /g 42 34 /a 217 /g 44 34 /a 218 /g 46 34 /a 254 /g 48 34 /a 240 /g 50 34 /a 174 /g 52 34 /a 175 /d ""
	exit /b



Rem Color List
	:ColorList
	!Bb! /g 55 30 /c 0x00 /a 32 /g 57 30 /c 0x10 /a 32 /g 59 30 /c 0x20 /a 32 /g 61 30 /c 0x30 /a 32 /g 63 30 /c 0x40 /a 32 /g 65 30 /c 0x50 /a 32 /g 67 30 /c 0x60 /a 32 /g 69 30 /c 0x70 /a 32 /g 55 31 /c 0x80 /a 32 /g 57 31 /c 0x90 /a 32 /g 59 31 /c 0xa0 /a 32 /g 61 31 /c 0xb0 /a 32 /g 63 31 /c 0xc0 /a 32 /g 65 31 /c 0xd0 /a 32 /g 67 31 /c 0xe0 /a 32 /g 69 31 /c 0xf0 /a 32
	!Bb! /g 55 33 /c 0x00 /a 32 /g 57 33 /c 0x10 /a 32 /g 59 33 /c 0x20 /a 32 /g 61 33 /c 0x30 /a 32 /g 63 33 /c 0x40 /a 32 /g 65 33 /c 0x50 /a 32 /g 67 33 /c 0x60 /a 32 /g 69 33 /c 0x70 /a 32 /g 55 34 /c 0x80 /a 32 /g 57 34 /c 0x90 /a 32 /g 59 34 /c 0xa0 /a 32 /g 61 34 /c 0xb0 /a 32 /g 63 34 /c 0xc0 /a 32 /g 65 34 /c 0xd0 /a 32 /g 67 34 /c 0xe0 /a 32 /g 69 34 /c 0xf0 /a 32
	exit /b



Rem Color Menu
	:ColorMenu
	!Bb! /g 54 29 /c 0x!MenuBG!!MenuFG! /a 201 /a 205 /a 205 /a 205 /a 66 /a 71 /a 32 /a 67 /a 111 /a 108 /a 111 /a 117 /a 114 /a 205 /a 205 /a 205 /a 187 /d ""
	!Bb! /c 0x!MenuBG!!MenuFG! /g 54 30 /a 186 /d "" & !Bb! /c 0x!MenuBG!!MenuFG! /g 70 30 /a 186 /d ""
	!Bb! /c 0x!MenuBG!!MenuFG! /g 54 31 /a 186 /d "" & !Bb! /c 0x!MenuBG!!MenuFG! /g 70 31 /a 186 /d ""

	!Bb! /g 54 32 /c 0x!MenuBG!!MenuFG! /a 204 /a 205 /a 205 /a 205 /a 70 /a 71 /a 32 /a 67 /a 111 /a 108 /a 111 /a 117 /a 114 /a 205 /a 205 /a 205 /a 185 /d ""
	!Bb! /c 0x!MenuBG!!MenuFG! /g 54 33 /a 186 /d "" & !Bb! /c 0x!MenuBG!!MenuFG! /g 70 33 /a 186 /d ""
	!Bb! /c 0x!MenuBG!!MenuFG! /g 54 34 /a 186 /d "" & !Bb! /c 0x!MenuBG!!MenuFG! /g 70 34 /a 186 /d ""
	!Bb! /g 54 35 /c 0x!MenuBG!!MenuFG! /a 200 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 188 /d "" 
	exit /b


Rem Give Char
	:GiveChar
	if not !X! lss 1 (
		if not !Y! lss 30 (
			if not !X! gtr 52 (
				if not !Y! gtr 34 (
					Rem The Varriable MainChar Is Being Set To Ascii Values
					If "!X!,!Y!"=="1,30" ( 
						set "MainChar=65"
					)
					If "!X!,!Y!"=="3,30" ( 
						set "MainChar=66"
					)
					If "!X!,!Y!"=="5,30" ( 
						set "MainChar=67"
					)
					If "!X!,!Y!"=="7,30" ( 
						set "MainChar=68"
					)
					If "!X!,!Y!"=="9,30" ( 
						set "MainChar=69"
					)
					If "!X!,!Y!"=="11,30" ( 
						set "MainChar=70"
					)
					If "!X!,!Y!"=="13,30" ( 
						set "MainChar=71"
					)
					If "!X!,!Y!"=="15,30" ( 
						set "MainChar=72"
					)
					If "!X!,!Y!"=="17,30" ( 
						set "MainChar=73"
					)
					If "!X!,!Y!"=="19,30" ( 
						set "MainChar=74"
					)
					If "!X!,!Y!"=="21,30" ( 
						set "MainChar=75"
					)
					If "!X!,!Y!"=="23,30" ( 
						set "MainChar=76"
					)
					If "!X!,!Y!"=="25,30" ( 
						set "MainChar=77"
					)
					If "!X!,!Y!"=="1,31" ( 
						set "MainChar=78"
					)
					If "!X!,!Y!"=="3,31" ( 
						set "MainChar=79"
					)
					If "!X!,!Y!"=="5,31" ( 
						set "MainChar=80"
					)
					If "!X!,!Y!"=="7,31" ( 
						set "MainChar=81"
					)
					If "!X!,!Y!"=="9,31" ( 
						set "MainChar=82"
					)
					If "!X!,!Y!"=="11,31" ( 
						set "MainChar=83"
					)
					If "!X!,!Y!"=="13,31" ( 
						set "MainChar=84"
					)
					If "!X!,!Y!"=="15,31" ( 
						set "MainChar=85"
					)
					If "!X!,!Y!"=="17,31" ( 
						set "MainChar=86"
					)
					If "!X!,!Y!"=="19,31" ( 
						set "MainChar=87"
					)
					If "!X!,!Y!"=="21,31" ( 
						set "MainChar=88"
					)
					If "!X!,!Y!"=="23,31" ( 
						set "MainChar=89"
					)
					If "!X!,!Y!"=="25,31" ( 
						set "MainChar=90"
					)
					If "!X!,!Y!"=="1,32" ( 
						set "MainChar=97"
					)
					If "!X!,!Y!"=="3,32" ( 
						set "MainChar=98"
					)
					If "!X!,!Y!"=="5,32" ( 
						set "MainChar=99"
					)
					If "!X!,!Y!"=="7,32" ( 
						set "MainChar=100"
					)
					If "!X!,!Y!"=="9,32" ( 
						set "MainChar=101"
					)
					If "!X!,!Y!"=="11,32" ( 
						set "MainChar=102"
					)
					If "!X!,!Y!"=="13,32" ( 
						set "MainChar=103"
					)
					If "!X!,!Y!"=="15,32" ( 
						set "MainChar=104"
					)
					If "!X!,!Y!"=="17,32" ( 
						set "MainChar=105"
					)
					If "!X!,!Y!"=="19,32" ( 
						set "MainChar=106"
					)
					If "!X!,!Y!"=="21,32" ( 
						set "MainChar=107"
					)
					If "!X!,!Y!"=="23,32" ( 
						set "MainChar=108"
					)
					If "!X!,!Y!"=="25,32" ( 
						set "MainChar=109"
					)
					If "!X!,!Y!"=="1,33" ( 
						set "MainChar=110"
					)
					If "!X!,!Y!"=="3,33" ( 
						set "MainChar=111"
					)
					If "!X!,!Y!"=="5,33" ( 
						set "MainChar=112"
					)
					If "!X!,!Y!"=="7,33" ( 
						set "MainChar=113"
					)
					If "!X!,!Y!"=="9,33" ( 
						set "MainChar=114"
					)
					If "!X!,!Y!"=="11,33" ( 
						set "MainChar=115"
					)
					If "!X!,!Y!"=="13,33" ( 
						set "MainChar=116"
					)
					If "!X!,!Y!"=="15,33" ( 
						set "MainChar=117"
					)
					If "!X!,!Y!"=="17,33" ( 
						set "MainChar=118"
					)
					If "!X!,!Y!"=="19,33" ( 
						set "MainChar=119"
					)
					If "!X!,!Y!"=="21,33" ( 
						set "MainChar=120"
					)
					If "!X!,!Y!"=="23,33" ( 
						set "MainChar=121"
					)
					If "!X!,!Y!"=="25,33" ( 
						set "MainChar=122"
					)
					If "!X!,!Y!"=="1,34" ( 
						set "MainChar=48"
					)
					If "!X!,!Y!"=="3,34" ( 
						set "MainChar=49"
					)
					If "!X!,!Y!"=="5,34" ( 
						set "MainChar=50"
					)
					If "!X!,!Y!"=="7,34" ( 
						set "MainChar=51"
					)
					If "!X!,!Y!"=="9,34" ( 
						set "MainChar=52"
					)
					If "!X!,!Y!"=="11,34" ( 
						set "MainChar=53"
					)
					If "!X!,!Y!"=="13,34" ( 
						set "MainChar=54"
					)
					If "!X!,!Y!"=="15,34" ( 
						set "MainChar=55"
					)
					If "!X!,!Y!"=="17,34" ( 
						set "MainChar=56"
					)
					If "!X!,!Y!"=="19,34" ( 
						set "MainChar=57"
					)
					If "!X!,!Y!"=="28,30" ( 
						set "MainChar=32"
					)
					If "!X!,!Y!"=="30,30" ( 
						set "MainChar=33"
					)
					If "!X!,!Y!"=="32,30" ( 
						set "MainChar=34"
					)
					If "!X!,!Y!"=="34,30" ( 
						set "MainChar=35"
					)
					If "!X!,!Y!"=="36,30" ( 
						set "MainChar=36"
					)
					If "!X!,!Y!"=="38,30" ( 
						set "MainChar=37"
					)
					If "!X!,!Y!"=="40,30" ( 
						set "MainChar=38"
					)
					If "!X!,!Y!"=="42,30" ( 
						set "MainChar=39"
					)
					If "!X!,!Y!"=="44,30" ( 
						set "MainChar=40"
					)
					If "!X!,!Y!"=="46,30" ( 
						set "MainChar=41"
					)
					If "!X!,!Y!"=="48,30" ( 
						set "MainChar=42"
					)
					If "!X!,!Y!"=="50,30" ( 
						set "MainChar=43"
					)
					If "!X!,!Y!"=="52,30" ( 
						set "MainChar=44"
					)
					If "!X!,!Y!"=="28,31" ( 
						set "MainChar=45"
					)
					If "!X!,!Y!"=="30,31" ( 
						set "MainChar=46"
					)
					If "!X!,!Y!"=="32,31" ( 
						set "MainChar=47"
					)
					If "!X!,!Y!"=="34,31" ( 
						set "MainChar=58"
					)
					If "!X!,!Y!"=="36,31" ( 
						set "MainChar=59"
					)
					If "!X!,!Y!"=="38,31" ( 
						set "MainChar=60"
					)
					If "!X!,!Y!"=="40,31" ( 
						set "MainChar=61"
					)
					If "!X!,!Y!"=="42,31" ( 
						set "MainChar=62"
					)
					If "!X!,!Y!"=="44,31" ( 
						set "MainChar=63"
					)
					If "!X!,!Y!"=="46,31" ( 
						set "MainChar=64"
					)
					If "!X!,!Y!"=="48,31" ( 
						set "MainChar=91"
					)
					If "!X!,!Y!"=="50,31" ( 
						set "MainChar=92"
					)
					If "!X!,!Y!"=="52,31" ( 
						set "MainChar=93"
					)
					If "!X!,!Y!"=="28,32" ( 
						set "MainChar=94"
					)
					If "!X!,!Y!"=="30,32" ( 
						set "MainChar=96"
					)
					If "!X!,!Y!"=="32,32" ( 
						set "MainChar=95"
					)
					If "!X!,!Y!"=="34,32" ( 
						set "MainChar=123"
					)
					If "!X!,!Y!"=="36,32" ( 
						set "MainChar=124"
					)
					If "!X!,!Y!"=="38,32" ( 
						set "MainChar=125"
					)
					If "!X!,!Y!"=="40,32" ( 
						set "MainChar=126"
					)
					If "!X!,!Y!"=="42,32" ( 
						set "MainChar=176"
					)
					If "!X!,!Y!"=="44,32" ( 
						set "MainChar=177"
					)
					If "!X!,!Y!"=="46,32" ( 
						set "MainChar=178"
					)
					If "!X!,!Y!"=="48,32" ( 
						set "MainChar=185"
					)
					If "!X!,!Y!"=="50,32" ( 
						set "MainChar=186"
					)
					If "!X!,!Y!"=="52,32" ( 
						set "MainChar=187"
					)
					If "!X!,!Y!"=="28,33" ( 
						set "MainChar=188"
					)
					If "!X!,!Y!"=="30,33" ( 
						set "MainChar=200"
					)
					If "!X!,!Y!"=="32,33" ( 
						set "MainChar=201"
					)
					If "!X!,!Y!"=="34,33" ( 
						set "MainChar=202"
					)
					If "!X!,!Y!"=="36,33" ( 
						set "MainChar=203"
					)
					If "!X!,!Y!"=="38,33" ( 
						set "MainChar=204"
					)
					If "!X!,!Y!"=="40,33" ( 
						set "MainChar=205"
					)
					If "!X!,!Y!"=="42,33" ( 
						set "MainChar=206"
					)
					If "!X!,!Y!"=="44,33" ( 
						set "MainChar=219"
					)
					If "!X!,!Y!"=="46,33" ( 
						set "MainChar=220"
					)
					If "!X!,!Y!"=="48,33" ( 
						set "MainChar=223"
					)
					If "!X!,!Y!"=="50,33" ( 
						set "MainChar=179"
					)
					If "!X!,!Y!"=="52,33" ( 
						set "MainChar=180"
					)
					If "!X!,!Y!"=="28,34" ( 
						set "MainChar=191"
					)
					If "!X!,!Y!"=="30,34" ( 
						set "MainChar=192"
					)
					If "!X!,!Y!"=="32,34" ( 
						set "MainChar=193"
					)
					If "!X!,!Y!"=="34,34" ( 
						set "MainChar=194"
					)
					If "!X!,!Y!"=="36,34" ( 
						set "MainChar=195"
					)
					If "!X!,!Y!"=="38,34" ( 
						set "MainChar=196"
					)
					If "!X!,!Y!"=="40,34" ( 
						set "MainChar=197"
					)
					If "!X!,!Y!"=="42,34" ( 
						set "MainChar=217"
					)
					If "!X!,!Y!"=="44,34" ( 
						set "MainChar=218"
					)
					If "!X!,!Y!"=="46,34" ( 
						set "MainChar=254"
					)
					If "!X!,!Y!"=="48,34" ( 
						set "MainChar=240"
					)
					If "!X!,!Y!"=="50,34" ( 
						set "MainChar=174"
					)
					If "!X!,!Y!"=="52,34" ( 
						set "MainChar=175"
					)
				) else (exit /b)
			) else (exit /b)
		) else (exit /b)
	) else (exit /b)


Rem Give Color
	:GiveColor
	if not !X! lss 55 (
		if not !Y! lss 30 (
			if not !X! gtr 69 (
				if not !Y! gtr 34 (

					Rem Color Background

					If "!X!,!Y!"=="55,30" ( 
						set "ColorBG=0"
					)
					If "!X!,!Y!"=="57,30" ( 
						set "ColorBG=1"
					) 
					If "!X!,!Y!"=="59,30" ( 
						set "ColorBG=2"
					) 
					If "!X!,!Y!"=="61,30" (
						set "ColorBG=3"
					) 
					If "!X!,!Y!"=="63,30" (
						set "ColorBG=4"
					) 
					If "!X!,!Y!"=="65,30" (
						set "ColorBG=5"
					) 
					If "!X!,!Y!"=="67,30" (
						set "ColorBG=6"
					) 
					If "!X!,!Y!"=="69,30" ( 
						set "ColorBG=7"
					) 
					If "!X!,!Y!"=="55,31" (
						set "ColorBG=8"
					) 
					If "!X!,!Y!"=="57,31" (
						set "ColorBG=9"
					) 
					If "!X!,!Y!"=="59,31" (
						set "ColorBG=a"
					) 
					If "!X!,!Y!"=="61,31" ( 
						set "ColorBG=b"
					) 
					If "!X!,!Y!"=="63,31" ( 
						set "ColorBG=c"
					) 
					If "!X!,!Y!"=="65,31" ( 
						set "ColorBG=d"
					) 
					If "!X!,!Y!"=="67,31" ( 
						set "ColorBG=e"
					) 
					If "!X!,!Y!"=="69,31" ( 
						set "ColorBG=f"
					)

					Rem Color Foreground

					If "!X!,!Y!"=="55,33" ( 
						set "ColorFG=0"
					)
					If "!X!,!Y!"=="57,33" ( 
						set "ColorFG=1"
					) 
					If "!X!,!Y!"=="59,33" ( 
						set "ColorFG=2"
					) 
					If "!X!,!Y!"=="61,33" (
						set "ColorFG=3"
					) 
					If "!X!,!Y!"=="63,33" (
						set "ColorFG=4"
					) 
					If "!X!,!Y!"=="65,33" (
						set "ColorFG=5"
					) 
					If "!X!,!Y!"=="67,33" (
						set "ColorFG=6"
					) 
					If "!X!,!Y!"=="69,33" ( 
						set "ColorFG=7"
					) 
					If "!X!,!Y!"=="55,34" (
						set "ColorFG=8"
					) 
					If "!X!,!Y!"=="57,34" (
						set "ColorFG=9"
					) 
					If "!X!,!Y!"=="59,34" (
						set "ColorFG=a"
					) 
					If "!X!,!Y!"=="61,34" ( 
						set "ColorFG=b"
					) 
					If "!X!,!Y!"=="63,34" ( 
						set "ColorFG=c"
					) 
					If "!X!,!Y!"=="65,34" ( 
						set "ColorFG=d"
					) 
					If "!X!,!Y!"=="67,34" ( 
						set "ColorFG=e"
					) 
					If "!X!,!Y!"=="69,34" ( 
						set "ColorFG=f"
					)
				)
			)
		)
	) else (exit /b)

Rem On Click
	:OnClick
	if not !Y! lss 2 (
		if not !X! lss 1 (
			if not !Y! gtr 27 (
				if not !X! gtr 52 (
					if "!test_var!"=="1" (
						start /b !Bb! /g !X! !Y! /c 0x!ColorBG!!ColorFG! /a !MainChar!
						exit /b
					)
					if "!test_var!"=="2" (
						set /a top_left_x=!X!-1
						set /a top_left_y=!Y!-1
						set /a top_middle_y=!Y!-1
						set /a top_right_x=!X!+1
						set /a top_right_y=!Y!-1
						set /a middle_left_x=!X!-1
						set /a middle_right_x=!X!+1
						set /a bottom_left_x=!X!-1
						set /a bottom_left_y=!Y!+1
						set /a bottom_middle_y=!Y!+1
						set /a bottom_right_x=!X!+1
						set /a bottom_right_y=!Y!+1
						start /b !Bb! /c 0x!ColorBG!!ColorFG! /g !top_left_x! !top_left_y! /a !MainChar! /g !X! !top_middle_y! /a !MainChar! /g !top_right_x! !top_right_y! /a !MainChar! /g !middle_left_x! !Y! /a !MainChar! /g !X! !Y! /a !MainChar! /g !middle_right_x! !Y! /a !MainChar! /g !bottom_left_x! !bottom_left_y! /a !MainChar! /g !X! !bottom_middle_y! /a !MainChar! /g !bottom_right_x! !bottom_right_y! /a !MainChar!
					)
				)
			)
		)
	) else (exit /b)

