@echo off
setlocal enabledelayedexpansion
Mode 72,36
color 00
cls

If not exist "Saves\" ( md "Saves\" )

set "Mb=Core\MakeBox.bat"
set "Cw=Core\CmdWiz.exe"
!Cw! showcursor 0
set "Bb=Core\batbox.exe"
set "Gt=Core\gotoxy.exe"
set "Li=Core\line.exe"
set "Fn=Core\Fn.dll"
set "Chars.if=Core\Chars.if"
set "ColorsFG.if=Core\ColorsFG.if"
set "ColorsBG.if=Core\ColorsBG.if"
set "Current_Brush=2"
set "MenuBG=0"
set "MenuFG=a"
set "ColorFG=8"
set "ColorBG=0"
set "MainChar=88"

call :Drop_Down_Function_List
call :Characters_List_Border
call :Characters_List
call :Display_Border
call :Color_Menu
call :Color_List
call :Brush_Menu
call :Tool_Menu

:MainPaintLoop
	for /f "tokens=1-3 delims= " %%a in ('start /b !Fn! mouse') do (
		set "X=%%b"
		set "Y=%%a"


		Rem Fun code below :)
		Rem set /a "Current_Brush=(%random%%%4)+1"
		Rem set /a "MainChar=(%random%%%255)+1"
		Rem set /a "ColorFG=(%random%%%9)+1"
		Rem set /a "ColorBG=(%random%%%9)+1"

		call :Paint_Brush_!Current_Brush!
		if not "!errorlevel!"=="1" (
			call :Give_Character
			call :Drop_Down_Functions
			call :Give_Color
		)
		title X:!X! Y:!Y!
	)
goto MainPaintLoop


Rem Functions Below

Rem title Click a Pixel To Delete It
Rem for /f "tokens=1-3 delims= " %%a in ('start /b !Fn! mouse') do (
Rem 	set "X=%%b"
Rem 	set "Y=%%a"
Rem )
Rem !Bb! /g !X! !Y! /c 0x00 /a 32

Rem Brushes Menu Functions
	:Brushes_Menu_Functions
	if not !Current_Brush! equ 4 (
		if not !X! lss 55 (
			if not !Y! lss 16 (
				if not !X! gtr 64 (
					if not !Y! gtr 16 (
						set "Current_Brush=4"
						exit /b
					)
				)
			)
		)
	)

Rem Brush Menu
	:Brush_Menu
	!Bb! /g 54 15 /c 0x!MenuBG!!MenuFG! /a 201 /a 205 /a 205 /a 205 /a 205 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 205 /a 205 /a 205 /a 205 /a 187
	!Bb! /g 54 16 /c 0x!MenuBG!!MenuFG! /a 186 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 186
	!Bb! /g 54 17 /c 0x!MenuBG!!MenuFG! /a 186 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 186
	!Bb! /g 54 18 /c 0x!MenuBG!!MenuFG! /a 186 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 186
	!Bb! /g 54 19 /c 0x!MenuBG!!MenuFG! /a 186 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 186
	!Bb! /g 54 20 /c 0x!MenuBG!!MenuFG! /a 200 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 188
	
	!Bb! /g 59 15 /c 0x!MenuBG!!MenuFG! /d "Brushes"
	!Bb! /g 55 16 /c 0x!MenuBG!!MenuFG! /d "Tall Brush----"
	!Bb! /g 55 17 /c 0x!MenuBG!!MenuFG! /d "Wide Brush----"
	!Bb! /g 55 18 /c 0x!MenuBG!!MenuFG! /d "3x3 Brush-----"
	!Bb! /g 55 19 /c 0x!MenuBG!!MenuFG! /d "1x1 Brush-----"
	exit /b

Rem Tool Menu
	:Tool_Menu
	!Bb! /g 54 21 /c 0x!MenuBG!!MenuFG! /a 201 /a 205 /a 205 /a 205 /a 205 /a 205 /a 32 /a 32 /a 32 /a 32 /a 32 /a 205 /a 205 /a 205 /a 205 /a 205 /a 187
	!Bb! /g 54 22 /c 0x!MenuBG!!MenuFG! /a 186 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 186
	!Bb! /g 54 23 /c 0x!MenuBG!!MenuFG! /a 186 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 186
	!Bb! /g 54 24 /c 0x!MenuBG!!MenuFG! /a 186 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 186
	!Bb! /g 54 25 /c 0x!MenuBG!!MenuFG! /a 186 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 186
	!Bb! /g 54 26 /c 0x!MenuBG!!MenuFG! /a 186 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 186
	!Bb! /g 54 27 /c 0x!MenuBG!!MenuFG! /a 186 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 186
	!Bb! /g 54 28 /c 0x!MenuBG!!MenuFG! /a 200 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 188

	!Bb! /g 60 21 /c 0x!MenuBG!!MenuFG! /d "Tools"
	!Bb! /g 55 22 /c 0x!MenuBG!!MenuFG! /d "Eraser Tool---"
	!Bb! /g 55 23 /c 0x!MenuBG!!MenuFG! /d "Eye Droper----"
	!Bb! /g 55 24 /c 0x!MenuBG!!MenuFG! /d "Copy Tool-----"
	!Bb! /g 55 25 /c 0x!MenuBG!!MenuFG! /d "Text Tool-----"
	!Bb! /g 55 26 /c 0x!MenuBG!!MenuFG! /d "Line Tool-----"
	!Bb! /g 55 27 /c 0x!MenuBG!!MenuFG! /d "Box Tool------"
	exit /b

Rem Blank Menu 1
	:Blank_Menu_1
	!Bb! /g 15 12 /c 0x8f /a 32 /c 0x1f /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /c 0x8f /a 32
	!Bb! /g 15 13 /c 0x8f /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32
	!Bb! /g 15 14 /c 0x8f /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32
	!Bb! /g 15 15 /c 0x8f /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32
	!Bb! /g 15 16 /c 0x8f /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32
	!Bb! /g 15 17 /c 0x8f /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32
	if not "%~1"=="" !Bb! /g 17 12 /c 0x1f /d "%~1"
	if not "%~2"=="" !Bb! /g 16 13 /c 0x8f /d "%~2"
	if not "%~3"=="" !Bb! /g 16 14 /c 0x8f /d "%~3"
	if not "%~4"=="" !Bb! /g 16 15 /c 0x8f /d "%~4"
	if not "%~5"=="" !Bb! /g 16 16 /c 0x8f /d "%~5"
	if not "%~6"=="" !Bb! /g 16 17 /c 0x8f /d "%~6"

	exit /b

Rem Drop Down Functions
	:Drop_Down_Functions
	if not !X! lss 0 (
		if not !Y! lss 0 (
			if not !X! gtr 53 (
				if not !Y! gtr 0 (
					Rem File Drop Down Function
					if not !X! lss 4 (
						if not !X! gtr 7 (
							!Bb! /g 54 10 /c 0x!COlorBG!!ColorFG! /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 
							!Bb! /g 54 10 /c 0x!ColorBG!!ColorFG! /d "File Drop Down"
							!Cw! saveblock Data\File\Use-If-Save 1 2 52 27 forcecode
							!Bb! /g 0 0 /c 0x!MenuBG!!MenuFG! /a 186 /a 32 /a 32 /a 32 /d "File" /a 32 /a 32 /a 32 /c 0x!MenuBG!!MenuFG! /a 186
							!Bb! /g 0 1 /c 0x!MenuBG!!MenuFG! /a 186 /c 0x8f /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /c 0x8c /d "X" /c 0x8f /a 32 /c 0x!MenuBG!!MenuFG! /a 186
							!Bb! /g 0 2 /c 0x!MenuBG!!MenuFG! /a 186 /c 0x8f /a 32 /d "New" /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /c 0x!MenuBG!!MenuFG! /a 186
							!Bb! /g 0 3 /c 0x!MenuBG!!MenuFG! /a 186 /c 0x8f /a 32 /d "Save" /a 32 /a 32 /a 32 /a 32 /a 32 /c 0x!MenuBG!!MenuFG! /a 186
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
												call :Drop_Down_Function_List
												call :Characters_List_Border
												call :Display_Border
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
												call :Display_Border
												call :Drop_Down_Function_List
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
												call :Blank_Menu_1
												!Bb! /g 16 12 /c 0x1f /d "Save"
												!Bb! /g 16 14 /c 0x8f /d "Would You Like To Save?"
												!Bb! /g 16 16 /c 0x8f /d "(Y/N):"
												set /p "TempInput1= "

												if "!TempInput1!"=="y" (
													call :Blank_Menu_1
													!Bb! /g 16 12 /c 0x1f /d "Save"
													!Bb! /g 16 14 /c 0x8f /d "Please Enter a Name"
													!Bb! /g 16 16 /c 0x8f /d "Name:"
													set /p "TempInput2= "

													if exist "Saves\!TempInput2!.gxy" (
														:DropDownSaveOverrideLoop
														call :Blank_Menu_1
														!Bb! /g 16 12 /c 0x1f /d "Save"
														!Bb! /g 16 14 /c 0x8f /d "Override Existing Save?"
														!Bb! /g 16 16 /c 0x8f /d "(Y/N):"
														set /p "TempInput3= "

														if "!TempInput3!"=="y" (
															type "Data\File\Use-If-Save.gxy">"Saves\!TempInput2!.gxy"
															!Gt! 1 2 "Data\File\Use-If-Save.gxy"
															call :Drop_Down_Function_List
															call :Display_Border
															set "TempInput1="
															set "TempInput2="
															set "TempInput3="
															exit /b
														) else (
															if "!TempInput3!"=="n" (
																!Gt! 1 2 "Data\File\Use-If-Save.gxy"
																call :Drop_Down_Function_List
																call :Display_Border
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
														call :Drop_Down_Function_List
														call :Display_Border
														set "TempInput1="
														set "TempInput2="
														set "TempInput3="
														exit /b
													)
												) else (
													if "!TempInput1!"=="n" (
														call :Drop_Down_Function_List
														call :Display_Border
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
												call :Blank_Menu_1
												!Bb! /g 16 12 /c 0x1f /d "Open"
												!Bb! /g 16 14 /c 0x8f /d "Want To Load a Save?"
												!Bb! /g 16 16 /c 0x8f /d "(Y/N):"
												set /p "TempInput1= "
												if "!TempInput1!"=="y" (
													call :Blank_Menu_1
													!Bb! /g 16 12 /c 0x1f /d "Open"
													!Bb! /g 16 14 /c 0x8f /d "Enter Save Name"
													!Bb! /g 16 16 /c 0x8f /d "Name:"
													set /p "TempInput2= "

													if exist "Saves\!TempInput2!.gxy" (
														call :Display_Border
														call :Drop_Down_Function_List

														!Gt! 1 2 "Saves\!TempInput2!.gxy"
														exit /b
													) else (
														call :Blank_Menu_1
														!Bb! /g 16 12 /c 0x1f /d "Open"
														!Bb! /g 16 14 /c 0x8f /d "Save Does Not Exist"
														!Cw! delay 800
														call :Display_Border
														call :Drop_Down_Function_List
														!Gt! 1 2 "Data\File\Use-If-Save.gxy"
														exit /b
													)
												) else (
													if "!TempInput1!"=="n" (
														!Gt! 1 2 "Data\File\Use-If-Save.gxy"
														call :Display_Border
														call :Drop_Down_Function_List
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
												call :Blank_Menu_1
												!Bb! /g 16 12 /c 0x1f /d "Rename"
												!Bb! /g 16 14 /c 0x8f /d "Want To Rename a Save?"
												!Bb! /g 16 16 /c 0x8f /d "(Y/N):"
												set /p "TempInput1= "
												if "!TempInput1!"=="y" (
													:DropDownRenameLoop2
													call :Blank_Menu_1
													!Bb! /g 16 12 /c 0x1f /d "Rename"
													!Bb! /g 16 14 /c 0x8f /d "Save You Want To Rename"
													!Bb! /g 16 16 /c 0x8f /d "Name:"
													set /p "TempInput2= "
													if exist "Saves\!TempInput2!.gxy" (
														call :Blank_Menu_1
														!Bb! /g 16 12 /c 0x1f /d "Rename"
														!Bb! /g 16 14 /c 0x8f /d "New Name For Save"
														!Bb! /g 16 16 /c 0x8f /d "Name:"
														set /p "TempInput3= "
														if not exist "Saves\!TempInput3!.gxy" (
															:DropDownRenameLoop4
															call :Blank_Menu_1
															!Bb! /g 16 12 /c 0x1f /d "Rename"
															!Bb! /g 16 14 /c 0x8f /d "Are You Sure?"
															!Bb! /g 16 16 /c 0x8f /d "(Y/N):"
															set /p "TempInput4= "
															if "!TempInput4!"=="y" (
																cd Saves
																Rename "!TempInput2!.gxy" "!TempInput3!.gxy"
																cd..
																call :Display_Border
																call :Drop_Down_Function_List
																!Gt! 1 2 "Data\File\Use-If-Save.gxy"
																exit /b
															) else (
																if "!TempInput4!"=="n" (
																	call :Display_Border
																	call :Drop_Down_Function_List
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
														call :Display_Border
														call :Drop_Down_Function_List
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
										if not !X! gtr 7 (
											if not !Y! gtr 6 (
												:DropDownImportLoop1
												call :Blank_Menu_1
												!Bb! /g 16 12 /c 0x1f /d "Import"
												!Bb! /g 16 14 /c 0x8f /d "Want To Import a Sprite?"
												!Bb! /g 16 16 /c 0x8f /d "(Y/N):"
												
												set /p "TempInput1= "
												if "!TempInput1!"=="y" (
													call :Blank_Menu_1
													!Bb! /g 16 12 /c 0x1f /d "Import"
													!Bb! /g 16 14 /c 0x8f /d "Name Of Sprite To Import"
													!Bb! /g 16 16 /c 0x8f /d "Name:"

													set /p "TempInput2= "
													if exist "Library\Sprites\!TempInput2!.gxy" (
														:DropDownImportLoop2
														call :Blank_Menu_1
														!Bb! /g 16 12 /c 0x1f /d "Import"
														!Bb! /g 16 14 /c 0x8f /d "Are You Sure?"
														!Bb! /g 16 16 /c 0x8f /d "(Y/N):"

														set /p "TempInput3= "
														if "!TempInput3!"=="y" (
															:DropDownImportLoop3
															!Gt! 1 2 "Data\File\Use-If-Save.gxy"
															call :Drop_Down_Function_List
															call :Characters_List_Border
															call :Characters_List
															call :Display_Border
															call :Color_Menu
															call :Color_List
															for /f "tokens=1-3 delims= " %%a in ('start /b !Fn! mouse') do (
																set "X=%%b"
																set "Y=%%a"
																!Gt! 1 2 "Data\File\Use-If-Save.gxy"
																!Gt! !X! !Y! "Library\Sprites\!TempInput2!.gxy"
																call :Drop_Down_Function_List
																call :Characters_List_Border
																call :Characters_List
																call :Display_Border
																call :Color_Menu
																call :Color_List
																call :Blank_Menu_1
																!Bb! /g 16 12 /c 0x1f /d "Import"
																!Bb! /g 16 14 /c 0x8f /d "Place Sprite Here?"
																!Bb! /g 16 16 /c 0x8f /d "(Y/N):"

																set /p "TempInput4="
																if "!TempInput4!"=="y" (
																	!Gt! 1 2 "Data\File\Use-If-Save.gxy"
																	!Gt! !X! !Y! "Library\Sprites\!TempInput2!.gxy"
																	call :Drop_Down_Function_List
																	call :Characters_List_Border
																	call :Characters_List
																	call :Display_Border
																	call :Color_Menu
																	call :Color_List
																	exit /b
																) else (
																	if "!TempInput4!"=="n" (
																		call :DropDownImportLoop3
																		exit /b
																	)
																	call :DropDownImportLoop3
																	exit /b
																)
															)
														) else (
															if "!TempInput3!"=="n" (
															call :Drop_Down_Function_List
															call :Display_Border
															!Gt! 1 2 "Data\File\Use-If-Save.gxy"
															exit /b
															)
															call :DropDownImportLoop2
															exit /b
														)
													) else (
														call :Blank_Menu_1
														!Bb! /g 16 12 /c 0x1f /d "Import"
														!Bb! /g 16 14 /c 0x8f /d "Sprite Does Not Exist"
														!Cw! delay 800
														!Gt! 1 2 "Data\File\Use-If-Save.gxy"
														call :Drop_Down_Function_List
														call :Display_Border
														exit /b
													)
												) else (
													if "!TempInput1!"=="n" (
														!Gt! 1 2 "Data\File\Use-If-Save.gxy"
														call :Drop_Down_Function_List
														call :Display_Border
														exit /b
													)
													call :DropDownImportLoop1
													exit /b
												)

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
									!Bb! /g 54 10 /c 0x!COlorBG!!ColorFG! /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 
									!Bb! /g 54 10 /c 0x!ColorBG!!ColorFG! /d "Settings Drop Down"
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
									!Bb! /g 54 10 /c 0x!COlorBG!!ColorFG! /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 
									!Bb! /g 54 10 /c 0x!ColorBG!!ColorFG! /d "Library Drop Down"
									exit /b
								)
							)
						)
					)
					Rem Export Drop Down Function
					if not !X! lss 44 (
						if not !Y! lss 0 (
							if not !X! gtr 49 (
								if not !Y! gtr 0 (
									!Bb! /g 54 10 /c 0x!COlorBG!!ColorFG! /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 
									!Bb! /g 54 10 /c 0x!ColorBG!!ColorFG! /d "Export Drop Down"
									!Cw! saveblock "Data\Export\Use-If-Export" 1 2 52 27 forcecode
									:DropDownExportLoop1
									call :Blank_Menu_1 "Export" "" "Want To Create a Sprite?" "" "(Y/N):"

									set /p "TempInput1= "
									if "!TempInput1!"=="y" (
										call :Blank_Menu_1 "Export" "" "Select The Top-Left And" "The Bottom-Right Corner" "Of What To Be a Sprite"
										title Select The Top-Left And The Bottom-Right Corner Of What To Be a Sprite
										!Cw! delay 3700
										call :Display_Border
										call :Drop_Down_Function_List
										!Gt! 1 2 "Data\Export\Use-If-Export.gxy"
										:DropDownExportLoop2
										call :Display_Border
										call :Drop_Down_Function_List
										!Gt! 1 2 "Data\Export\Use-If-Export.gxy"
										for /f "tokens=1-3 delims= " %%a in ('start /b !Fn! mouse') do (
											set "Point_1_X=%%b"
											set "Point_1_Y=%%a"
										)

										start /b !Bb! /c 0x0f /g !Point_1_X! !Point_1_Y! /a 201 /c 0x00
										for /f "tokens=1-3 delims= " %%a in ('start /b !Fn! mouse') do (
											set "Point_2_X=%%b"
											set "Point_2_Y=%%a"
										)

										
										if not !Point_2_X! gtr !Point_1_X! (
											if not !Point_2_Y! gtr !Point_1_Y! (
												call :DropDownExportLoop2
												exit /b
											)
										)

										if !Point_2_X! gtr !Point_1_X! (
											if !Point_2_Y! gtr !Point_1_Y! (
												set /a "Num1=!Point_2_X!-!Point_1_X!"
												set /a "Num2=!Point_2_Y!-!Point_1_Y!"
												set /a "Num1=!Num1!+1"
												set /a "Num2=!Num2!+1"
												

												set /a "Inside_Call_Mb_1=!Point_1_X!+1"
												set /a "Inside_Call_Mb_2=!Point_1_Y!+1"
												set /a "Inside_Call_Mb_3=!Num1!-2"
												set /a "Inside_Call_Mb_4=!Num2!-2"
												!Cw! saveblock "Data\Export\Use-If-Export_2" !Inside_Call_Mb_1! !Inside_Call_Mb_2! !Inside_Call_Mb_3! !Inside_Call_Mb_4! forcecode
												call !Mb! !Point_1_X! !Point_1_Y! !Num2! !Num1! - - 0f 2
												!Gt! !Inside_Call_Mb_1! !Inside_Call_Mb_2! "Data\Export\Use-If-Export_2.gxy"
												:DropDownExportLoop3
												call :Blank_Menu_1 "Export" "" "Create This Sprite?" "" "(Y/N):"

												set /p "TempInput2= "
												if "!TempInput2!"=="y" (

													:DropDownExportLoop4
													call :Blank_Menu_1 "Export" "" "Name The Sprite" "" "Name:"
													set /p "TempInput3= "
													if not exist "Library\Sprites\!TempInput3!.gxy" (
														!Gt! 1 2 "Data\Export\Use-If-Export.gxy"
														call :Display_Border
														call :Drop_Down_Function_List
														!Cw! saveblock "Library\Sprites\!TempInput3!" !Inside_Call_Mb_1! !Inside_Call_Mb_2! !Inside_Call_Mb_3! !Inside_Call_Mb_4! forcecode
														exit /b
													) else (
														:DropDownExportLoop5
														call :Blank_Menu_1 "Export" "" "Override Existing Sprite?" "" "(Y/N):"
														set /p "TempInput4= "
														if "!TempInput4!"=="y" (
															call :Display_Border
															call :Drop_Down_Function_List
															!Gt! 1 2 Data\File\Use-If-Save.gxy
															!Cw! saveblock "Library\Sprites\!TempInput3!" !Inside_Call_Mb_1! !Inside_Call_Mb_2! !Inside_Call_Mb_3! !Inside_Call_Mb_4! forcecode
															exit /b
														) else (
															if "!TempInput4!"=="n" (
																call :Display_Border
																call :Drop_Down_Function_List
																!Gt! 1 2 "Data\Export\Use-If-Export.gxy"
																exit /b
															)
															call :DropDownExportLoop5
															exit /b
														)
													)
												) else (
													if "!TempInput2!"=="n" (
														call :Display_Border
														call :Drop_Down_Function_List
														!Gt! 1 2 "Data\Export\Use-If-Export.gxy"
														exit /b
													)
													call :DropDownExportLoop3
													exit /b
												)
											)
										)
										call DropDownExportLoop2
										exit /b

									) else (
										if "!TempInput1!"=="n" (
											call :Display_Border
											call :Drop_Down_Function_List
											!Gt! 1 2 "Data\Export\Use-If-Export.gxy"
											exit /b
										)
										call :DropDownExportLoop1
										exit /b
									)

								)
							)
						)
					)
				) else (exit /b)
			) else (exit /b)
		) else (exit /b)
	) else (exit /b)
Rem Drop Down Function List
	:Drop_Down_Function_List
	!Bb! /g 0 0 /c 0x!MenuBG!!MenuFG! /a 186 /d "   File   " /a 186 /d "   Settings   " /a 186 /d "   Library   " /a 186 /d "   Export   " /a 186
	exit /b
Rem Display Border
	:Display_Border
	!Bb! /g 0 1 /c 0x!MenuBG!!MenuFG! /a 204 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 202 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 202 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 202 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 185 /g 0 2 /a 186 /g 53 2 /a 186 /g 0 3 /a 186 /g 53 3 /a 186 /g 0 4 /a 186 /g 53 4 /a 186 /g 0 5 /a 186 /g 53 5 /a 186 /g 0 6 /a 186 /g 53 6 /a 186 /g 0 7 /a 186 /g 53 7 /a 186 /g 0 8 /a 186 /g 53 8 /a 186 /g 0 9 /a 186 /g 53 9 /a 186 /g 0 10 /a 186 /g 53 10 /a 186 /g 0 11 /a 186 /g 53 11 /a 186 /g 0 12 /a 186 /g 53 12 /a 186 /g 0 13 /a 186 /g 53 13 /a 186 /g 0 14 /a 186 /g 53 14 /a 186 /g 0 15 /a 186 /g 53 15 /a 186 /g 0 16 /a 186 /g 53 16 /a 186 /g 0 17 /a 186 /g 53 17 /a 186 /g 0 18 /a 186 /g 53 18 /a 186 /g 0 19 /a 186 /g 53 19 /a 186 /g 0 20 /a 186 /g 53 20 /a 186 /g 0 21 /a 186 /g 53 21 /a 186 /g 0 22 /a 186 /g 53 22 /a 186 /g 0 23 /a 186 /g 53 23 /a 186 /g 0 24 /a 186 /g 53 24 /a 186 /g 0 25 /a 186 /g 53 25 /a 186 /g 0 26 /a 186 /g 53 26 /a 186 /g 0 27 /a 186 /g 53 27 /a 186 /g 0 28 /a 200 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 188
	exit /b
Rem Characters List Border
	:Characters_List_Border
	!Bb! /g 0 29 /c 0x!MenuBG!!MenuFG! /a 201 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 187 /a 201 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 187 /g 0 30 /a 186 /g 0 31 /a 186 /g 0 32 /a 186 /g 0 33 /a 186 /g 0 34 /a 186 /g 26 30 /a 186 /g 26 31 /a 186 /g 26 32 /a 186 /g 26 33 /a 186 /g 26 34 /a 186 /g 27 30 /a 186 /g 27 31 /a 186 /g 27 32 /a 186 /g 27 33 /a 186 /g 27 34 /a 186 /g 53 30 /a 186 /g 53 31 /a 186 /g 53 32 /a 186 /g 53 33 /a 186 /g 53 34 /a 186 /g 0 35 /a 200 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 188 /a 200 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 188 /d ""
	exit /b
Rem Characters List
	:Characters_List
	!Bb! /g 1 30 /c 0x0a /a 65 /a 32 /a 66 /a 32 /a 67 /a 32 /a 68 /a 32 /a 69 /a 32 /a 70 /a 32 /a 71 /a 32 /a 72 /a 32 /a 73 /a 32 /a 74 /a 32 /a 75 /a 32 /a 76 /a 32 /a 77 /g 1 31 /a 78 /a 32 /a 79 /a 32 /a 80 /a 32 /a 81 /a 32 /a 82 /a 32 /a 83 /a 32 /a 84 /a 32 /a 85 /a 32 /a 86 /a 32 /a 87 /a 32 /a 88 /a 32 /a 89 /a 32 /a 90 /g 1 32 /a 97 /a 32 /a 98 /a 32 /a 99 /a 32 /a 100 /a 32 /a 101 /a 32 /a 102 /a 32 /a 103 /a 32 /a 104 /a 32 /a 105 /a 32 /a 106 /a 32 /a 107 /a 32 /a 108 /a 32 /a 109 /g 1 33 /a 110 /a 32 /a 111 /a 32 /a 112 /a 32 /a 113 /a 32 /a 114 /a 32 /a 115 /a 32 /a 116 /a 32 /a 117 /a 32 /a 118 /a 32 /a 119 /a 32 /a 120 /a 32 /a 121 /a 32 /a 122 /g 1 34 /a 48 /a 32 /a 49 /a 32 /a 50 /a 32 /a 51 /a 32 /a 52 /a 32 /a 53 /a 32 /a 54 /a 32 /a 55 /a 32 /a 56 /a 32 /a 57 /g 28 30 /a 32 /a 32 /a 33 /a 32 /a 34 /a 32 /a 35 /a 32 /a 36 /a 32 /a 37 /a 32 /a 38 /a 32 /a 39 /a 32 /a 40 /a 32 /a 41 /a 32 /a 42 /a 32 /a 43 /a 32 /a 44 /g 28 31 /a 45 /a 32 /a 46 /a 32 /a 47 /a 32 /a 58 /a 32 /a 59 /a 32 /a 60 /a 32 /a 61 /a 32 /a 62 /a 32 /a 63 /a 32 /a 64 /a 32 /a 91 /a 32 /a 92 /a 32 /a 93 /g 28 32 /a 94 /a 32 /a 96 /a 32 /a 95 /a 32 /a 123 /a 32 /a 124 /a 32 /a 125 /a 32 /a 126 /a 32 /a 176 /a 32 /a 177 /a 32 /a 178 /a 32 /a 185 /a 32 /a 186 /a 32 /a 187 /g 28 33 /a 188 /a 32 /a 200 /a 32 /a 201 /a 32 /a 202 /a 32 /a 203 /a 32 /a 204 /a 32 /a 205 /a 32 /a 206 /a 32 /a 219 /a 32 /a 220 /a 32 /a 223 /a 32 /a 179 /a 32 /a 180 /g 28 34 /a 191 /a 32 /a 192 /a 32 /a 193 /a 32 /a 194 /a 32 /a 195 /a 32 /a 196 /a 32 /a 197 /a 32 /a 217 /a 32 /a 218 /a 32 /a 254 /a 32 /a 240 /a 32 /a 174 /a 32 /a 175z
	exit /b
Rem Color List
	:Color_List
	!Bb! /g 55 30 /c 0x00 /a 32 /c 0x00 /a 32 /c 0x10 /a 32 /c 0x00 /a 32 /c 0x20 /a 32 /c 0x00 /a 32 /c 0x30 /a 32 /c 0x00 /a 32 /c 0x40 /a 32 /c 0x00 /a 32 /c 0x50 /a 32 /c 0x00 /a 32 /c 0x60 /a 32 /c 0x00 /a 32 /c 0x70 /a 32 /g 55 31 /c 0x80 /a 32 /c 0x00 /a 32 /c 0x90 /a 32 /c 0x00 /a 32 /c 0xa0 /a 32 /c 0x00 /a 32 /c 0xb0 /a 32 /c 0x00 /a 32 /c 0xc0 /a 32 /c 0x00 /a 32 /c 0xd0 /a 32 /c 0x00 /a 32 /c 0xe0 /a 32 /c 0x00 /a 32 /c 0xf0 /a 32
	!Bb! /g 55 33 /c 0x00 /a 32 /c 0x00 /a 32 /c 0x10 /a 32 /c 0x00 /a 32 /c 0x20 /a 32 /c 0x00 /a 32 /c 0x30 /a 32 /c 0x00 /a 32 /c 0x40 /a 32 /c 0x00 /a 32 /c 0x50 /a 32 /c 0x00 /a 32 /c 0x60 /a 32 /c 0x00 /a 32 /c 0x70 /a 32 /g 55 34 /c 0x80 /a 32 /c 0x00 /a 32 /c 0x90 /a 32 /c 0x00 /a 32 /c 0xa0 /a 32 /c 0x00 /a 32 /c 0xb0 /a 32 /c 0x00 /a 32 /c 0xc0 /a 32 /c 0x00 /a 32 /c 0xd0 /a 32 /c 0x00 /a 32 /c 0xe0 /a 32 /c 0x00 /a 32 /c 0xf0 /a 32
	exit /b
Rem Color Menu
	:Color_Menu
	!Bb! /g 54 29 /c 0x!MenuBG!!MenuFG! /a 201 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 187
	!Bb! /c 0x!MenuBG!!MenuFG! /g 54 30 /a 186 /d & !Bb! /c 0x!MenuBG!!MenuFG! /g 70 30 /a 186
	!Bb! /c 0x!MenuBG!!MenuFG! /g 54 31 /a 186 /d & !Bb! /c 0x!MenuBG!!MenuFG! /g 70 31 /a 186

	!Bb! /g 54 32 /c 0x!MenuBG!!MenuFG! /a 204 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 185
	!Bb! /c 0x!MenuBG!!MenuFG! /g 54 33 /a 186 & !Bb! /c 0x!MenuBG!!MenuFG! /g 70 33 /a 186
	!Bb! /c 0x!MenuBG!!MenuFG! /g 54 34 /a 186 & !Bb! /c 0x!MenuBG!!MenuFG! /g 70 34 /a 186
	!Bb! /g 54 35 /c 0x!MenuBG!!MenuFG! /a 200 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 205 /a 188
	
	!Bb! /g 57 29 /c 0x!MenuBG!!MenuFG! /d "Fore-Ground"
	!Bb! /g 57 32 /c 0x!MenuBG!!MenuFG! /d "Back-Ground"
	
	exit /b
Rem Give Char
	:Give_Character
	if not !X! lss 1 (
		if not !Y! lss 30 (
			if not !X! gtr 52 (
				if not !Y! gtr 34 (
					Rem The Varriable MainChar Is Being Set To Ascii Values
					for /f "tokens=1-3 delims= " %%a in (!Chars.if!) do (
						if "!X!,!Y!"=="%%a,%%b" (set "MainChar=%%c")
					)
					exit /b 1
				) else (exit /b 0)
			) else (exit /b 0)
		) else (exit /b 0)
	) else (exit /b 0)
Rem Give Color
	:Give_Color
	if not !X! lss 55 (
		if not !Y! lss 30 (
			if not !X! gtr 69 (
				if not !Y! gtr 34 (
					Rem Color Foreground
					for /f "tokens=1-3 delims= " %%a in (!ColorsFG.if!) do (
						if "!X!,!Y!"=="%%a,%%b" (set "ColorFG=%%c")
					)
					Rem Color Background
					for /f "tokens=1-3 delims= " %%a in (!ColorsBG.if!) do (
						if "!X!,!Y!"=="%%a,%%b" (set "ColorBG=%%c")
					)
				) else (exit /b)
			) else (exit /b)
		) else (exit /b)
	) else (exit /b)

Rem Paint Brush 1 (Normal Brush)
	:Paint_Brush_1
	if "!Current_Brush!"=="1" (
		if not !X! lss 1 (
			if not !Y! lss 2 (
				if not !X! gtr 52 (
					if not !Y! gtr 27 (
						start /b !Bb! /g !X! !Y! /c 0x!ColorBG!!ColorFG! /a !MainChar!
						exit /b 1
					) else (exit /b 0)
				) else (exit /b 0)
			) else (exit /b 0)
		) else (exit /b 0)
	) else (exit /b 0)
Rem Paint Brush 2 (3x3 Brush)
	:Paint_Brush_2
	if "!Current_Brush!"=="2" (
		Rem center
		if not !X! lss 2 (
			if not !Y! lss 3 (
				if not !X! gtr 51 (
					if not !Y! gtr 26 (
						set /a "Minus_X=!X!-1"
						set /a "Minus_Y=!Y!-1"
						set /a "Plus_X=!X!+1"
						set /a "Plus_Y=!Y!+1"
						start /b !Bb! /c 0x!ColorBG!!ColorFG! /g !Minus_X! !Minus_Y! /a !MainChar! /g !X! !Minus_Y! /a !MainChar! /g !Plus_X! !Minus_Y! /a !MainChar! /g !Minus_X! !Y! /a !MainChar! /g !X! !Y! /a !MainChar! /g !Plus_X! !Y! /a !MainChar! /g !Minus_X! !Plus_Y! /a !MainChar! /g !X! !Plus_Y! /a !MainChar! /g !Plus_X! !Plus_Y! /a !MainChar!
						exit /b 1
					)
				)
			)
		)
		Rem right side
		if "!X!"=="52" (
			if not !Y! gtr 26 (
				if not !Y! lss 3 (
					set /a "Minus_Y=!Y!-1"
					set /a "Plus_Y=!Y!+1"
					set /a "Minus_X=!X!-1"
					start /b !Bb! /c 0x!ColorBG!!ColorFG! /g !Minus_X! !Minus_Y! /a !MainChar! /g !X! !Minus_Y! /a !MainChar! /g !Minus_X! !Y! /a !MainChar! /g !X! !Y! /a !MainChar! /g !Minus_X! !Plus_Y! /a !MainChar! /g !X! !Plus_Y! /a !MainChar!
					exit /b 1
				)
			)
		)
		Rem left side
		if "!X!"=="1" (
			if not !Y! gtr 26 (
				if not !Y! lss 3 (
					set /a "Minus_Y=!Y!-1"
					set /a "Plus_Y=!Y!+1"
					set /a "Plus_X=!X!+1"
					start /b !Bb! /c 0x!ColorBG!!ColorFG! /g !Plus_X! !Minus_Y! /a !MainChar! /g !X! !Minus_Y! /a !MainChar! /g !Plus_X! !Y! /a !MainChar! /g !X! !Y! /a !MainChar! /g !Plus_X! !Plus_Y! /a !MainChar! /g !X! !Plus_Y! /a !MainChar!
					exit /b 1
				)
			)
		)
		Rem bottom side
		if "!Y!"=="27" (
			if not !X! gtr 51 (
				if not !X! lss 2 (
					set /a "Minus_Y=!Y!-1"
					set /a "Minus_X=!X!-1"
					start /b !Bb! /c 0x!ColorBG!!ColorFG! /g !Minus_X! !Y! /a !MainChar! /a !MainChar! /a !MainChar! /g !Minus_X! !Minus_Y! /a !MainChar! /a !MainChar! /a !MainChar!
					exit /b 1
				)
			)
		)
		Rem top side
		if "!Y!"=="2" (
			if not !X! gtr 51 (
				if not !X! lss 2 (
					set /a "Plus_Y=!Y!+1"
					set /a "Minus_X=!X!-1"
					start /b !Bb! /c 0x!ColorBG!!ColorFG! /g !Minus_X! !Y! /a !MainChar! /a !MainChar! /a !MainChar! /g !Minus_X! !Plus_Y! /a !MainChar! /a !MainChar! /a !MainChar!
					exit /b 1
				)
			)
		)
		Rem top left corner
		if "!X!"=="1" (
			if "!Y!"=="2" (
				start /b !Bb! /c 0x!ColorBG!!ColorFG! /g 1 2 /a !MainChar! /a !MainChar! /g 1 3 /a !MainChar! /a !MainChar!
				exit /b 1
			)
		)
		rem bottom left corner
		if "!X!"=="1" (
			if "!Y!"=="27" (
				start /b !Bb! /c 0x!ColorBG!!ColorFG! /g 1 27 /a !MainChar! /a !MainChar! /g 1 26 /a !MainChar! /a !MainChar!
				exit /b 1
			)
		)
		Rem bottom right corner
		if "!X!"=="52" (
			if "!Y!"=="27" (
				start /b !Bb! /c 0x!ColorBG!!ColorFG! /g 51 27 /a !MainChar! /a !MainChar! /g 51 26 /a !MainChar! /a !MainChar!
				exit /b 1
			)
		)
		Rem top right corner
		if "!X!"=="52" (
			if "!Y!"=="2" (
				start /b !Bb! /c 0x!ColorBG!!ColorFG! /g 51 2 /a !MainChar! /a !MainChar! /g 51 3 /a !MainChar! /a !MainChar!
				exit /b 1
			)
		)

		exit /b 0
	) else (exit /b 0)
Rem Paint Brush 3 (wide Brush)
	:Paint_Brush_3
	if "!Current_Brush!"=="3" (
		if not !X! lss 2 (
			if not !Y! lss 2 (
				if not !X! gtr 51 (
					if not !Y! gtr 27 (
						set /a "Plus_X=!X!+1"
						set /a "Minus_X=!X!-1"
						start /b !Bb! /c 0x!ColorBG!!ColorFG! /g !Minus_X! !Y! /a !MainChar! /g !X! !Y! /a !MainChar! /g !Plus_X! !Y! /a !MainChar!
						exit /b 1
					) else (exit /b 0)
				) else (exit /b 0)
			) else (exit /b 0)
		) else (exit /b 0)
	)
Rem Paint Brush 4 (Tall Brush)
	:Paint_Brush_4
	if "!Current_Brush!"=="4" (
		if not !X! lss 1 (
			if not !Y! lss 3 (
				if not !X! gtr 52 (
					if not !Y! gtr 26 (
						set /a "Plus_Y=!Y!+1"
						set /a "Minus_Y=!Y!-1"
						start /b !Bb! /c 0x!ColorBG!!ColorFG! /g !X! !Minus_Y! /a !MainChar! /g !X! !Y! /a !MainChar! /g !X! !Plus_Y! /a !MainChar!
						exit /b 1
					) else (exit /b 0)
				) else (exit /b 0)
			) else (exit /b 0)
		) else (exit /b 0)
	) else (exit /b 0)
